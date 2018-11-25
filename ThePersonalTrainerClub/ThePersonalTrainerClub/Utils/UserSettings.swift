//
//  UserSettings.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

final class UserSettings {
    
    private static var _user: UserModel?;
    
    static var token: String {
        get {
            let value = UserDefaults.standard.string(forKey: "token") ?? ""
            return value
        }
        set(newValue) {
             UserDefaults.standard.set(newValue, forKey: "token")
        }
    }
    
    static var user: UserModel? {
        get {
            guard let data = _user else {
                if let savedUser = UserDefaults.standard.object(forKey: "user") as? Data {
                    let decoder = JSONDecoder()
                    if let loadedUser = try? decoder.decode(UserModel.self, from: savedUser) {
                        _user = loadedUser
                        return _user
                    } else {
                        return nil
                    }
                } else {
                    return nil
                }
            }
            
            return data
        }
        set(newValue) {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: "user")
            }
        }
    }
}
