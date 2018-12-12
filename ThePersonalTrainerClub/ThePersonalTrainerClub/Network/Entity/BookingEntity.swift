//
//  BookingEntity.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct BookingRequest {
    let classIdKey = "class"
    let classId: String
}

struct BookingResponse: BaseResponse {
    var version: String
    var status: String
    var message: String
    var datetime: String
    var error: [String: String]?
}
