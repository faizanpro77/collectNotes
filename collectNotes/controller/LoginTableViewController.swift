//
//  LoginTableViewController.swift
//  collectNotes
//
//  Created by MD Faizan on 17/12/22.

//use as much comment you can later you come to the same it easy understand the code


import UIKit
import FacebookLogin
import FBSDKLoginKit
import FacebookCore
import GoogleSignIn
import FirebaseAuth
import Firebase


class LoginTableViewController: UITableViewController {
    
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnFacebook: FBLoginButton!

        weak var loginDelegate: LoginSuccessDelegate?
  
    
    
    
    @IBAction func autoFillPassword(_ sender: UIButton) {
    
        txtEmail.text = "faizyshaikh204@gmail.com"
        txtPassword.text = "password7"
//        print("==================>\(txtEmail.text!)======>\(txtPassword.text!)")
    }
    
    
    
    override func viewDidLoad() {
        
        
        tableView.estimatedSectionFooterHeight = 0
        //        self.dismissKeyboard()
        
        facebookLogin()
        googleLogin()
        firbaseAuthEmailPassword()
        
    }
    
    
   
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        emailPasswordValidation()
    }
    
    //user login
    func firbaseAuthEmailPassword() {
        
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { authResult, error in
            if error != nil {
                print(error?.localizedDescription ?? "Exception")
            } else {
                print("LOGIN - \(String(describing: authResult?.user.uid))")
                let token = authResult?.user.uid
                UserManager.shared.saveToken(token: token)
                self.transitionToHome()
            }
        }
    }
    
    //method for navigate controller to home screen
    func transitionToHome() {
        
        //        view.window?.rootViewController = ContainerController()
        //        view.window?.makeKeyAndVisible()
        
        print("navigate to dashboard")
        loginDelegate?.loginSuccess(faizString: "faizan login sucessful protocol")

        self.navigationController?.popViewController(animated: true)
       
        //to dismiss present controller
//        self.dismiss(animated: true)
    }
    
    
    

    @IBAction func btnForgotPswd(_ sender: UIButton) {
         
        Auth.auth().sendPasswordReset(withEmail: self.txtEmail.text!) { error in
            if error != nil {
                print("Failed - \(String(describing: error?.localizedDescription))")
            } else {
                print("email send....\(self.txtEmail.text!)")
            }
        }
    }
    

    
    @IBAction func btnSignupClicked(_ sender: UIButton) {
        
//        if let signupVC = self.storyboard?.instantiateViewController(identifier: "SignupTableViewController") as? SignupTableViewController {
//            self.navigationController?.pushViewController(signupVC, animated: true)
//        }
        
        let signupVC = self.storyboard?.instantiateViewController(identifier: "SignupTableViewController") as! SignupTableViewController
            self.navigationController!.pushViewController(signupVC, animated: true)
        
    }
    
    //to check user login or not if login we get user information
    func facebookLogin() {
        
        if let token = AccessToken.current,
           !token.isExpired {
            // User is logged in, do work such as go to next view controller.
            let token = token.tokenString
            
            let request =  FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name, name, middle_name, name_format,age_range"], tokenString: token, version: nil, httpMethod: .get)
            request.start { (connection, result, error) in
                print("\(String(describing: result))")
                //navigate to home
                
            }
        } else {
            btnFacebook.delegate = self
            btnFacebook.permissions = ["public_profile", "email"]
        }
    }
    
    
    @IBAction func btnGoogleLogin(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(with: GIDConfiguration.init(clientID: "77360152208-29gv4tfc3o0hqca2eh43nirjpp5p1gvh.apps.googleusercontent.com"),
                                        presenting: self) { googleUser, err in
            //            print("*************\(String(describing: googleUser))")
            guard let googleUser = googleUser else {
                return
            }
            print(googleUser.profile?.email ?? "No Email")
            //navigation code
        }
    }
    
    
    func googleLogin() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            //           GIDSignIn.sharedInstance.restorePreviousSignIn()
            print("Already Login")
            //navigation code
        }
    }
    
    
    
}


//signout with google

//let firebaseAuth = Auth.auth()
//do {
//try firebaseAuth.signOut()
//} catch let signOutError as NSError {
//print("Error signing out: %@", signOutError)
//}




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
    
    
    //    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        nil
    //    }
    //
    //    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        nil
    //    }
    //
    //
    //    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        0
    //    }
    //
    //    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        0
    //    }
    
}



extension LoginTableViewController{
    //validate email and password
    fileprivate func emailPasswordValidation() {
        if let  email = txtEmail.text, let password = txtPassword.text{
            //check for empty email
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
                firbaseAuthEmailPassword()
            }
        }else {
            openAlert(title: "Alert", message: "Please add details.", alertStyle: .alert, actionTitles: ["okay"], actionStyles: [.default], actions: [{ _ in
                print("okay clicked")
            }])
            
        }
    }
}

extension LoginTableViewController: LoginButtonDelegate {
    //this function called after click to login button
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        let token = result?.token?.tokenString
        
        let request =  FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name, name, middle_name, name_format,age_range"], tokenString: token, version: nil, httpMethod: .get)
        request.start { connection, result, error in
            print("delegate=====>\(String(describing: result))")
        }
    }
    
    //this function called after click to logout  button if we login with facebook
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("===============>>Logout")
    }
}




/*
 **tp keyboard is used third party dependency
 https://stackoverflow.com/questions/54283069/scrollview-did-not-move-up-when-click-textfield-inside-tableview
 */

//iq keybord third party
