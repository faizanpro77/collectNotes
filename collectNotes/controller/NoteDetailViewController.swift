//
//  NoteDetailViewController.swift
//  collectNotes
//
//  Created by MD Faizan on 30/01/23.
//

import UIKit

class NoteDetailViewController: UIViewController,UITextViewDelegate {
    
    enum NoteType {
        case new
        case update
    }
   
    var note:Note?
    var noteType:NoteType = .new
    
    @IBOutlet weak var bottonBack: UIButton!
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var titleTextViewHC: NSLayoutConstraint!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextView.delegate = self
        descriptionTextView.delegate = self
        
//        titleTextView.text = "Title kljflsg kjsfkg lkjskgf lksjfkjg lksjdgkj sdljkjslfjkjglksjk kjsfkg   lksfjg  sjfgksfjl kjsfgkj ksjflk skgfjk ksfj fsjgkj fgksjkfg jskjgkslg skjfks jsf lksjgkjf gskjgfs kljs g"
        titleTextView.text = "Title"
        titleTextView.textColor = UIColor.lightGray
        
        descriptionTextView.text = "Note"
        descriptionTextView.textColor = UIColor.lightGray
        
        titleTextViewHC.constant = self.titleTextView.contentSize.height
        
        setUpNote()
    }
    
    //after click on enter hide keyboard
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("==================> shouldChangeTextIn")
        titleTextViewHC.constant = self.titleTextView.contentSize.height
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    //it call when we start typing in textview
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("===================> textViewDidBeginEditing")
//        guard note == nil else {
//            return
//        }
        
        if titleTextView.textColor == UIColor.lightGray && titleTextView.text != nil {
            titleTextView.text = nil
            titleTextView.textColor = UIColor.black
        }
//        print("====================> nil \(titleTextView.text!)")
        if descriptionTextView.textColor == UIColor.lightGray && descriptionTextView.text != nil  {
            descriptionTextView.text = nil
            descriptionTextView.textColor = UIColor.black
        }
        
//        textView.becomeFirstResponder()
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
//        print("====================>u nil \(titleTextView.text!)")

        print("===================>textViewDidEndEditing")
        if titleTextView.text.isEmpty {
            titleTextView.text = "Title"
            titleTextView.textColor = UIColor.lightGray
        }
        
        if descriptionTextView.text.isEmpty {
            descriptionTextView.text = "Note"
            descriptionTextView.textColor = UIColor.lightGray
        }
        
//        textView.resignFirstResponder()
    }
    
    
   //it called when I want to  update note or read any created note
    private func setUpNote() {
    
        guard let note = note else {
            return
        }
        
        titleTextView.textColor = UIColor.black
        descriptionTextView.textColor = UIColor.black
        
        titleTextView.text = note.title
        descriptionTextView.text = note.description
        
    }
    
    @IBAction func backBottonClicked(_ sender: Any) {
        
        let title = titleTextView.text!
        let description = descriptionTextView.text!
        
        
        switch noteType {
            
        case .new:
        if !title.isEmpty || !description.isEmpty {
            FirebaseNoteService().toStoreNoteData(title: title, description: description) { status, errorMessage in
                if status == true {
                    self.dismiss(animated: true)
                } else {
                    //show error
                    print("Erorr while adding new  note \(errorMessage ?? "null")")
                }
            }
        }
        case .update:
           
            note?.title = title
            note?.description = description
            
            FirebaseNoteService().updateDocument(note: note!) { (status, errorMessage) in
                
                if status == true {
                    self.dismiss(animated: true)
                } else {
                    //show error
                    print("Error while updating the note \(errorMessage ?? "null")")
                }
            }
            //        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {

        }
    }
    
    
}
