//
//  BookingProvider.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum BookingError: Error {
    case notFound
    case unauthorized
    case forbiddenError
    case unprocessableEntity
    case otherError
}

class BookingProvider {
    private let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func book(classId: String, completion: @escaping (Bool, Error?, [String: String]?) -> Void) {
        webService.load(BookingResponse.self, from: Endpoint.book(requestModel: BookingRequest(classId: classId) )) { responseObject, error in
            if let error = error {
                switch error {
                    
                case WebServiceError.unauthorized:
                    completion(false, BookingError.unauthorized, responseObject?.error)
                case WebServiceError.forbiddenError:
                    completion(false, BookingError.forbiddenError, responseObject?.error)
                case WebServiceError.unprocessableEntity:
                    completion(false, BookingError.unprocessableEntity, responseObject?.error)
                default:
                    completion(false, BookingError.otherError, responseObject?.error)
                }
            } else {
                completion(true, nil, nil)
            }
        }
    }
    
    func deleteBooking(bookId: String, completion: @escaping (Bool, Error?, [String: String]?) -> Void) {
        webService.load(DeleteBookingResponse.self, from: Endpoint.deleteBooking(requestModel: DeleteBookingRequest(id: bookId) )) { responseObject, error in
            if let error = error {
                switch error {
                    
                case WebServiceError.unauthorized:
                    completion(false, BookingError.unauthorized, responseObject?.error)
                case WebServiceError.forbiddenError:
                    completion(false, BookingError.forbiddenError, responseObject?.error)
                case WebServiceError.unprocessableEntity:
                    completion(false, BookingError.unprocessableEntity, responseObject?.error)
                default:
                    completion(false, BookingError.otherError, responseObject?.error)
                }
            } else {
                completion(true, nil, nil)
            }
        }
    }
}
