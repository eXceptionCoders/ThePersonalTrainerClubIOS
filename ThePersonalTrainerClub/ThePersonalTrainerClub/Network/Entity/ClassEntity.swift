//
//  ClassEntity.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct TrainerClassRequest {
    let trainerIdKey = "trainerId"
    let trainerId: String
}

struct TrainerClassResponse: BaseResponse {
    var version: String
    var status: String
    var message: String
    var datetime: String
    var data: [TrainerClassEntity]?
    var error: [String: String]?
}

struct AthleteClassResponse: BaseResponse {
    var version: String
    var status: String
    var message: String
    var datetime: String
    var data: [AthleteClassEntity]?
    var error: [String: String]?
}

struct TrainerEntity: Decodable, Encodable {
    let _id: String
    let name: String
    let lastname: String
    let thumbnail: String
}

struct TrainerClassEntity: Decodable, Encodable {
    let _id: String
    let sport: SportEntity
    let location: LocationEntity
    let description: String
    let price: Float
    let duration: Int
    let quota: Int
}

struct AthleteClassEntity: Decodable, Encodable {
    let _id: String
    let sport: SportEntity
    let location: LocationEntity
    let description: String
    let price: Float
    let duration: Int
    let quota: Int
    let registered: Int?
    let instructor: TrainerEntity
}
