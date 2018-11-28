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
    case sports(requestModel: SportRequest)
}

extension Endpoint {
    func request() -> URLRequest? {
        guard let url = URL(string: baseURL + path) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UserSettings.token, forHTTPHeaderField: "x-access-token")
        
        request.httpMethod = self.method.rawValue
        
        do {
            if (self.method == HTTPMethod.post) {
                switch self {
                case .newClass(let requestModel):
                    let postBody = try JSONEncoder().encode(requestModel)
                    request.httpBody = postBody
                default:
                    let postBody = try JSONEncoder().encode(self.parameters)
                    request.httpBody = postBody
                }
            }
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
        case .sports(_):
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .login(_):
            return "/api/v1/es/users/login"
            
        case .register(_):
            return "/api/v1/es/users/signup"

        case .userData(_):
            return "/api/v1/es/data/user"
            
        case .newClass(_):
            return "/api/v1/es/class/add"
            
        case .trainerClasses(let requestModel):
            return "TODO: /api/v1/es/classes/trainers/\(requestModel.trainerId)"
            
        case .sports(_):
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
                requestModel.coachKey: String( requestModel.coach ),
                requestModel.passwordKey: requestModel.password,
            ]
            
        case .userData(_):
            return [:]
            
        /*
        case .newClass(let requestModel):
            return [
                requestModel.instructorKey: requestModel.instructor,
                requestModel.sportKey: requestModel.sport,
                requestModel.locationKey: "{type: \"\(requestModel.location.type)\", description: \"\(requestModel.location.description)\", coordinates: [\(requestModel.location.coordinates[0]),\(requestModel.location.coordinates[1])]}",
                requestModel.descriptionKey: requestModel.description,
                requestModel.priceKey: "\(requestModel.price)",
                requestModel.quotaKey: "\(requestModel.quota)",
                requestModel.durationKey: "\(requestModel.duration)"
            ]
        */

        case .trainerClasses(_):
            return [:]
            
        case .sports(_):
            return [:]
            
        default:
            return [:]
        }
    }
}
