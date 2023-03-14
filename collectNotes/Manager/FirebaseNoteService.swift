//
//  FirebaseNoteService.swift
//  collectNotes
//
//  Created by MD Faizan on 20/01/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase


class FirebaseNoteService {
    
    
    //to add an note
    func toStoreNoteData(title:String, description:String, completion: @escaping (Bool, String?)->()) {
        print("user UID is ===============> \(String(describing: Auth.auth().currentUser?.uid))")
        
        guard let UserId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        let document = db.collection("notesData").document(UserId).collection("notes").document()
        
        print("document Id ======> \(document.documentID)")
        
        document.setData(["title": title, "description": description, "trash": false, "archive":false]) { error in
            if error != nil {
                print("error in saving data")
                completion(false, error?.localizedDescription)
            } else {
                print("successfully saved notes data")
                completion(true, nil)
            }
            
        }
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
    
    //for update note data
    func updateDocument(note:Note, completion: @escaping (Bool,String?)->()) {
     
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        let document = db.collection("notesData").document(userId).collection("notes")
        document.document(note.id).setData(["title": note.title, "description": note.description], merge: true) { (error) in
            if error != nil {
                //we have an error
                completion(false, error?.localizedDescription)
                print("firebase error",error!)
                
            } else {
                //update was sucessful
                completion(true, nil)
                print("update sucessful")
            }
        }
    }
    
    
    
}
