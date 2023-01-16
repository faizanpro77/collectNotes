//
//  DashboardViewController.swift
//  collectNotes
//
//  Created by MD Faizan on 15/01/23.
//

import UIKit
import FirebaseAuth

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var collectionViewDashboard: UICollectionView!
    
    let checkFirebaseLogin = Auth.auth().currentUser?.uid
    
    var notes:[String] = ["Bedsheets&Bedsheets&","BedsheetsklgfjBedsheets&Bedsheets&Bedsheets&Bedsheets&Bedsheets&Bedsheets&sjflsgk","good boy","hero panti","Furniture","kitchen","plane","bike","good","boy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewDashboard.dataSource = self
        collectionViewDashboard.delegate = self
        
        //it is use for collection view bottom and top space
        collectionViewDashboard.contentInset.top = 20
        collectionViewDashboard.contentInset.bottom = 20
        
        guard UserManager.shared.isUserLoggedIn() else { return }
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.dashboardViewController) as! DashboardViewController
//        self.navigationController?.pushViewController(homeViewController, animated: true)
        
        self.present(homeViewController, animated: true, completion: nil)

        
      
    }
    
    @IBAction func showProfile(_ sender: UIButton) {
        print("==========> inside show profile")
        if checkFirebaseLogin != nil {
         let firebaseAuth =  Auth.auth()
            do {
                try firebaseAuth.signOut()
                print("Logout Successful From Firebase")
            } catch let err {
                print("Firebase error--->",err)
            }
        }
        gotoLoginScreen()
        
    }
    
    func gotoLoginScreen() {
        UserManager.shared.logout()
        let  loginTableViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.loginTableViewController) as! LoginTableViewController
        self.navigationController?.pushViewController(loginTableViewController, animated: true)
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
         
        cell.labelTitle.text = notes[indexPath.row]
        cell.labelDescription.text = notes[indexPath.row]
        
//        cell.layer.cornerRadius = 10
//        cell.layer.borderWidth = 1
//        cell.layer.borderColor = UIColor.blue.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let width = ((collectionView.frame.width - 15) / 2) // 15 because of paddings
        print("cell width ====>: \(width)")
        
        //================
        
        //=============
        
        return CGSize(width: width, height: 200)
        
       

    }
}
