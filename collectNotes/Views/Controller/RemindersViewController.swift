//
//  RemindersViewController.swift
//  collectNotes
//
//  Created by MD Faizan on 06/03/23.
//

import UIKit

class RemindersViewController: UIViewController {
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func openSideDrawer(_ sender: UIButton) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "MenuDrawerViewController") as! MenuDrawerViewController
        //pass reference for using protoco here protocol declear in SideDrawer vc
        VC.presentNewScreenDelegate = self
        VC.modalPresentationStyle = .overCurrentContext
        self.present(VC, animated: false)
        //        presentDetailHorizontal(VC)
    }
    
    
    
}

extension RemindersViewController:MenuDrawerViewControllerDelegate{
    
    //    it is protoco function protocol declear in side drower
    func presentNewController(drawerItemType: DrawerItemType) {
        //        print("==============>>protocol work good,\(drawerItemType)")
        
        //i check here if selected index row of table view is Reminders then only dismiss controller and if not then present particular screen
        if drawerItemType != .reminders {
            presentDrawerControllers(type: drawerItemType)
        }
        if drawerItemType == .reminders {
            print("==============>only dismiss")
        }
    }
}


















