//
//  SideDrawerViewController.swift
//  collectNotes
//
//  Created by MD Faizan on 13/02/23.
//

import UIKit

protocol SideDrawerViewControllerDelegate {
    
    func hideSideDrawer()
    
}

class SideDrawerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate {
    
    
    
    
    @IBOutlet weak var tableViewMenu: UITableView!
    
    
    @IBOutlet weak var drawerTopBarVeiw: UIView!
    
    
    //    var tableViewMenueArray = ["Notes","Reminders","Create/Edit labels","Archive","Bin","Setting","Send app feedback","Help"]
    
    
    //    var tableViewImageArray = ["lightbulb","bell","pencil","archivebox","trash","gearshape","message", "questionmark.circle"]
    
    var tableViewSectionTitle = ["","LABELS","",""]
    //    var tableViewSectionTitle = ["LABELS","LABELS","LABELS","LABELS"]
    
    
    var tableViewMenueArray = [["Notes","Reminders"],["add label","Create/Edit labels"],["Archive","Bin"],["Setting","Send app feedback","Help"]]
    
    var tableViewImageArray = [["lightbulb","bell"],["arrowtriangle.right","pencil"],["archivebox","trash"],["gearshape","message", "questionmark.circle"]]
    
    var delegate:SideDrawerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //for topbar buttom shadow
        drawerTopBarVeiw.layer.masksToBounds = false
        drawerTopBarVeiw.layer.shadowRadius = 4
        drawerTopBarVeiw.layer.shadowOpacity = 1
        drawerTopBarVeiw.layer.shadowColor = UIColor.gray.cgColor
        drawerTopBarVeiw.layer.shadowOffset = CGSize(width: 0 , height: 0.5)
        drawerTopBarVeiw.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                                      y: drawerTopBarVeiw.bounds.maxY - drawerTopBarVeiw.layer.shadowRadius,
                                                                      width: drawerTopBarVeiw.bounds.width,
                                                                      height: 0.7 )).cgPath
        //for tipbar buttom border
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0.0, y: drawerTopBarVeiw.frame.size.height-1, width: drawerTopBarVeiw.frame.width, height: 1.0)
        bottomBorder.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        drawerTopBarVeiw.layer.addSublayer(bottomBorder)
        
        
        //for space between table view top to first cell row
        self.tableViewMenu.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0);
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section <= 2 {
            return 1
        } else{
            return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        
        if section == 1{
            return 20
        }else{
            return 0
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print("section===============>\(section)")
        return tableViewSectionTitle[section]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewMenueArray[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        cell.tableViewImage.image = UIImage(systemName: tableViewImageArray[indexPath.section][indexPath.row] )
        cell.tableViewLabel.text = tableViewMenueArray[indexPath.section][indexPath.row]
        //        cell.clipsToBounds = true
        cell.layer.cornerRadius = 24
        //this is for corner radius of selected cell
        cell.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
        return cell
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        
        let separatorView = UIView(frame: CGRect(x: 50,
                                                 y: 0,
                                                 width: tableView.frame.width,
                                                 height: 1))
        separatorView.backgroundColor = .gray
        footerView.addSubview(separatorView)
        
        return footerView
        
    }
    
    //after selcting drawer menue navigate to perticular controller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath.section=======>\(indexPath.section)")
        print("indexPath.row=======>\(indexPath.row)")
        
        
        if indexPath.section == 0 && indexPath.row == 0  {
           
            self.delegate?.hideSideDrawer()
        
        } else if indexPath.section == 2 && indexPath.row == 0 {
            
            print("indexPath.row=======>\(indexPath.row)")
            self.delegate?.hideSideDrawer()
            let archiveVC:ArchiveViewController  = self.storyboard?.instantiateViewController(withIdentifier: "ArchiveViewController") as! ArchiveViewController
            //            self.navigationController?.pushViewController(archiveVC, animated: true)
            archiveVC.modalPresentationStyle = .fullScreen
            present(archiveVC, animated: true)
            
        }
    }
   
    
    
    
    //==================>class end
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
//        return true
//    }
}








//tableview delegate function
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        view.tintColor = .yellow
//    }

//    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
//        view.tintColor = .blue
//
//    }

//func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
// cell.backgroundColor = .orang
// }
