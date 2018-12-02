//
//  LocationEntity.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct LocationEntity: Decodable, Encodable {
    let _id: String
    let type: String
    let description: String
    let coordinates: [Float]
}

struct DeleteLocationRequest {
    let idKey = "id"
    let id: String
}

struct DeleteLocationResponse: BaseResponse {
    var version: String
    var status: String
    var message: String
    var datetime: String
    var error: [String: String]?
}
