//
//  TrashViewController.swift
//  collectNotes
//
//  Created by MD Faizan on 07/03/23.
//

import UIKit

class TrashViewController: UIViewController {
    
    
    @IBOutlet weak var CommonCollectionBackView: CommonCollectionView!
    
    
    @IBOutlet weak var gridListButton: UIButton!
    
    
    var isGridListActive:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        CommonCollectionBackView.lblTitle.text = "Bin Hub"
        
        
        // it is a callback from common collection view after clicking perticular note single note data came here after that i call function that is declare in uiview controlller i navigate to noteDetailsView controller and pass note data as well
        CommonCollectionBackView.showNotesDetailsViewControllerCallback = { (notItem) in
            self.showTrashNoteDetailsViewController(note: notItem)
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //calling this function CommonCollection view for getting particular screen note data for collection view
        CommonCollectionBackView.showParticularNotesCollectionData(type: .TrashController)
    }
    
    
    @IBAction func openSideDrawer(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "MenuDrawerViewController") as! MenuDrawerViewController
        VC.presentNewScreenDelegate = self
        VC.modalPresentationStyle = .overCurrentContext
        self.present(VC, animated: false)
        
    }
    
    
    @IBAction func toggleGridList(_ sender: UIButton) {
        
        isGridListActive.toggle()
        //using ternary operator intead of if else
        let image = isGridListActive ? UIImage(systemName: "square.grid.2x2") : UIImage(systemName: "rectangle.grid.1x2")
        gridListButton.configuration?.image = image
        CommonCollectionBackView.changeGridList(gridList: isGridListActive)
        
    }
    
    
    //open selected note in editor
    func showTrashNoteDetailsViewController(note: Note) {
       
        let trashNoteViewCotroller = self.storyboard?.instantiateViewController(withIdentifier: "TrashNoteDetailViewController") as! TrashNoteDetailViewController
        trashNoteViewCotroller.modalPresentationStyle = .fullScreen
        trashNoteViewCotroller.note = note
        present(trashNoteViewCotroller, animated: true)
        
    }
    
    
//    func  showNoteDetailsViewcontroller(note: Note){
//
////        print("==========================>>>archiveNoteData===\(note)")
//
//        guard  let noteDetailController = self.storyboard?.instantiateViewController(withIdentifier: "NoteDetailViewController") as? NoteDetailViewController else {
//            return
//        }
//
//
//        noteDetailController.modalPresentationStyle = .fullScreen
//        noteDetailController.note = note
//        noteDetailController.noteType = .update
//        present(noteDetailController, animated: true, completion: nil)
//
//
//    }

    
}


extension TrashViewController: MenuDrawerViewControllerDelegate {
    //open perticular scren from drawer selected menue
    func presentNewController(drawerItemType: DrawerItemType) {
//        print("==============>>protocol work good,\(drawerItemType)")
        
        //i check here if selected index row of table view is Trash then only dismiss controller and if not then present particular screen
        if drawerItemType != .bin {
            presentDrawerControllers(type: drawerItemType)
        }
        
        if drawerItemType == .bin {
            print("==============>only dismiss")
        }
    }
    
}



//        if tableIndexNumber == 0 {
//            print("navigate to dashboard")
//
//        } else if tableIndexNumber == 1 {
//
//            let reminderVC = self.storyboard?.instantiateViewController(withIdentifier: "RemindersViewController") as! RemindersViewController
//
//
//            reminderVC.modalPresentationStyle = .fullScreen
//            present(reminderVC, animated: true)
//
//        } else if tableIndexNumber == 2 {
//
//            let reminderVC = self.storyboard?.instantiateViewController(withIdentifier: "ArchiveViewController") as! ArchiveViewController
//
//
//            reminderVC.modalPresentationStyle = .fullScreen
//            present(reminderVC, animated: true)
//
//        }
