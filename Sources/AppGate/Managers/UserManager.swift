//
//  UserManager.swift
//  
//
//  Created by Diego Giraldo Gómez on 24/04/21.
//

import Foundation
import KeychainAccess

struct UserManager {
    let keychain = Keychain(service: Constants.bundleID)
    
    func validateUser(user: User, date: Date) -> Bool {
        let items = keychain.allItems()
        for item in items {
          print("item: \(item)")
        }
        let password = keychain[user.username]
        let status = password == user.password ? true : false
        
        let validation = Validation(username: user.username, date: date, status: status)
        DataManager().saveValidation(validation: validation)
        
        return status
    }
    
    func createUser(_ user: User) {
        keychain[user.username] = user.password
    }
}
