//
//  TrashNoteDetailViewController.swift
//  collectNotes
//
//  Created by MD Faizan on 20/03/23.
//

import UIKit

class TrashNoteDetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var threeDotMeneuBottomSheetButton: UIButton!
    @IBOutlet weak var scroller: UIScrollView!
    
    @IBOutlet weak var heightContraint: NSLayoutConstraint!
    
    //menueBottomSheetButton
    
    var note:Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.threeDotMeneuBottomSheetButton.transform = self.threeDotMeneuBottomSheetButton.transform.rotated(by: CGFloat(Double.pi/2))
        
        scroller.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        
        setUpNotes()
        
        
    }
    
    func setUpNotes() {
        
        titleLabel.text = note?.title
        descriptionLabel.text = note?.description
        
    }
    
    
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        
//        hideBottomSheet()
        dismiss(animated: true)
        
    }
    
    /**
     
     self.view.backgroundColor = .black.withAlphaComponent(alphaValue)
     */
    
    
    @IBAction func clickedOnShowBottomSheetButton(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1) {
            self.heightContraint.constant = 200
            self.view.layoutIfNeeded()
        } completion: { (status) in
            //completion code
        }
    }
    
    
    
    @IBAction func clickedOnHideBottomSheetButoon(_ sender: UIButton) {
        
        hideBottomSheet()
       
    }
    

    func hideBottomSheet() {
        
        UIView.animate(withDuration: 0.1) {
            self.heightContraint.constant = 0
            self.view.layoutIfNeeded()
        } completion: { (status) in
            //completion code
        }
    }

    
    @IBAction func clickedOnRestoreButton(_ sender: Any) {
        
        note?.trash = false
        
        FirebaseNoteService().updateDocument(note: note!) { (status, errorMassege) in
            if status == true {
                self.hideBottomSheet()
                self.dismiss(animated: true)
            } else {
                //show error
                print("Note note restore")
            }
        }
        
    }
    
}
