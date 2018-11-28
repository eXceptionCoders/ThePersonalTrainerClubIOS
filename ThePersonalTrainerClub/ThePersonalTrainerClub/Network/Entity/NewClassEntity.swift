//
//  ClassEntity.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct NewClassRequest: Decodable, Encodable {
    let instructor: String
    let sport: String
    let location: LocationEntity
    let description: String
    let price: Float
    let duration: Int
    let quota: Int
}

struct NewClassResponse: BaseResponse {
    var version: String
    var status: String
    var message: String
    var datetime: String
    var error: [String: String]?
}
