//
//  DrawerScreensPresentNewController.swift
//  collectNotes
//
//  Created by MD Faizan on 07/03/23.
//

import UIKit

//var tableViewMenueArray = [["Notes","Reminders"],["add label","Create/Edit labels"],["Archive","Bin"],["Setting","Send app feedback","Help"]]

enum DrawerItemType: Int {
    case notes = 0 
    case reminders = 1
    case addLabel = 2
    case createEditlabels = 3
    case archive = 4
    case bin = 5
}

var selectedDrawerItemType: DrawerItemType = .notes

extension UIViewController {
    
    // this code is reusable code for reminder,archive,trash for persenting particular screen selcted in table view
    //    func presentDrawerControllers(tableIndexNumber:Int,tableIndexRowName:tableRowName) {
    func presentDrawerControllers(type: DrawerItemType) {
        
        switch type {
        case .notes:
            print("=========>notes")
            
        case .reminders:
            print("=========>reminder")
            
        case .addLabel:
            print("=========>addLabel")
            
            
        case .createEditlabels:
            print("=========>createEditlabels")
            
        case .archive:
            print("=========>archive")
            
        case .bin:
            print("=========>bin")
            
        }
        
        //        if  tableIndexNumber == 0 {
        //            print("navigate to dashboard")
        //
        //        } else if tableIndexNumber == 1 {
        //
        //            let reminderVC = self.storyboard?.instantiateViewController(withIdentifier: "RemindersViewController") as! RemindersViewController
        //
        //
        //            reminderVC.modalPresentationStyle = .fullScreen
        //            present(reminderVC, animated: true)
        //        } else if tableIndexNumber == 2 {
        //
        //            let TrashVC  = self.storyboard?.instantiateViewController(withIdentifier: "ArchiveViewController") as! ArchiveViewController
        //
        //            TrashVC.modalPresentationStyle = .fullScreen
        //            present(TrashVC, animated: true)
        //
        //        }
        //        else if tableIndexNumber == 3 {
        //
        //            let TrashVC  = self.storyboard?.instantiateViewController(withIdentifier: "TrashViewController") as! TrashViewController
        //
        //            TrashVC.modalPresentationStyle = .fullScreen
        //            present(TrashVC, animated: true)
        //
        //        }
        
    }
    
}
