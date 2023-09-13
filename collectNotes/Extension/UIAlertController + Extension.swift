//
//  UIAlertController + Extension.swift
//  collectNotes
//
//  Created by MD Faizan on 23/12/22.
//

import Foundation
import UIKit

extension UIViewController {
    //it is a custom alert we can use it anywhere
    public func openAlert(title: String,
                          message: String,
                          alertStyle:UIAlertController.Style,
                          actionTitles:[String],
                          actionStyles:[UIAlertAction.Style],
                          actions: [((UIAlertAction) -> Void)]){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated(){
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController,animated: true)
        
        //https://stackoverflow.com/a/56579842/8201581
    }
    
}

