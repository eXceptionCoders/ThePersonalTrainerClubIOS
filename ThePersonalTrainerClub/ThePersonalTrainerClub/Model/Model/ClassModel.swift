//
//  Class.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct ClassModel: Codable {
    let id: String
    let sport: ActivityModel
    let location: LocationModel
    let description: String
    let price: Float
    let quota: Int
    let duration: Int
    let registered: Int?
    let instructor: TrainerModel?
}

struct TrainerModel: Decodable, Encodable {
    let id: String
    let name: String
    let lastname: String
    let thumbnail: String
}
