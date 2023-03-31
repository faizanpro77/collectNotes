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

/**

 notesArray.append(note)
//                    print("documentData======>",documentData,"======>",docId)
 
}
completion(notesArray)
} else {
print(error?.localizedDescription)
}

 
 
 
 //to get note data
 //here i am adding doucument id manually  to  data which is recieve
 func toGetNotesData(completion: @escaping ([Note])->()) {
     
     guard let userId = Auth.auth().currentUser?.uid else {
         return
     }
     
     let db = Firestore.firestore()
     
     let document = db.collection("notesData").document(userId).collection("notes")
     document.getDocuments { (snapshot, error) in
         
         if error == nil && snapshot != nil {
             var notesArray: [Note] = []
             
             for document in snapshot!.documents {
                 let docId = document.documentID
                 
                 var documentData = document.data()
                 documentData["id"] = docId
                 
                 let note = Note(
                     title: documentData["title"] as! String,
                     description: documentData["description"] as! String,
                     id: documentData["id"] as! String,
                     trash: documentData["trash"] as! Bool,
                     archive: documentData["archive"] as! Bool
                 )
                 
                 notesArray.append(note)
//                    print("documentData======>",documentData,"======>",docId)
                 
             }
             completion(notesArray)
         } else {
             print(error?.localizedDescription)
         }
     }
 }
 
 */
