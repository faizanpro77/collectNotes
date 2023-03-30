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
    @IBOutlet weak var gridListButton: UIButton!
    
    var isGridListActive:Bool = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bar Items"
        
        
        //        CommonCollectionBackView.lblTitle.text = "Archive hub"
        
        
        //callback --- calling showNoteDetailsViewcontroller() from CommonCollection file
        CommonCollectionBackView.showNotesDetailsViewControllerCallback = { (notItem) in
            
            //            self.showNoteDetailsViewcontroller(note: notItem)
            self.showNoteDetailsViewcontroller(note: notItem)
            
        }
        
        //        CommonCollectionBackView.showNoteDetailsProtocolDelegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //calling this function CommonCollection view for getting particular screen note data for collection view
        CommonCollectionBackView.showParticularNotesCollectionData(type: .archiveController)
        
    }
    
    
    
    
    
    @IBAction func openDrawer(_ sender: UIButton) {
        
        //        checkPresentScreen()
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "MenuDrawerViewController") as! MenuDrawerViewController
        VC.presentNewScreenDelegate = self
        VC.modalPresentationStyle = .overCurrentContext
        self.present(VC, animated: false)
        
        //        presentDetailHorizontal(VC)
        
        
    }
    
    
    
    //to grid and list collection view
    @IBAction func toggleGridList(_ sender: UIButton) {
        
        isGridListActive.toggle()
        
        //using ternary operator intead of if else
        let image = isGridListActive ? UIImage(systemName: "square.grid.2x2") : UIImage(systemName: "rectangle.grid.1x2")
        gridListButton.configuration?.image = image
        
        //toggle() change boolean valur of variable true/false
        CommonCollectionBackView.changeGridList(gridList: isGridListActive)
        //        print("==============ttttt>>> \(isGridListActive)")
        
        
        
    }
    
    
    
    
}

extension ArchiveViewController: MenuDrawerViewControllerDelegate {
    
    //if we select other menue from drawer it navigate particular screen as selection and if we open drawer archive screen and select archive menue or same menue it only dismiss drawer
    func presentNewController(drawerItemType: DrawerItemType) {
        
        
        
        if drawerItemType != .archive {
            presentDrawerControllers(type: drawerItemType)
        }
        
        if drawerItemType == .archive {
            print("==============>only dismiss")
        }
    }
    
}

//calling protocol function---- calling showNoteDetailsViewcontroller() from CommonCollection file
//extension ArchiveViewController: ShowNoteDetailsDelegate {
//    func showNoteDetailVC(note: Note) {
//        showNoteDetailsViewcontroller(note: note)
//    }
//}










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


