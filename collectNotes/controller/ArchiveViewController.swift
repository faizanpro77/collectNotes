//
//  ArchiveViewController.swift
//  collectNotes
//
//  Created by MD Faizan on 20/02/23.
//

import UIKit

class ArchiveViewController: UIViewController {
    
    
    @IBOutlet weak var CommonCollectionBackView: CommonCollectionView!
    
    
    
    
//    @IBOutlet weak var collectionViewArchive: ReusableCollectionView!
  
    
//    @IBOutlet weak var commonCollectionArchive: UIView!
    

//    private lazy var commonCollectionView: CommonCollectionView = .loadFromNib()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bar Items"
        
        CommonCollectionBackView.showParticularNotesCollectionData(type: .archive)
        
        CommonCollectionBackView.lblTitle.text = "Archive hub"
    }
    
    
    @IBAction func openDrawer(_ sender: UIButton) {
    
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
    
    
    
//    func faizean() {
//        let noteDetailController = self.storyboard?.instantiateViewController(withIdentifier: "NoteDetailViewController") as! NoteDetailViewController
//        noteDetailController.modalPresentationStyle = .fullScreen
//        noteDetailController.note = notes[indexPath.item]
//        noteDetailController.noteType = .update
//        self.present(noteDetailController, animated: true, completion: nil)
//    }
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
//        } else if tableIndexNumber == 3 {
//
//            let TrashVC  = self.storyboard?.instantiateViewController(withIdentifier: "TrashViewController") as! TrashViewController
//
//            TrashVC.modalPresentationStyle = .fullScreen
//            present(TrashVC, animated: true)
//
//        }





/**
 view did load code
  
 //        commonCollectionArchive.backgroundColor = .red
        
         
 //         view.backgroundColor = .systemPink

         
         
 //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
 //
 //
 //
 //        }

         // Do any additional setup after loading the view.
         
 //        let norecordView = CommonCollectionView(frame: commonCollectionArchive.bounds)
 //        let viewFromXib = UINib(nibName: "CommonCollectionView", bundle: .main).instantiate(withOwner: nil, options: nil).first as! CommonCollectionView

 //        let viewFromXib = Bundle.main.loadNibNamed("CommonCollectionView", owner: self, options: nil)![0] as! CommonCollectionView
 //        commonCollectionView.frame = commonCollectionArchive.bounds
 //        commonCollectionArchive.addSubview(commonCollectionView)
 //
 //        self.commonCollectionArchive.addSubview(norecordView)
 
 
 */


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
