//
//  DataService.swift
//  FZ Social
//
//  Created by Le Anh Duc on 3/24/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_POST = DB_BASE.child("posts")
    private var _REF_USER = DB_BASE.child("users")
    
    var REF_BASE:FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_POST:FIRDatabaseReference {
        return _REF_POST
    }
    
    var REF_USER:FIRDatabaseReference {
        return _REF_USER
    }
    
    func createFirebaseUserDB(uid: String, userData: Dictionary<String, String>) {
        REF_USER.child(uid).updateChildValues(userData)
    }
    
}










