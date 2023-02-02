//
//  UserManager.swift
//  collectNotes
//
//  Created by MD Faizan on 07/01/23.
//

import Foundation
import GoogleSignIn
import Firebase

class UserManager {
    
    static let shared = UserManager()
    
    
    func saveToken(token: String?) {
        UserDefaults.standard.set(token, forKey: UserDefaultsKey.uid)
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.uid)
    }
    
    func isUserLoggedIn() -> Bool {
       
        return Auth.auth().currentUser?.uid != nil
    }
    
    func getToken() -> String? {
       return UserDefaults.standard.string(forKey: UserDefaultsKey.uid)
    }
}
