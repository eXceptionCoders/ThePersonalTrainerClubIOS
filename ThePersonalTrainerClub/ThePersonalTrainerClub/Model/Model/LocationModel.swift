//
//  Location.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct LocationModel: Codable {
    let id: String
    let type: String
    let coordinates: [Float]
    let description: String
}
