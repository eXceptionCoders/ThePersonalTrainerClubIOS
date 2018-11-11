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
    var data: [ClassEntity]
    var error: [String: String]
}

struct ClassEntity: Decodable {
    let _id: String
    let name: String
    let description: String
    let price: Decimal
    let photo: String
    let quota: Int
}
