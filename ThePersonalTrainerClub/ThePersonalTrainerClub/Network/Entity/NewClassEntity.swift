//
//  ClassEntity.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct NewClassRequest {
    let nameKey = "name"
    let name: String
    
    let descriptionKey = "description"
    let description: String
    
    let priceKey = "priceKey"
    let price: Decimal
    
    let photoKey = "photo"
    let photo: String
    
    let quotaKey = "quota"
    let quota: Int
}

struct NewClassResponse: BaseResponse {
    var version: String
    var status: String
    var message: String
    var datetime: String
    var error: [String: String]
}
