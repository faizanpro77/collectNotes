//
//  DashboardViewController.swift
//  collectNotes
//
//  Created by MD Faizan on 15/01/23.

//MARK:  review 147

import UIKit
import FirebaseAuth

protocol LoginSuccessDelegate: AnyObject{
    func loginSuccess(faizString:String)
    func loginFailure()
}

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var ViewTopNavigationBar: UIView!
    @IBOutlet weak var ViewBottomTabBar: UIView!
    @IBOutlet weak var ButtonCreateNewNote: UIButton!
    @IBOutlet weak var gridListButton: UIButton!
    @IBOutlet weak var CommonCollectionBackView: CommonCollectionView!
    @IBOutlet weak var imageModalProfile: UIImageView!
    @IBOutlet weak var buttonLogout: UIButton!
    @IBOutlet weak var viewModalProfile: UIView!
    @IBOutlet weak var viewBackModalProfileTrasperent: UIView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelUserEmail: UILabel!
    
    var userInformation: [UserData] = [UserData(email: "Loading", userName: ".....")]
    
    //    var checkFirebaseLogin = Auth.auth().currentUser?.uid
    var isGridListActive:Bool = false
    //not in use
    //    var sideDrawerViewController:SideDrawerViewController?
    
    private var isSideDrawerMenuShown:Bool = false
    private var beginPoint:CGFloat = 0.0
    private var difference:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //it called when user not login
        if UserManager.shared.getToken() == nil {
            
            //hide dashboard controller data or ui
            ViewTopNavigationBar.isHidden = true
            CommonCollectionBackView.isHidden = true
            ViewBottomTabBar.isHidden = true
            ButtonCreateNewNote.isHidden = true
            
        }
        
        //after clicking on commonColletion view xib card that particulat card data pass here and  i call showNoteDetailsViewcontroller this function and pass data open card data in editor NoteDetailViewController
        
        //callback --- calling showNoteDetailsViewcontroller() from CommonCollection file
        CommonCollectionBackView.showNotesDetailsViewControllerCallback = { (notItem) in
            //            self.showNoteDetailsViewcontroller(note: notItem)
            self.showNoteDetailsViewcontroller(note: notItem)
            
        }
        
        viewBackModalProfileTrasperent.isHidden = true
        viewModalProfile.layer.cornerRadius = 10
        
        imageModalProfile.layer.cornerRadius = imageModalProfile.frame.height/2
        imageModalProfile.clipsToBounds = true
        
        //decorate logout button
        
        //            buttonLogout.layer.cornerRadius = 20
        //            buttonLogout.layer.borderColor = UIColor.lightGray.cgColor
        //            buttonLogout.layer.borderWidth = 1
        
        buttonLogout.configuration?.title = "Logout"
        buttonLogout.configuration?.background.strokeColor = .lightGray
        buttonLogout.configuration?.cornerStyle = .capsule
        buttonLogout.configuration?.background.strokeWidth = 1
        buttonLogout.configuration?.baseForegroundColor = .black
    }
    
    //This is called just before the view controller is added to the view hierarchy and shown to the user.
    //You can override this method to perform custom tasks associated with displaying the view.
    
    override func viewWillAppear(_ animated: Bool) {
        //calling this function CommonCollection view for getting particular screen note data for collection view
        CommonCollectionBackView.showParticularNotesCollectionData(type: .dashboardController)
        
    }
    
    //'viewDidAppear' will get called when the view is fully loaded (i.e after 'viewWillAppear').
    //You can override this method to perform additional tasks associated with presenting the view
    //In short if you Push a navigationcontroller to a new view and then pop it to the older view then viewDidAppear is Called.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //*every time check user login or not if don't login then navigate to  login screen if login then stay at same screen
        //it called when user not login
        if UserManager.shared.getToken() == nil {
            //            print(">>>>>>>>>>>>>>>>>>e> user note login")
            
            
            let logintableVc = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.loginTableViewController) as! LoginTableViewController
            self.navigationController?.pushViewController(logintableVc, animated: true)
            //if you want to receive data pass reference
            logintableVc.loginDelegate = self
            
        } else {
            
            print(">>>>>>>>>>>>>>>>>>>>>> user login \(UserManager.shared.getToken()!)")
        }
    }
    
    @IBAction func showProfile(_ sender: UIButton) {
        
        viewBackModalProfileTrasperent.isHidden = false
        viewBackModalProfileTrasperent.backgroundColor  = UIColor.black.withAlphaComponent(0.50)
        viewModalProfile.backgroundColor = UIColor.white
        getUserData()
        
    }
    
    func getUserData() {
        
        AuthService().toGetUserData { (userData) in
            //            print("=============999===> \(userData)")
            self.userInformation = userData
            self.labelUserEmail.text =  self.userInformation[0].email
            self.labelUserName.text = self.userInformation[0].userName
            
        }
    }
    
    @IBAction func Logout(_ sender: UIButton) {
        
        //                print("==========> inside  Logout====")
        if UserManager.shared.getToken() != nil {
            let firbaseAuth = Auth.auth()
            do {
                
                try firbaseAuth.signOut()
                print("Logout Successful From Firebase")
                
            } catch let err {
                print("Firebase error--->",err)
            }
            gotoLoginScreen()
        }
    }
    
    func gotoLoginScreen() {
        
        //        print("==========> inside gotoLoginScreen")
        //remove uid from ns user default
        UserManager.shared.logout()
        viewBackModalProfileTrasperent.isHidden = true
        
        let logintableVc = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.loginTableViewController) as! LoginTableViewController
        logintableVc.loginDelegate = self
        
        self.navigationController?.pushViewController(logintableVc, animated: true)
        
        //        self.present(logintableVc, animated: false, completion: nil)
    }
    
    @IBAction func closeModalProfile(_ sender: UIButton) {
        
        viewBackModalProfileTrasperent.isHidden = true
    }
    
    @IBAction func addNewNote(_ sender: Any) {
        
        let noteDetailController = self.storyboard?.instantiateViewController(withIdentifier: "NoteDetailViewController") as! NoteDetailViewController
        noteDetailController.modalPresentationStyle = .fullScreen
        self.present(noteDetailController, animated: true, completion: nil)
    }
    
    //to grid and list collection view
    @IBAction func toggleGridList(_ sender: Any) {
        
        isGridListActive.toggle()
        
        //using ternary operator intead of if else
        let image = isGridListActive ? UIImage(systemName: "square.grid.2x2") : UIImage(systemName: "rectangle.grid.1x2")
        gridListButton.configuration?.image = image
        
        //toggle() change boolean valur of variable true/false
        //CommonCollectionBackView is iboutlet of  CommonCollectionBackView type
        CommonCollectionBackView.changeGridList(gridList: isGridListActive)
    }
    
    @IBAction func buttonSearchNotes(_ sender: UIButton) {
        
        let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as!
        SearchViewController
        searchVC.modalPresentationStyle = .fullScreen
        present(searchVC, animated: true)
    }
}

extension DashboardViewController:LoginSuccessDelegate {
    
    //it called when we are going from login to dashbboard it pass data
    func loginSuccess(faizString: String) {
        
        //        print("===============>\(faizString)")
        
        ViewTopNavigationBar.isHidden = false
        CommonCollectionBackView.isHidden = false
        ViewBottomTabBar.isHidden = false
        ButtonCreateNewNote.isHidden = false
        
    }
    
    func loginFailure() {
        print("login fail due to some error")
    }
}

extension DashboardViewController: MenuDrawerViewControllerDelegate{
    func presentNewController(drawerItemType: DrawerItemType) {
        if drawerItemType != .notes {
            presentDrawerControllers(type: drawerItemType)
        }
        
        if drawerItemType == .notes {
            print("==============>only dismiss")
        }
    }
    
    @IBAction func openSideMenue(_ sender: UIButton) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "MenuDrawerViewController") as! MenuDrawerViewController
        VC.presentNewScreenDelegate = self
        VC.modalPresentationStyle = .overCurrentContext
        self.present(VC, animated: false)
        //        presentDetailHorizontal(VC)
    }
}


