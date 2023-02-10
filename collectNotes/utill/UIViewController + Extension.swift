//
//  UIViewController + Extension.swift
//  collectNotes
//
//  Created by MD Faizan on 23/12/22.
//

import Foundation
import UIKit


//this code for dissmiss keyboard after touch on view it common class UIViewController all controller
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc  func dismissKeyboard() {
        view.endEditing(true)
    }
}
