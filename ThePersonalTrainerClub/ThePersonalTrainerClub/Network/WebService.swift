//
//  WebService.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 07/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum WebServiceError: Error {
    case badRequest
    case requestError
    case notFound
    case unprocessableEntity
    case decodingError
    case unauthorized
    case forbiddenError
    case internalServerError
    case genericError
}

final class WebService {
    private let configuration: URLSessionConfiguration = .default
    private let session = URLSession(configuration: .default)
    private let decoder = JSONDecoder()
    
    private var task: URLSessionDataTask?
    
    func load<T: Decodable>(_ type: T.Type, from endpoint: Endpoint, completion: @escaping (T?, Error?) -> Void) -> Void {
        task?.cancel()
        
        guard let request = endpoint.request() else {
            completion(nil, WebServiceError.requestError)
            return
        }
        
        task = session.dataTask(with: request) { data, response, error in
            defer { self.task = nil }

            var e: Error? = nil
            var v: T? = nil
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(v, error)
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                do {
                    v = try self.decoder.decode(type, from: data)
                } catch {
                    e = WebServiceError.decodingError
                }
                
                NotificationCenter.default.post(
                    name: .WebServiceDidReceiveData,
                    object: self,
                    userInfo: ["statusCode" : httpResponse.statusCode])
                
                switch httpResponse.statusCode {
                case 200, 201:
                    break
                case 400:
                    e = WebServiceError.badRequest
                case 401:
                    e = WebServiceError.unauthorized
                case 403:
                    e = WebServiceError.forbiddenError
                case 404:
                    e = WebServiceError.notFound
                case 422:
                    e = WebServiceError.unprocessableEntity
                case 500:
                    e = WebServiceError.internalServerError
                default:
                    e = WebServiceError.genericError
                }
            } else {
                e = WebServiceError.genericError
            }
            
            DispatchQueue.main.async {
                completion(v, e)
            }
        }
        
        task?.resume()
    }
}

extension Notification.Name {
    static let WebServiceDidReceiveData = NSNotification.Name("webServiceDidReceiveData")
}
