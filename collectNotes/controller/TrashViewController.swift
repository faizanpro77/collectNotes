//
//  TrashViewController.swift
//  collectNotes
//
//  Created by MD Faizan on 07/03/23.
//

import UIKit

class TrashViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func openSideDrawer(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "MenuDrawerViewController") as! MenuDrawerViewController
        VC.presentNewScreenDelegate = self
        VC.modalPresentationStyle = .overCurrentContext
        self.present(VC, animated: false)
        
    }    
}


extension TrashViewController: MenuDrawerViewControllerDelegate {
    func presentNewController(drawerItemType: DrawerItemType) {
        print("==============>>protocol work good,\(drawerItemType)")
        
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
