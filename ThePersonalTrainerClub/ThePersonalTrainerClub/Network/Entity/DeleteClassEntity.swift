//
//  DeleteClassEntity.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct DeleteClassRequest {
    let idKey = "id"
    let id: String
}

struct DeleteClassResponse: BaseResponse {
    var version: String
    var status: String
    var message: String
    var datetime: String
    var error: [String: String]?
}
