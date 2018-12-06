//
//  SetSportRequest.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 29/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct SetSportRequest: Decodable, Encodable {
    let sports: [String]
}

struct SetSportResponse: BaseResponse {
    var version: String
    var status: String
    var message: String
    var datetime: String
    var data: String?
    var error: [String: String]?
}
