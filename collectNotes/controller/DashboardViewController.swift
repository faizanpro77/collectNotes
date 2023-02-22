//
//  DashboardViewController.swift
//  collectNotes
//
//  Created by MD Faizan on 15/01/23.
//

import UIKit
import FirebaseAuth

/**
 1 import
 iboutlet
 varaibles
 view didload
 life cycle method
 ibaction
 setup method
normal method
 
 varaible,function,iboutlet,ibaction===>small,camal case
 class name,structure,enum,protocol,controller name===>capital
 */



protocol LoginSuccessDelegate: AnyObject{
    func loginSuccess(faizString:String)
    func loginFailure()
}

class DashboardViewController: UIViewController {
    
    
    
    @IBOutlet weak var ViewTopNavigationBar: UIView!
    @IBOutlet weak var collectionViewDashboard: UICollectionView!
    @IBOutlet weak var ViewBottomTabBar: UIView!
    @IBOutlet weak var ButtonCreateNewNote: UIButton!
    @IBOutlet weak var gridListButton: UIButton!
    @IBOutlet weak var backViewForDrawer: UIView!
    @IBOutlet weak var drawerView: UIView!
    @IBOutlet weak var leadingConstraintForDrawerView: NSLayoutConstraint!
    
    //    var checkFirebaseLogin = Auth.auth().currentUser?.uid
    var isGridListActive:Bool = false
    var sideDrawerViewController:SideDrawerViewController?
    private var isSideDrawerMenuShown:Bool = false
    private var beginPoint:CGFloat = 0.0
    private var difference:CGFloat = 0.0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //it called when user not login
        if UserManager.shared.getToken() == nil {
            
            //hide dashboard controller data or ui
            ViewTopNavigationBar.isHidden = true
            collectionViewDashboard.isHidden = true
            ViewBottomTabBar.isHidden = true
            ButtonCreateNewNote.isHidden = true
        }
        
        collectionViewDashboard.dataSource = self
        collectionViewDashboard.delegate = self
        
        //it is use for collection view bottom and top space
        collectionViewDashboard.contentInset.top = 20
        collectionViewDashboard.contentInset.bottom = 20
        
        backViewForDrawer.isHidden = true
        
    
    }
    
    
    //    var notes:[String] = ["Bedsheets&Bedsheets&","BedsheetsklgfjBedsheets&Bedsheets&Bedsheets&Bedsheets&Bedsheets&Bedsheets&sjflsgk","good boy","hero panti","Furniture","kitchen","plane","bike","good","boy"]
    
    
    
    
    @IBAction func tapedOnDrawerBackView(_ sender: UITapGestureRecognizer) {
        
        self.hideSideDrawerMenue()
    }
    
    var notes: [Note] = [Note(title: "Loading", description: "......", id: "1")]
    
    func getNotes() {
        FirebaseNoteService().toGetNotesData{ (notesData) in
            self.notes = notesData
            self.collectionViewDashboard.reloadData()
            
        }
        
    }
    
    
    //This is called just before the view controller is added to the view hierarchy and shown to the user.
    //You can override this method to perform custom tasks associated with displaying the view.
    
    override func viewWillAppear(_ animated: Bool) {
        getNotes()
        
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
            print(">>>>>>>>>>>>>>>>>>>>>e> user login \(UserManager.shared.getToken()!)")
            
        }
    }
    
    
    
    @IBAction func showProfile(_ sender: UIButton) {
        //        print("==========> inside show profile====")
        
        
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
        
        let logintableVc = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.loginTableViewController) as! LoginTableViewController
        logintableVc.loginDelegate = self
        
        
        self.navigationController?.pushViewController(logintableVc, animated: true)
        
        //        self.present(logintableVc, animated: false, completion: nil)
        
    }
    
    @IBAction func addNewNote(_ sender: Any) {
        
        let noteDetailController = self.storyboard?.instantiateViewController(withIdentifier: "NoteDetailViewController") as! NoteDetailViewController
        noteDetailController.modalPresentationStyle = .fullScreen
        self.present(noteDetailController, animated: true, completion: nil)
    }
    
    
    //to grid and list collection view
    @IBAction func toggleGridList(_ sender: Any) {
        //using ternary operator intead of if else
        let image = isGridListActive ? UIImage(systemName: "square.grid.2x2") : UIImage(systemName: "rectangle.grid.1x2")
        gridListButton.configuration?.image = image
        //toggle() change boolean valur of variable true/false
        isGridListActive.toggle()
        collectionViewDashboard.reloadData()
    }
}


