//
//  UserDefaultsHelper.swift
//  Vollmed
//
//  Created by Juliano Sgarbossa on 23/07/25.
//

import Foundation

struct UserDefaultsHelper {
    
    static func save(value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func get(key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    static func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
