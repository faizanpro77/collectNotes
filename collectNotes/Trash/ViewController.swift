//
//  ViewController.swift
//  collectNotes
//
//  Created by MD Faizan on 16/12/22.
//

/**
 //  faizyshaikh204@gmail.com
 //  password7
 
 ---------
 ellipsis
 menucard
 ======================================================
 ======================================================
 **rule for google keep notes**
 
 The title of the note. Length must be less than 1,000 characters. The body of the note
 The notes have a character limit of 20,000
 
 //for setting character limit
 if textView.tag == 1 {
 //titleTextView
 return numberOfChars <= 1000
 } else {
 
 return numberOfChars <= 10000
 }
 ======================================================
 ======================================================
 
 ***common think for all project
 icon size for collect notes  width=30  height=20
 
 ======================================================
 ======================================================
 
 ** today task**
 
 {complete today this project}(12pm)
 first implemnt front or first diplay feature or implement important less feature
 
 
 
 4)colour palet---- buttom sheet
 
 
 
 6)landscap potrate safe area view
 notification(only see video)
 
 
 ---------------
 delete permenant
 2)pin
 --------------
 11)long presss dashboard
 4)label
 10)reminder,push notification,local notification
 ------------------------------------------
 
 7)dynamic cell note
 8)seperate protocol file
 9)saperate firbase loginservices quries
 12)store user id in local ns user and every time check from nsuser default
 13)password security hide
 15)modal presentation style left right buttom
 
 14) local storage seperate project or same project
 15)all icon size same
 
 
 **pending**
 1)drawer section index enum by array structure(advance)
 2)selection menue after dismiss controller drawer
 3)drawer tableview touches method not work i want drag drawer from inside
 4)all screen top bar
 
 **complete**
 
 
 -------------------------------------
 
 
 
 
 **pending**
 1)text view placeholder note work like after entering go to next textview field and after entering not go to next line...textview place after enrter go in to next text view after press enter not working
 
 3)after creating empty note go to deshboard and show notification notification (demo)
 4)after touching drawer close and open and move inside
 5) dashboard scroll with top bar and archive screen
 6)touchesBegan touchesMoved touchesEnded this method not work with table view ios swift
 https://www.youtube.com/watch?v=H_eaZ2zu-gs
 
 
 
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
 
 
 
 **die list**
 
 2)text view show only some after scrolling it left some text after entering character it show full text after scrolling
 5)profile logout
 3)search
 1)Archive
 2)updat dashboard note screen  like trash screen
 1)check firebase work
 2)login signup navigation to dashboard...
 3)work on save token in ns user default login,singnup,
 4)signout...clear at signout ns user token
 5)if user is login then after open app navigate it to dashboar direct
 6)change structure of controller
 7)github push all project dawonload and test
 8) check protocole work properly
 9)hide view ,collection, if user not login
 10)connect dashboard with firebase with dummmy data
 11)connect create new note screen with firebase
 12)create note screen ui
 13)update note with firebase
 14)auto height text scroll  both
 15)after pressing enter go next textview
 16)after openinig keyboard bottom bar hide
 17)after scrolling bottom text  of description hide 7 line
 pending
 18)google facebook navigation dashboard
 19)login back button change iphon back button
 20)bottom sheet
 21)grid and list
 22)if user update or edite then only firebase query run
 5)drawer ui and functionality
 3)drawer for all 3 screen (reusable)
 *)clean dashbord merge with new drawer
 *)add table view method with section
 1)clean menue drawer
 1)ui for archive and trash
 design cell title description
 2)archive(collection view)(reusable)
 [firbase array]
 [after selecting cell navigate with particular data]
 3)trash
 [grid list] for trash,Archive
 dashboard Collection view,Grid list
 drawer Icon Colour change
 clean dashboard comment
 drawer animation speed
 
 */



/**
 read about this things
 1)life cycle method in ios
 2)viewDidApear
 3)viewWillApear
 
 
 */

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //15:51
        
        //        Search your notes
    }
    
    
    
}

//========================================================================
//========================================================================
//========================================================================

/**
 *Any*
 Any can represent an instance of any type at all, including function types.
 * Swift provides  special type for working with nonspecific type
 
 
 
 var things: [Any] = []
 
 things.append(0)
 things.append(0.0)
 things.append(42)
 things.append(3.14159)
 things.append("hello")
 
 Typealias
 
 *A type alias allows you to provide a new name for an existing data type into your program. After a type alias is declared, the aliased name can be used instead of the existing type throughout the program.
 
 example
 var message: String?
 typealias Message = String
 var message: Message?
 var customerMessage: Message
 ===================================
 **Codable
 Codable is a type alias for the Encodable and Decodable protocols
 
 
 ** These two protocols are used to indicate whether a certain struct, enum, or class, can be encoded into JSON data, or materialized from JSON data.
 
 typealias Codable = Decodable & Encodable
 
 Decodable (or Deserialization)
 An object that conforms Decodable protocol can be converted from JSON to object.
 
 let student = try? JSONDecoder().decode(Student.self, from: jsonData)
 
 Encodable (or Serialization)
 An object that conforms Encodable protocol can be converted to JSON. Ex:
 
 let jsonData = try? JSONEncoder().encode(student)
 
 if you want to do both you can conform to Codable.
 
 
 */





