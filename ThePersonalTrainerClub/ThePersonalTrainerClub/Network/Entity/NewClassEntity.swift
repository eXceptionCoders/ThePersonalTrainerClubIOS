//
//  ClassEntity.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct NewClassRequest {
    let instructorKey = "instructor"
    let instructor: String
    
    let sportKey = "sport"
    let sport: String
    
    let locationKey = "location"
    let location: LocationEntity
    
    let descriptionKey = "description"
    let description: String
    
    let priceKey = "priceKey"
    let price: Float
    
    let durationKey = "duration"
    let duration: Int
    
    let quotaKey = "quota"
    let quota: Int
}

struct NewClassResponse: BaseResponse {
    var version: String
    var status: String
    var message: String
    var datetime: String
    var error: [String: String]?
}
