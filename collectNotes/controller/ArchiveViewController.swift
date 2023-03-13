//
//  ArchiveViewController.swift
//  collectNotes
//
//  Created by MD Faizan on 20/02/23.
//

import UIKit
//protocol ShowNoteDetailsDelegate {
//    func showNoteDetailVC(note: Note)
//}



class ArchiveViewController: UIViewController {
    
    
    @IBOutlet weak var CommonCollectionBackView: CommonCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bar Items"
        
        CommonCollectionBackView.showParticularNotesCollectionData(type: .archive)
        
//        CommonCollectionBackView.lblTitle.text = "Archive hub"
        
        
        
        CommonCollectionBackView.showNotesDetailsViewControllerCallback = { (notItem) in

            self.showNoteDetailsViewcontroller(note: notItem)

        }
        
//        CommonCollectionBackView.showNoteDetailsProtocolDelegate = self
        
    }
    
    



    
    @IBAction func openDrawer(_ sender: UIButton) {
    
//        checkPresentScreen()
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "MenuDrawerViewController") as! MenuDrawerViewController
        VC.presentNewScreenDelegate = self
        VC.modalPresentationStyle = .overCurrentContext
        self.present(VC, animated: false)

        //        presentDetailHorizontal(VC)
    
        
    }
    
    
    
}

extension ArchiveViewController: MenuDrawerViewControllerDelegate {
    
    func presentNewController(drawerItemType: DrawerItemType) {
        
        
        
        if drawerItemType != .archive {
            presentDrawerControllers(type: drawerItemType)
        }
        
        if drawerItemType == .archive {
            print("==============>only dismiss")
        }
    }

}


//extension ArchiveViewController: ShowNoteDetailsDelegate {
//    func showNoteDetailVC(note: Note) {
//        showNoteDetailsViewcontroller(note: note)
//    }
//}
    
    



extension UIViewController {
    func  showNoteDetailsViewcontroller(note: Note){
      
        print("==========================>>>archiveNoteData===\(note)")
        
        guard  let noteDetailController = self.storyboard?.instantiateViewController(withIdentifier: "NoteDetailViewController") as? NoteDetailViewController else {
            return
        }
        
        
        noteDetailController.modalPresentationStyle = .fullScreen
        noteDetailController.note = note
        noteDetailController.noteType = .update
        present(noteDetailController, animated: true, completion: nil)
        
      
    }
}





//if we want to present controller from left to right
//extension UIViewController {
//
//    func presentDetailHorizontal(_ viewControllerToPresent: UIViewController) {
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.type = CATransitionType.push
//        transition.subtype = CATransitionSubtype.fromLeft
//        self.view.window!.layer.add(transition, forKey: kCATransition)
//
//        present(viewControllerToPresent, animated: false)
//    }
//}





/**
 drawer related code
 
 //        print("==============>>protocol work good,\(tableIndexNumber)")
 //        var tableRow = DrawerItemType(rawValue: tableIndexNumber)
 
 
 //        var tableRow: tableRowName?
 
 //        if tableIndexNumber != 2 {
 //            if tableIndexNumber == 0 {
 //                 tableRow = .notes
 //            } else if tableIndexNumber == 1 {
 //                tableRow = .reminders
 //            } else if tableIndexNumber == 3 {
 //                tableRow = .bin
 //            }
 
 //            presentDrawerControllers(tableIndexNumber: tableIndexNumber)
 
 //i check here if selected index row of table view is archive then only dismiss controller and if not then present particular screen
 */


