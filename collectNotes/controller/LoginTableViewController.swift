//
//  LoginTableViewController.swift
//  collectNotes
//
//  Created by MD Faizan on 17/12/22.

//use as much comment you can later you come to the same it easy understand the code


import UIKit

class LoginTableViewController: UITableViewController {
    
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
    
         
        tableView.estimatedSectionFooterHeight = 0
//        self.dismissKeyboard() 14:52
    }
    
    
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        emailPasswordValidation()
    }
    
    
    @IBAction func btnSignupClicked(_ sender: UIButton) {
        
        if let signupVC = self.storyboard?.instantiateViewController(identifier: "SignupTableViewController") as? SignupTableViewController {
            self.navigationController?.pushViewController(signupVC, animated: true)
        }
    }
}



extension LoginTableViewController {
    
    
    
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
            //using for single cell fit in all screen
            //using for unhide label. "---or connect with--" lable hide in SE device
    
            return UIScreen.main.bounds.height
    
//            return UITableView.automaticDimension
        }
    
    
    
//    //this code is use for center the all content or UI in the ipad
//    //this method called after viewDidLoad and landscap and potrate and layout change
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        let tableViewHeight = self.tableView.frame.height
//        let contentHeight = self.tableView.contentSize.height
//
//        let centeringInset = (tableViewHeight - contentHeight) / 2.0
//        let topInset = max(centeringInset, 0.0)
//
//        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
//    }
    
}



extension LoginTableViewController{
    //validate email and password
    fileprivate func emailPasswordValidation() {
        if let  email = txtEmail.text, let password = txtPassword.text{
            //check for empty eamil
            //            if email == "" {
            //                //Alert
            //            }else{
            //
            //            }
            
            if !email.validateEmailId(){
                openAlert(title: "Alert", message: "Email Address not found.", alertStyle: .alert, actionTitles: ["okay"], actionStyles: [.default], actions: [{ _ in
                    print("okay clicked")
                }])
            }else if !password.validatePassword(){
                openAlert(title: "Alert", message: "Please Enter valid Password", alertStyle: .alert, actionTitles: ["okay"], actionStyles: [.default], actions: [{ _ in
                    print("okay clicked")
                }])
                
            }else {
                //navigation Home Screen
            }
        }else {
            openAlert(title: "Alert", message: "Please add details.", alertStyle: .alert, actionTitles: ["okay"], actionStyles: [.default], actions: [{ _ in
                print("okay clicked")
            }])
            
        }
    }
}


/*
 **tp keyboard is used third party dependency
https://stackoverflow.com/questions/54283069/scrollview-did-not-move-up-when-click-textfield-inside-tableview
 */
