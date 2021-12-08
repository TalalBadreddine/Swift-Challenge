//
//  FireBaseManager.swift
//  Swift-Challenge
//
//  Created by Talal Badreddine on 29/11/2021.
//

import Foundation
import Firebase

class FireBaseManager {
    
    func userIsLoggedIn() -> Bool {
        var temp: Bool = false
        (Auth.auth().currentUser != nil) ? (temp = true) : (temp = false)
        return temp
    }
    
    func userAlreadyExist(){
        
    }
    
}
