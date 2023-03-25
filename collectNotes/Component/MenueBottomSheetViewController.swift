//
//  MenueBottomSheetViewController.swift
//  collectNotes
//
//  Created by MD Faizan on 09/02/23.
//

import UIKit

class MenueBottomSheetViewController: UIViewController {
    
    var bottomSheetCallback: (() -> ())?
   
    
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func deleteNote(_ sender: UIButton) {
        
        bottomSheetCallback?()
        
        
        
        
        
        
        
        
     
        
       
    }
}
