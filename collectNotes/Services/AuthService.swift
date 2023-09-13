//
//  AuthService.swift
//  collectNotes
//
//  Created by MD Faizan on 06/02/23.
//

//all login logout signup query

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase


class AuthService {
    
    func toGetUserData(completion: @escaping ([UserData])->()) {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        let document = db.collection("users")
        document.getDocuments{ (snapshot, error) in
            if error == nil && snapshot != nil {
                var userArray: [UserData] = []
                
                
                for document in snapshot!.documents {
                    let docId = document.documentID
                    var documentData = document.data()
                    documentData["id"] = docId
                    
                    let userData = UserData(
                        
                        email: documentData["email"] as! String,
                        userName: documentData["userName"] as! String
                        
                    )
                    
                    userArray.append(userData)
                    
                }
                
                completion(userArray)
            } else {
                print(error?.localizedDescription)
            }
            
        }
        
    }
    
    
}

