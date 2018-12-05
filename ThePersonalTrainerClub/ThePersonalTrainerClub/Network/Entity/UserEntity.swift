//
//  TrainerEntity.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct UserRequest {
}

struct UserResponse: BaseResponse {
    var version: String
    var status: String
    var message: String
    var datetime: String
    var data: UserEntity?;
    var error: [String: String]?
}

struct UserEntity: Decodable, Encodable {
    let _id: String
    let coach: Bool
    let name: String
    let lastname: String?
    let gender: String
    let email: String
    let thumbnail: String?
    let locations: [LocationEntity]?
    let sports: [SportEntity]?
    let classes: [ClassEntity]?
    let activeBookings: [ClassEntity]?
}

struct ClassEntity: Decodable, Encodable {
    let _id: String
    let instructor: TrainerEntity
    let sport: SportEntity
    let location: LocationEntity
    let description: String
    let place: String
    let price: Float
    let maxusers: Int
    let duration: Int
    let registered: Int?
}

struct TrainerEntity: Decodable, Encodable {
    let _id: String
    let name: String
    let lastname: String
    let thumbnail: String
}
