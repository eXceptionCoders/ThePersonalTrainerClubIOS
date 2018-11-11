//
//  UserSettings.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

final class UserSettings {
    
    var token: String {
        get {
            return UserDefaults.standard.string(forKey: "token") ?? ""
        }
        set(newValue) {
             UserDefaults.standard.set(token, forKey: "token")
        }
    }
    
    var isTrainer: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isTrainer")
        }
        set {
            UserDefaults.standard.set(isTrainer, forKey: "isTrainer")
        }
    }
}
