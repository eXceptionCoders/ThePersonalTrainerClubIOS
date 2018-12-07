//
//  FindClasses.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 07/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct FindClasesRequest {
    let sport: String
    let longitude: Double
    let latitude: Double
    let distance: Int
    let price: String
    let page: Int
    let perPage: Int
}

struct FindClasesResponse: BaseResponse {
    var version: String
    var status: String
    var message: String
    var datetime: String
    var data: [ClassEntity]?;
    var total: Int?
    var error: [String: String]?
}
