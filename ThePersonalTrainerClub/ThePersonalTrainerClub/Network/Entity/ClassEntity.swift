//
//  ClassEntity.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 07/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

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
    let distance: Double?
    let booking: String?
}

struct TrainerEntity: Decodable, Encodable {
    let _id: String
    let name: String
    let lastname: String
    let thumbnail: String?
}
