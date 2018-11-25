//
//  ActivityEntity.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct SportRequest {
}

struct SportResponse: BaseResponse {
    var version: String
    var status: String
    var message: String
    var datetime: String
    var data: [SportEntity];
    var error: [String: String]
}

struct SportEntity: Decodable, Encodable {
    let _id: String
    let name: String
    // let category: String?
    let icon: String
}
