//
//  Endpoint.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 07/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

private var baseURL = "https://thepersonaltrainerclubapi-dev.azurewebsites.net"

enum Endpoint {
    // Login & Register
    case login(requestModel: LoginRequest)
    case register(requestModel: RegisterRequest)
    // User methods
    case userData(requestModel: UserRequest)
    // Class methods
    case newClass(requestModel: NewClassRequest)
    // Activities
    case sports(requestModel: SportRequest)
    case setSports(requestModel: SetSportRequest)
    //Location
    case deleteLocation(requestModel: DeleteLocationRequest)
    case addLocation(requestModel: AddLocationRequest)
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
                case .setSports(let requestModel):
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
        case .sports(_):
            return .get
        case .setSports(_):
            return .post
        case .deleteLocation(_):
            return .post
        case .addLocation(_):
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .login(_):
            return "/api/v1/es/users/login"
            
        case .register(_):
            return "/api/v1/es/users/signup"

        case .userData(_):
            return "/api/v1/es/datauser"
            
        case .newClass(_):
            return "/api/v1/es/class/add"
            
        case .sports(_):
            return "/api/v1/es/sports"
            
        case .setSports(_):
            return "/api/v1/es/sports/update"
            
        case .deleteLocation(_):
            return "/api/v1/es/location/delete"
            
        case .addLocation(_):
            return "/api/v1/es/location/add"
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

        /*
        case .setSports(let requestModel):
            return [requestModel.sports: requestModel.sports]
        */

        case .deleteLocation(let requestModel):
            return [requestModel.idKey : requestModel.id]
            
        case .addLocation(let requestModel):
            return [
                requestModel.descriptionKey: requestModel.description,
                requestModel.longitudeKey: String(requestModel.longitude),
                requestModel.latitudeKey: String(requestModel.latitude)
            ]
            
        default:
            return [:]
        }
    }
}
