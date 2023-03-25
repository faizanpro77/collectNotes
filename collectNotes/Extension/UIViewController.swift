//
//  UIViewController1.swift
//  collectNotes
//
//  Created by MD Faizan on 15/03/23.
//

import Foundation
import UIKit



extension UIViewController {
    
    func  showNoteDetailsViewcontroller(note: Note){

//        print("==========================>>>archiveNoteData===\(note)")

        guard  let noteDetailController = self.storyboard?.instantiateViewController(withIdentifier: "NoteDetailViewController") as? NoteDetailViewController else {
            return
        }


        noteDetailController.modalPresentationStyle = .fullScreen
        noteDetailController.note = note
        noteDetailController.noteType = .update
        present(noteDetailController, animated: true, completion: nil)


    }
}
