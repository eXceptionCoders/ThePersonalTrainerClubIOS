//
//  BaseResponse.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 10/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

protocol BaseResponse: Decodable {
    var version: String { get set }
    var status: String { get set }
    var message: String { get set }
    var datetime: String { get set }
}

