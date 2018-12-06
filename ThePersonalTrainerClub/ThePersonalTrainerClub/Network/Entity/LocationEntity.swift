//
//  LocationEntity.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct LocationEntity: Decodable, Encodable {
    let type: String
    let description: String?
    let coordinates: [Double]
}

struct DeleteLocationRequest {
    let descriptionKey = "description"
    let description: String
    let longitudeKey = "longitude"
    let longitude: Double
    let latitudeKey = "latitude"
    let latitude: Double
}

struct DeleteLocationResponse: BaseResponse {
    var version: String
    var status: String
    var message: String
    var datetime: String
    var error: [String: String]?
}

struct AddLocationRequest {
    let descriptionKey = "description"
    let description: String
    let longitudeKey = "longitude"
    let longitude: Double
    let latitudeKey = "latitude"
    let latitude: Double
}

struct AddLocationResponse: BaseResponse {
    var version: String
    var status: String
    var message: String
    var datetime: String
    var error: [String: String]?
}
