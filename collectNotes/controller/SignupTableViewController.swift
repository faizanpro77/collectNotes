//
//  SignupTableViewController.swift
//  collectNotes
//
//  Created by MD Faizan on 24/12/22.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignupTableViewController: UITableViewController {
    
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //to hide footer
        tableView.estimatedSectionFooterHeight = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer: )))
        //        img Profile.isUserInteractionEnabled = true
        imgProfile.addGestureRecognizer(tapGesture)
        
    }
    
    
    @objc
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
//        print("image tapped")
        openGallery()
    }
    
    @IBAction func btnSignupClicked(_ sender: Any) {
//        print("btnSignupClicked")
        let imgSystem = UIImage(systemName: "person.crop.circle.badge.plus")
        if imgProfile.image?.pngData() != imgSystem?.pngData() {
            //profile image selected
            if let email = txtEmail.text, let password = txtPassword.text, let userName = txtUsername.text, let conPassword = txtConPassword.text {
                if userName == "" {
                    print("please enter username")
                } else if !email.validateEmailId() {
                    openAlert(title: "Alert", message: "please enter valid email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in}])
                    
                } else if !password.validatePassword() {
                    print("password is not valid")
                    
                } else if conPassword == "" {
                    
                    print("please confirm password")
                } else {
                    if password == conPassword {
                        //navigation code
                        print("navigation code.....")
                        firbaseAuthEmailPassword()
                    } else {
                        print("password does not match")
                    }
                }
            } else {
                print("please check your details")
            }
        } else {
            print("please select profile picture")
        }
    }
    
    
    
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func firbaseAuthEmailPassword()
    {
        //create clean version of data or remove spaces
        
        let userName = txtUsername.text!.trimmingCharacters(in: .whitespaces)
        let email = txtEmail.text!.trimmingCharacters(in: .whitespaces)
        let password = txtPassword.text!.trimmingCharacters(in: .whitespaces)
        
//        print("email======> \(email)")
//        print("password====> \(password)")
        
        //create user
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            //there was an error creating the user or check for errors
            if err != nil {
                self.showError("Error creating user")
                print("Error creating user")
            } else {
                //user are created sucessfully now stored user details
                let db = Firestore.firestore()
                let uid = result!.user.uid
                db.collection("users").document(uid).setData(["userName": userName, "email": email, "uid": uid, "password": password]) { (error) in
                    if error != nil {
                        //show error message
                        self.showError("Error saving user data")
                        print("Error saving user data")
                    } else {
                        //navigate to dashboard
                        print("navigate to dashboard")
                        //save token in NS user default
                        UserManager.shared.saveToken(token: uid)
                        self.transitionToHome()
                    }
                }
                //Dismisses the view controller that was presented modally by the view controller.
//                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func showError(_ message: String){
        //        errorLabel.text = message
        //        errorLabel.alpha = 1
    }
    
    //method for navigate controller to home screen
    func transitionToHome() {
        
//        view.window?.rootViewController = ContainerController()
//        view.window?.makeKeyAndVisible()
//        print("navigate to dashboard")
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.dashboardViewController) as! DashboardViewController
        self.navigationController?.pushViewController(homeViewController, animated: true)
        
    }
    
}


extension SignupTableViewController {
    
    //using for single cell fit in all screen
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        return UIScreen.main.bounds.height
        return UITableView.automaticDimension
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


extension SignupTableViewController: UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .savedPhotosAlbum
            present(picker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage{
            imgProfile.image = img
        }
        dismiss(animated: true)
        
        
    }
}
