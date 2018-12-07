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
    private static var _lastQuery: ClassFinderQuery?
    
    static var token: String {
        get {
            let value = UserDefaults.standard.string(forKey: "token") ?? ""
            return value
        }
        set(newValue) {
             UserDefaults.standard.set(newValue, forKey: "token")
        }
    }
    
    static var showCoachView: Bool {
        get {
            let value = UserDefaults.standard.bool(forKey: "showCoachView")
            return value
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "showCoachView")
        }
    }
    
    static var lastQuery: ClassFinderQuery? {
        get {
            guard let data = _lastQuery else {
                if let savedQuery = UserDefaults.standard.object(forKey: "query") as? Data {
                    let decoder = JSONDecoder()
                    if let loadedQuery = try? decoder.decode(ClassFinderQuery.self, from: savedQuery) {
                        _lastQuery = loadedQuery
                        return _lastQuery
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
            if let newValue = newValue {
                _lastQuery = newValue
                
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(newValue) {
                    UserDefaults.standard.set(encoded, forKey: "query")
                }
            } else {
                UserDefaults.standard.removeObject(forKey: "query")
                _lastQuery = nil
            }
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
            if let newValue = newValue {
                _user = newValue
                
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(newValue) {
                    UserDefaults.standard.set(encoded, forKey: "user")
                }
            } else {
                UserDefaults.standard.removeObject(forKey: "user")
                _user = nil
            }
        }
    }
}
