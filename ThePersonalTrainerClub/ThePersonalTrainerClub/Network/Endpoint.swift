//
//  Endpoint.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 07/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

private var baseURL = "https://thepersonaltrainerclubapi.azurewebsites.net"

enum Endpoint {
    case login(requestModel: LoginRequest)
    case signup(requestModel: SignupRequest)
}

extension Endpoint {
    func request() -> URLRequest? {
        guard let url = URL(string: baseURL + path) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = self.method.rawValue
        
        do {
            let postBody = try JSONEncoder().encode(self.parameters)
            request.httpBody = postBody
        } catch {
            return nil
        }
        
        return request
    }
}

private enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

private extension Endpoint {
    var method: HTTPMethod {
        switch self {
        case .login(_):
            return .post
        case .signup(_):
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .login(_):
            return "/api/v1/es/users/login"
            
        case .signup(_):
            return "/api/v1/es/users/signup"
        }
    }

    var parameters: [String: String] {
        switch self {
        case .login(let requestModel):
            return [
                requestModel.emailKey: requestModel.email,
                requestModel.passwordKey: requestModel.password
            ]
            
        case .signup(let requestModel):
            return [
                requestModel.birthdayKey: requestModel.birthday,
                requestModel.emailKey: requestModel.email,
                requestModel.genderKey: requestModel.gender,
                requestModel.lastNameKey: requestModel.lastName,
                requestModel.nameKey: requestModel.name,
                requestModel.passwordKey: requestModel.password,
            ]
        }
    }
}
