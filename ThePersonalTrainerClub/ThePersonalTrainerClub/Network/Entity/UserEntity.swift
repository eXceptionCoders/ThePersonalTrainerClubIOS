//
//  TrainerEntity.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct UserRequest {
    let idKey = "id"
    let id: String
}

struct UserResponse: BaseResponse {
    var version: String
    var status: String
    var message: String
    var datetime: String
    var data: UserEntity;
    var error: [String: String]
}

struct UserEntity: Decodable {
    let _id: String
    let name: String
    let lastName: String
    let email: String
    let birthday: String
    let gender: String
    let thumbnail: String
    let locations: [LocationEntity]
    let activities: [ActivityEntity]
    let description: String
}
