//
//  Endpoint.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 07/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

private var baseURL = "https://thepersonaltrainerappapi.azurewebsites.net"

enum Endpoint {
    // Login & Register
    case login(requestModel: LoginRequest)
    case register(requestModel: RegisterRequest)
    // User methods
    case userData(requestModel: UserRequest)
    // Class methods
    case newClass(requestModel: NewClassRequest)
    case trainerClasses(requestModel: TrainerClassRequest)
    // Activities
    case activities(requestModel: ActivitiesRequest)
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
        case .register(_):
            return .post
        case .userData(_):
            return .get
        case .newClass(_):
            return .post
        case .trainerClasses(_):
            return .get
        case .activities(_):
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .login(_):
            return "/api/v1/es/users/login"
            
        case .register(_):
            return "/api/v1/es/users/signup"

        case .userData(let requestModel):
            return "TODO: /api/v1/es/trainers/\(requestModel.id)"
            
        case .newClass(_):
            return "TODO: /api/v1/es/classes/new"
            
        case .trainerClasses(let requestModel):
            return "TODO: /api/v1/es/classes/trainers/\(requestModel.trainerId)"
            
        case .activities(_):
            return "TODO: /api/v1/es/activities"
        }
    }

    var parameters: [String: String] {
        switch self {
        case .login(let requestModel):
            return [
                requestModel.emailKey: requestModel.email,
                requestModel.passwordKey: requestModel.password
            ]
            
        case .register(let requestModel):
            return [
                requestModel.birthdayKey: requestModel.birthday,
                requestModel.emailKey: requestModel.email,
                requestModel.genderKey: requestModel.gender,
                requestModel.lastNameKey: requestModel.lastName,
                requestModel.nameKey: requestModel.name,
                requestModel.passwordKey: requestModel.password,
            ]
            
        case .userData(_):
            return [:]
            
        case .newClass(let requestModel):
            return [
                requestModel.nameKey: requestModel.name,
                requestModel.descriptionKey: requestModel.description,
                requestModel.priceKey: "\(requestModel.price)",
                requestModel.quotaKey: "\(requestModel.quota)",
                requestModel.photoKey: requestModel.photo
            ]
            
        case .trainerClasses(_):
            return [:]
            
        case .activities(_):
            return [:]
        }
    }
}