//ios 15 configrature
//            buttonLogout.configuration = .gray() //background
//            buttonLogout.configuration?.title = "Learn More"
//            buttonLogout.configuration?.baseForegroundColor = .systemPink
//            buttonLogout.configuration?.image = UIImage(systemName: "book.fill")
//            buttonLogout.configuration?.imagePadding = 6
//            buttonLogout.configuration?.baseBackgroundColor = .white
//            buttonLogout.configuration?.imagePlacement = .leading
//            buttonLogout.configuration?.subtitle = "is fun to lun"




//        *this property use when we present screen

//        logintableVc.modalTransitionStyle = .flipHorizontal
//        logintableVc.modalPresentationStyle = .fullScreen



//        *this property use if we want to make controller to root view controller

//        let loginNavigationController = UINavigationController(rootViewController: logintableVc)
//        loginNavigationController.modalPresentationStyle = .fullScreen
//        self.present(loginNavigationController, animated: false, completion: nil)

//        logintableVc.loginDelegate = self



/**
 
 FirebaseNoteService().updateDocument(note: note!) { (status, errorMessage) in
 
 if status == true {
 self.dismiss(animated: true)
 } else {
 //show error
 print("Error while updating the note \(errorMessage ?? "null")")
 }
 }
 */

/**
 
 //for customization of of botton sheet height
 if let sheet = viewController.sheetPresentationController {
 sheet.detents = [
 .custom { _ in
 return 200
 },
 .custom { context in
 return context.maximumDetentValue * 0.6
 }
 ]
 }
 
 */


//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        print("=============>shouldChangeTextIn")
//
//        if text == "\n" {
////            descriptionTextView.becomeFirstResponder()
////            descriptionTextView.beco
//            return false
//        }
//        return true
//    }
//if touch screen it hide keyboard
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }


//    Tells the delegate when the user changes the text or attributes in the specified text view and call after updating UI

//    func textViewDidChange(_ textView: UITextView) {
//        //            print("====================>textViewDidChange")
//        //auto content height of textview
//        textView.isScrollEnabled = true
////        titleTextViewHC.constant = self.titleTextView.contentSize.height
////        descriptionTextViewHC.constant = self.descriptionTextView.contentSize.height
////
//        textView.isScrollEnabled = true
//
//
//    }





//calling protocol function---- calling showNoteDetailsViewcontroller() from CommonCollection file
//extension ArchiveViewController: ShowNoteDetailsDelegate {
//    func showNoteDetailVC(note: Note) {
//        showNoteDetailsViewcontroller(note: note)
//    }
//}










//if we want to present controller from left to right
//extension UIViewController {
//
//    func presentDetailHorizontal(_ viewControllerToPresent: UIViewController) {
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.type = CATransitionType.push
//        transition.subtype = CATransitionSubtype.fromLeft
//        self.view.window!.layer.add(transition, forKey: kCATransition)
//
//        present(viewControllerToPresent, animated: false)
//    }
//}





/**
 drawer related code
 
 //        print("==============>>protocol work good,\(tableIndexNumber)")
 //        var tableRow = DrawerItemType(rawValue: tableIndexNumber)
 
 
 //        var tableRow: tableRowName?
 
 //        if tableIndexNumber != 2 {
 //            if tableIndexNumber == 0 {
 //                 tableRow = .notes
 //            } else if tableIndexNumber == 1 {
 //                tableRow = .reminders
 //            } else if tableIndexNumber == 3 {
 //                tableRow = .bin
 //            }
 
 //            presentDrawerControllers(tableIndexNumber: tableIndexNumber)
 
 //i check here if selected index row of table view is archive then only dismiss controller and if not then present particular screen
 */




//private var frameDrawerView: CGRect = .zero
//self.drawerView.frame = self.frameDrawerView
//        frameDrawerView = drawerView.frame


//giving x & y and height and width
//        drawerView.frame = CGRect(x: -self.drawerView.frame.width,
//                                  y: 0,
//                                  width: drawerView.frame.size.width,
//                                  height: drawerView.frame.size.height)



//if we want to dismiss controller from Right to left