extension DashboardViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NotesCollectionViewCell
        let note = notes[indexPath.row]
        cell.labelTitle.text = note.title
        cell.labelDescription.text = note.description
        
        //        cell.labelTitle.text = notes[indexPath.row].title
        //       cell.labelDescription.text = notes[indexPath.row].description
        
        //        cell.layer.cornerRadius = 10
        //        cell.layer.borderWidth = 1
        //        cell.layer.borderColor = UIColor.blue.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
      
        //        print("cell width ====>: \(width)")
        var width:CGFloat = (collectionView.frame.width - 15) / 2
       
        if isGridListActive {
            width = collectionView.frame.width
        } else {
            width = (collectionView.frame.width - 15) / 2
        }
        
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let noteDetailController = self.storyboard?.instantiateViewController(withIdentifier: "NoteDetailViewController") as! NoteDetailViewController
        noteDetailController.modalPresentationStyle = .fullScreen
        noteDetailController.note = notes[indexPath.item]
        noteDetailController.noteType = .update
        present(noteDetailController, animated: true, completion: nil)
    }
}


extension DashboardViewController:LoginSuccessDelegate {
    
    //it called when we are going from login to dashbboard it pass data
    func loginSuccess(faizString: String) {
        
        //        print("===============>\(faizString)")
        
        ViewTopNavigationBar.isHidden = false
        collectionViewDashboard.isHidden = false
        ViewBottomTabBar.isHidden = false
        ButtonCreateNewNote.isHidden = false
        
    }
    
    
    func loginFailure() {
        print("login fail due to some error")
    }
}


extension DashboardViewController: SideDrawerViewControllerDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "drawerSegue"){
            if let controller = segue.destination as? SideDrawerViewController {
                self.sideDrawerViewController = controller
                self.sideDrawerViewController?.delegate = self
                
            }
        }
    }
    
    @IBAction func openSideMenue(_ sender: UIButton) {
       
        UIView.animate(withDuration: 0.1) {
            self.leadingConstraintForDrawerView.constant = 10
            self.view.layoutIfNeeded()
            
        } completion: { (status) in
            self.backViewForDrawer.isHidden = false
            self.backViewForDrawer.alpha = 0.75
            UIView.animate(withDuration: 0.1) {
                self.leadingConstraintForDrawerView.constant = 0
                self.view.layoutIfNeeded()
            } completion: { (status) in
                self.isSideDrawerMenuShown = true
            }

        }
    }
    
    func hideSideDrawer() {
        print("=================>side Drawer called")
        self.hideSideDrawerMenue()
    }
    
    private func hideSideDrawerMenue() {
        
        UIView.animate(withDuration: 0.1) {
            
            self.leadingConstraintForDrawerView.constant = 10
            self.view.layoutIfNeeded()
        } completion: { (status) in
            UIView.animate(withDuration: 0.1) {
                self.backViewForDrawer.alpha = 0.0
                self.leadingConstraintForDrawerView.constant = -310
                self.view.layoutIfNeeded()
            } completion: { (status) in
                self.backViewForDrawer.isHidden = true
                self.isSideDrawerMenuShown = false
            }
        }
    }
    
    //Side drawer movment code
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (isSideDrawerMenuShown) {
            if let touch = touches.first {
                let location = touch.location(in: backViewForDrawer)
                print("start at \(location.x)")
                beginPoint = location.x
            }
        }
    }
   
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(isSideDrawerMenuShown){
            if let touch = touches.first {
                let location = touch.location(in: backViewForDrawer)
                let differenceFromBeginPoint  =  beginPoint - location.x
                if (differenceFromBeginPoint>0 || differenceFromBeginPoint < -310){
                    self.leadingConstraintForDrawerView.constant = -differenceFromBeginPoint
                    difference = differenceFromBeginPoint
                    self.backViewForDrawer.alpha = 0.75 - (0.75*differenceFromBeginPoint/310 )
                    print("moved at \(differenceFromBeginPoint)====>\(beginPoint)====>\(location.x)")
                     
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (isSideDrawerMenuShown ) {
            if let touch = touches.first {
                let location = touch.location(in: backViewForDrawer)
                
                if(difference > 155){
                    //close the side drawer
                    UIView.animate(withDuration: 0.5) {
                        self.leadingConstraintForDrawerView.constant = -310  //-320
                    } completion: { (status) in
                        self.backViewForDrawer.alpha = 0.0
                        self.isSideDrawerMenuShown = false
                        self.backViewForDrawer.isHidden = true
                    }
                }else{
                    //openside drawer
                    UIView.animate(withDuration: 0.5) {
                        self.leadingConstraintForDrawerView.constant = 0   //-10
                    } completion: { (status) in
                        self.backViewForDrawer.alpha = 0.75
                        self.isSideDrawerMenuShown = true
                        self.backViewForDrawer.isHidden = false
                        
                    }

                    
                }
                print("end  at \(location.x)")
            }
        }
    }
    
}





//        *this property use when we present screen

//        logintableVc.modalTransitionStyle = .flipHorizontal
//        logintableVc.modalPresentationStyle = .fullScreen



//        *this property use if we want to make controller to root view controller

//        let loginNavigationController = UINavigationController(rootViewController: logintableVc)
//        loginNavigationController.modalPresentationStyle = .fullScreen
//        self.present(loginNavigationController, animated: false, completion: nil)

//        logintableVc.loginDelegate = self
