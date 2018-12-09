//
//  SetUserThumbnailRequest.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 09/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct SetUserThumbnailRequest: Decodable, Encodable {
    let imageKey = "image"
    let image: Data
}

struct SetUserThumbnailResponse: BaseResponse {
    var version: String
    var status: String
    var message: String
    var datetime: String
    var error: [String: String]?
}