//extension UIViewController {
//
//
//    func dismissDetailHorizontal() {
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.type = CATransitionType.push
//        transition.subtype = CATransitionSubtype.fromRight
//        self.view.window!.layer.add(transition, forKey: kCATransition)
//
//        dismiss(animated: false)
//    }
//}


//============================================

//    var tableViewMenueArray = ["Notes","Reminders","Archive","Bin"]
//    var tableViewImageArray = ["lightbulb","bell","archivebox","trash"]
//
//



//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tableViewMenueArray.count
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell:DrawerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DrawerTableViewCell
//
//        cell.tableViewImage.image = UIImage(systemName: tableViewImageArray[indexPath.row])
//        cell.tableViewLabel.text = tableViewMenueArray[indexPath.row]
//        //        cell.clipsToBounds = true
//        //        cell.layer.cornerRadius = 24
//        //this is for corner radius of selected cell
//        //        cell.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
//        return cell
//    }


//after selcting drawer menue navigate to perticular controller
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("indexPath.section=======>\(indexPath.section)")
//        print("indexPath.row=======>\(indexPath.row)")
//
//        //navigate according to index row to particular screen
//        let drawerItemType = DrawerItemType(rawValue: indexPath.row)!
//        print("============>>>>>drawerItemType ==\(drawerItemType)")
//        selectedDrawerItemType = drawerItemType
//        hideSideDrawer(isPresent: true, drawerItemType: drawerItemType)
//
//
//        /*
//        if indexPath.row == 0  {
//
//            print("indexPath.row=======>\(indexPath.row)")
//
//            hideSideDrawer(isPresent: true,tableIndex: 0)
//
//        } else if indexPath.row == 1 {
//
//            hideSideDrawer(isPresent: true, tableIndex: 1)
//        } else if indexPath.row == 2 {
//
//            hideSideDrawer(isPresent: true,tableIndex: 2)
//        } else if indexPath.row == 3 {
//
//            hideSideDrawer(isPresent: true, tableIndex: 3)
//        }
//        */
//    }



//        if tableIndexNumber == 0 {
//            print("navigate to dashboard")
//
//        } else if tableIndexNumber == 2 {
//
//            let reminderVC = self.storyboard?.instantiateViewController(withIdentifier: "ArchiveViewController") as! ArchiveViewController
//
//
//            reminderVC.modalPresentationStyle = .fullScreen
//            present(reminderVC, animated: true)
//        } else if tableIndexNumber == 3 {
//
//            let TrashVC  = self.storyboard?.instantiateViewController(withIdentifier: "TrashViewController") as! TrashViewController
//
//            TrashVC.modalPresentationStyle = .fullScreen
//            present(TrashVC, animated: true)
//
//        }




//        if tableIndexNumber == 0 {
//            print("navigate to dashboard")
//
//        } else if tableIndexNumber == 1 {
//
//            let reminderVC = self.storyboard?.instantiateViewController(withIdentifier: "RemindersViewController") as! RemindersViewController
//
//
//            reminderVC.modalPresentationStyle = .fullScreen
//            present(reminderVC, animated: true)
//
//        } else if tableIndexNumber == 2 {
//
//            let reminderVC = self.storyboard?.instantiateViewController(withIdentifier: "ArchiveViewController") as! ArchiveViewController
//
//
//            reminderVC.modalPresentationStyle = .fullScreen
//            present(reminderVC, animated: true)
//
//        }




/**
 
 notesArray.append(note)
 //                    print("documentData======>",documentData,"======>",docId)
 
 }
 completion(notesArray)
 } else {
 print(error?.localizedDescription)
 }
 
 
 
 
 //to get note data
 //here i am adding doucument id manually  to  data which is recieve
 func toGetNotesData(completion: @escaping ([Note])->()) {
 
 guard let userId = Auth.auth().currentUser?.uid else {
 return
 }
 
 let db = Firestore.firestore()
 
 let document = db.collection("notesData").document(userId).collection("notes")
 document.getDocuments { (snapshot, error) in
 
 if error == nil && snapshot != nil {
 var notesArray: [Note] = []
 
 for document in snapshot!.documents {
 let docId = document.documentID
 
 var documentData = document.data()
 documentData["id"] = docId
 
 let note = Note(
 title: documentData["title"] as! String,
 description: documentData["description"] as! String,
 id: documentData["id"] as! String,
 trash: documentData["trash"] as! Bool,
 archive: documentData["archive"] as! Bool
 )
 
 notesArray.append(note)
 //                    print("documentData======>",documentData,"======>",docId)
 
 }
 completion(notesArray)
 } else {
 print(error?.localizedDescription)
 }
 }
 }
 
 */





