//
//  Endpoint.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 07/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

// private var baseURL = "http://localhost:3000"
private var baseURL = "https://thepersonaltrainerclubapi-dev.azurewebsites.net"

enum Endpoint {
    // Login & Register
    case login(requestModel: LoginRequest)
    case register(requestModel: RegisterRequest)
    // User methods
    case userData(requestModel: UserRequest)
    case setUserThumbnail(requestModel: SetUserThumbnailRequest)
    // Class methods
    case newClass(requestModel: NewClassRequest)
    case findClasses(requestModel: FindClasesRequest)
    // Activities
    case sports(requestModel: SportRequest)
    case setSports(requestModel: SetSportRequest)
    // Location
    case deleteLocation(requestModel: DeleteLocationRequest)
    case addLocation(requestModel: AddLocationRequest)
}

extension Endpoint {
    func request() -> URLRequest? {
        guard let url = URL(string: baseURL + path) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        let boundary = generateBoundaryString()
        let token = UserSettings.token
        
        switch self.contentType {
        case .form:
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        default:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        request.setValue(token, forHTTPHeaderField: "x-access-token")
        
        request.httpMethod = self.method.rawValue
        
        do {
            if (self.method == HTTPMethod.post) {
                switch self {
                case .setUserThumbnail(let requestModel):
                    var body = Data()
                    let filename = "user-profile.jpg"
                    let mimetype = "image/jpg"
                    body.append(Data("--\(boundary)\r\n".utf8))
                    body.append(Data("Content-Disposition: form-data; name=\"\(requestModel.imageKey)\"; filename=\"\(filename)\"\r\n".utf8))
                    body.append(Data("Content-Type: \(mimetype)\r\n\r\n".utf8))
                    body.append(requestModel.image)
                    body.append(Data("\r\n".utf8))
                    body.append(Data("--\(boundary)--\r\n".utf8))
                    
                    request.httpBody = body
                    
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
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
}

private enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

private enum HTTPContentType: String {
    case json = "json"
    case form = "form"
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
        case .setUserThumbnail(_):
            return .post
        case .newClass(_):
            return .post
        case .findClasses(_):
            return .get
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
    
    var contentType: HTTPContentType {
        switch self {
        case .login(_):
            return .json
        case .register(_):
            return .json
        case .userData(_):
            return .json
        case .setUserThumbnail(_):
            return .form
        case .newClass(_):
            return .json
        case .findClasses(_):
            return .json
        case .sports(_):
            return .json
        case .setSports(_):
            return .json
        case .deleteLocation(_):
            return .json
        case .addLocation(_):
            return .json
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
            
        case .setUserThumbnail(_):
            return "/api/v1/es/datauser/thumbnail"
            
        case .newClass(_):
            return "/api/v1/es/class/add"
            
        case .findClasses(let requestModel):
            var params: [String] = [
                "page=\(requestModel.page)",
                "per_page=\(requestModel.perPage)"
            ];
            
            if (!requestModel.sport.isEmpty) {
                params.append("sport=\(requestModel.sport)")
            }
            
            if (!requestModel.longitude.isZero && requestModel.longitude.isFinite) {
                params.append("longitude=\(requestModel.longitude)")
            }
            
            if (!requestModel.latitude.isZero && requestModel.latitude.isFinite) {
                params.append("latitude=\(requestModel.latitude)")
            }
            
            if (requestModel.distance != 0) {
                params.append("distance=\(requestModel.distance)")
            }
            
            if (!requestModel.price.isEmpty) {
                params.append("price=\(requestModel.price)")
            }
            
            return "/api/v1/es/class/find?\(params.joined(separator: "&"))"
            
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
            return [
                requestModel.descriptionKey: requestModel.description,
                requestModel.longitudeKey: String(requestModel.longitude),
                requestModel.latitudeKey: String(requestModel.latitude)
            ]
            
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
