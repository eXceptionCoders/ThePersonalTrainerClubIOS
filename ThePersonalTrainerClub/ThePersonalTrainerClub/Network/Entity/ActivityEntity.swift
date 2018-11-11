//
//  ActivityEntity.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct ActivitiesRequest {
}

struct ActivitiesResponse: BaseResponse {
    var version: String
    var status: String
    var message: String
    var datetime: String
    var data: [ActivityEntity];
    var error: [String: String]
}

struct ActivityEntity: Decodable {
    let _id: String
    let name: String
    let description: String
    let category: String
    let thumbnail: String
}
