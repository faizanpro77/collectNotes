//
//  DrawerScreensPresentNewControllerReusable.swift
//  collectNotes
//
//  Created by MD Faizan on 07/03/23.
//

//import Foundation
import UIKit


class DrawerScreensPresentNewControllerReusable {
    
    
    func presentDrawerControllers(tableIndexNumber:Int) {
        
        if tableIndexNumber == 0 {
            print("navigate to dashboard")
                    
        } else if tableIndexNumber == 1 {
            
            let reminderVC = self.storyboard?.instantiateViewController(withIdentifier: "RemindersViewController") as! RemindersViewController
    
            
            reminderVC.modalPresentationStyle = .fullScreen
            present(reminderVC, animated: true)
        } else if tableIndexNumber == 3 {
            
            let TrashVC  = self.storyboard?.instantiateViewController(withIdentifier: "TrashViewController") as! TrashViewController
            
            TrashVC.modalPresentationStyle = .fullScreen
            present(TrashVC, animated: true)
            
        }
        
    }
    
    
}
