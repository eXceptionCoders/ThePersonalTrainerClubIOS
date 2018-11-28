//
//  NewClassModel.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 25/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct NewClassModel: Codable {
    let instructor: String
    let sport: String
    let location: LocationModel
    let description: String
    let price: Float
    let quota: Int
    let duration: Int
}
