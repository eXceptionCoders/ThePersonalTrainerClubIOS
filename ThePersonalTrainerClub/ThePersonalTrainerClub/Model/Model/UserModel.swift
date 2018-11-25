//
//  UserModel.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct UserModel: Codable {
    let id: String
    let name: String
    let lastName: String
    let birthday: String
    let gender: String
    let thumbnail: String
    let email: String
    let locations: [LocationModel]
    let activities: [ActivityModel]
    let description: String
}
