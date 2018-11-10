//
//  SignupEntity.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 10/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

struct RegisterRequest {
    let nameKey = "name"
    let name: String
    
    let lastNameKey = "lastName"
    let lastName: String
    
    let birthdayKey = "birthday"
    let birthday: String
    
    let genderKey = "gender"
    let gender: String
    
    let emailKey = "email"
    let email: String
    
    let passwordKey = "password"
    let password: String
}

struct SignupResponse: Decodable {}
