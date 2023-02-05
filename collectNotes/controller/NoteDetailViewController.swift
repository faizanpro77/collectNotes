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
    @IBOutlet weak var descriptionTextViewHC: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextView.delegate = self
        descriptionTextView.delegate = self
        
        
        
        
        setUpNote()
        
        //for adjust dynamic height according to text for textview
        titleTextViewHC.constant = self.titleTextView.contentSize.height
        descriptionTextViewHC.constant = self.descriptionTextView.contentSize.height
    }
    
    
    //call after updating ui or showing ui
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //for stopping textview scroll
        titleTextView.isScrollEnabled = false
        descriptionTextView.isScrollEnabled = false
    }
    
    
        
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//
//        if text == "\n" {
//            print("=============>hhh \(titleTextView.text!)")
//            descriptionTextView.becomeFirstResponder()
////            descriptionTextView.beco
//            return false
//        }
//        return true
//    }
        
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
    
    //call after updating data
    func textViewDidChange(_ textView: UITextView) {
        print("====================>textViewDidChange")
        //auto content height of textview
        textView.isScrollEnabled = true
        titleTextViewHC.constant = self.titleTextView.contentSize.height
        descriptionTextViewHC.constant = self.descriptionTextView.contentSize.height
        
        textView.isScrollEnabled = true
        
        
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


