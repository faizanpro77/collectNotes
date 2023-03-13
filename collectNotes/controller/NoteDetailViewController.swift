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
    
    @IBOutlet weak var bottomTabViewBottomConstraint: NSLayoutConstraint!
    
   
    @IBOutlet weak var bottomTapView: UIView!
    @IBOutlet weak var noteScrollView: UIScrollView!
    
    
 
    
   
    
    func showFaizanName(nameData:String) {
        print("==========>\(nameData)")
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
       
        titleTextView.delegate = self
        descriptionTextView.delegate = self
        
        //for setting character limit
        titleTextView.tag = 1
        descriptionTextView.tag = 2
        
        
        //noteScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
//        let bottomOffset = CGPoint(x: 0, y: noteScrollView.contentSize.height - noteScrollView.bounds.height + noteScrollView.contentInset.bottom + 150)
//        noteScrollView.setContentOffset(bottomOffset, animated: true)



        
        setUpNote()
        
        //for adjust dynamic height according to text for textview
        titleTextViewHC.constant = self.titleTextView.contentSize.height
        descriptionTextViewHC.constant = self.descriptionTextView.contentSize.height
        
        //this code for after showing keyboard bottom tabar move above keyboard not hide behind it
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);

  }
   
    
    
    //call after updating ui or showing ui
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //for stopping textview scroll
        titleTextView.isScrollEnabled = false
        descriptionTextView.isScrollEnabled = false
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
            } else {
                self.dismiss(animated: true)
            }
        case .update:
            
            let checkTitleTextEdit = note?.title
            let checkDescriptionTextEdit = note?.description
          
            note?.title = title
            note?.description = description
            
            print("===========>checkTextEdit===>\(String(describing: checkTitleTextEdit))===title===>\(title)")
            

            
            //if user edit or update note then only firbase quary run and update note
            if(checkTitleTextEdit != title || checkDescriptionTextEdit != description){
                print("update succesful===========> ")
                FirebaseNoteService().updateDocument(note: note!) { (status, errorMessage) in
                    
                    if status == true {
                        self.dismiss(animated: true)
                    } else {
                        //show error
                        print("Error while updating the note \(errorMessage ?? "null")")
                    }
                }
            }else{
                self.dismiss(animated: true)
                print("==========>not update or not edit from user")
            }
            
            
            
            
            //        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            
        }
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
               let keyboardRectangle = keyboardFrame.cgRectValue
               let keyboardHeight = keyboardRectangle.height
            
            //for animation
//            UIView.animate(withDuration: 2, delay: 3) {
//                self.bottomTabViewBottomConstraint.constant = keyboardHeight
//            }
            
            self.bottomTabViewBottomConstraint.constant = keyboardHeight

            //it will manage layout if needed
//            bottomTapView.layoutIfNeeded()
//            bottomTapView.setNeedsLayout()
//            print("================000>keyboard height \(keyboardHeight)")
           }
//         self.view.frame.origin.y = -350 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
//         self.view.frame.origin.y = 0 // Move view to original position
        
            self.bottomTabViewBottomConstraint.constant = 0
    }
   
    //    Asks the delegate whether to replace the specified text in the text view. and call before updating UI
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
            let numberOfChars = newText.count
            
            //for setting character limit
            if textView.tag == 1 {
                //titleTextView
                return numberOfChars <= 1000
            } else {
                
                return numberOfChars <= 10000
            }
               
        }
        
            
    //    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    //        print("=============>shouldChangeTextIn")
    //
    //        if text == "\n" {
    ////            descriptionTextView.becomeFirstResponder()
    ////            descriptionTextView.beco
    //            return false
    //        }
    //        return true
    //    }
            //if touch screen it hide keyboard
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        self.view.endEditing(true)
    //    }
        
        
    //    Tells the delegate when the user changes the text or attributes in the specified text view and call after updating UI
        
        func textViewDidChange(_ textView: UITextView) {
            print("====================>textViewDidChange")
            //auto content height of textview
            textView.isScrollEnabled = true
            titleTextViewHC.constant = self.titleTextView.contentSize.height
            descriptionTextViewHC.constant = self.descriptionTextView.contentSize.height
            
            textView.isScrollEnabled = true
            
            
        }
        
    
    
    @IBAction func menueBottomSheet(_ sender: Any) {
        
        if let menueSheetVC = self.storyboard?.instantiateViewController(withIdentifier: "MenueBottomSheetViewController") as? MenueBottomSheetViewController {
            
            if let menueSheet = menueSheetVC.sheetPresentationController {
                menueSheet.detents = [.medium()]
                menueSheet.prefersGrabberVisible = true
                menueSheet.preferredCornerRadius = 24
            }
             
            self.present(menueSheetVC, animated: true)
        }
        
    }
    
    
    
    @IBAction func addFeaturebottomSheet(_ sender: UIButton) {
        
        print("============>OpenBottomSheet")

        if let bottomSheetVc = self.storyboard?.instantiateViewController(withIdentifier: "BottomSheetViewController") as? BottomSheetViewController{
            if let sheet = bottomSheetVc.sheetPresentationController {
                sheet.detents = [.medium() ]
                sheet.prefersGrabberVisible = true
//                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
//                sheet.largestUndimmedDetentIdentifier = .medium
                sheet.preferredCornerRadius = 24
            }
            
                
            self.present(bottomSheetVc, animated: true)
        }
        
    }
    
    
    
    
//   ====================================
    
}


/**
 
 //for customization of of botton sheet height
 if let sheet = viewController.sheetPresentationController {
     sheet.detents = [
             .custom { _ in
                 return 200
             },
             .custom { context in
                 return context.maximumDetentValue * 0.6
             }
     ]
 }

 */
