//
//  LocationEntity.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct LocationEntity: Decodable {
    let type: String
    let description: String
    let coordinates: [Float]
}
