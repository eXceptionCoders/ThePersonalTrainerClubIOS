//
//  LoginEntity.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 08/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct LoginRequest {
    let emailKey = "email"
    let email: String
    let passwordKey = "password"
    let password: String
}

struct LoginResponse: BaseResponse {
    var version: String
    var status: String
    var message: String
    var datetime: String
    var data: LoginEntity?;
    var error: [String: String]?
}

struct LoginEntity: Decodable {
    let token: String
}
