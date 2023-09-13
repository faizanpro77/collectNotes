//
//  MenueDrawerViewController.swift
//  collectNotes
//
//  Created by MD Faizan on 25/02/23.
//

import UIKit

protocol MenuDrawerViewControllerDelegate {
    
    func presentNewController(drawerItemType: DrawerItemType)
}

class MenuDrawerViewController: UIViewController, UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var presentNewScreenDelegate:MenuDrawerViewControllerDelegate?
    
    
    @IBOutlet weak var drawerView: UIView!
    
    @IBOutlet weak var leadingConstraintForDrawerView: NSLayoutConstraint!
    
    @IBOutlet weak var tableViewMenu: UITableView!
    
    
    @IBOutlet weak var drawerTopBarVeiw: UIView!
    
    //backView Drawer already available
    
    private var onlyOnce = true
    private var isSideDrawerMenuShown: Bool = false
    private var beginPoint:CGFloat = 0.0
    private var difference:CGFloat = 0.0
    
    
    
    var tableViewSectionTitle = ["","LABELS","",""]
    
    var tableViewMenueArray = [["Notes","Reminders"],["add label","Create/Edit labels"],["Archive","Bin"],["Setting","Send app feedback","Help"]]
    
    var tableViewImageArray = [["lightbulb","bell"],["arrowtriangle.right","pencil"],["archivebox","trash"],["gearshape","message", "questionmark.circle"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.isHidden = true
        view.backgroundColor = .clear
        
        //        drawerView.backgroundColor = .systemPink
        
        //        leadingConstraintForDrawerView.constant = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.drawerBackViewTapGesture(_:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        //this is the KEY of the fix when i click on table view row tap gesture click it resolve that
        tap.cancelsTouchesInView = false
        
        self.addBottomShadow()
        //        addTopbarButtomBorder()
        
        
    }
    
    
    
    
    
    //the name suggests the viewWillAppear is called before the view is about to appear and viewDidAppear is called when view did appear.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard onlyOnce else { return }
        onlyOnce = false
        
        
        
        self.drawerView.transform = CGAffineTransform(translationX: -self.drawerView.frame.width, y: 0)
        
        //withDuration: 0.25)
        UIView.animate(withDuration: 0.1) {
            self.drawerView.transform = CGAffineTransform(translationX: 10, y: 0)
        } completion: { (status) in
            self.view.isHidden = false
            self.view.backgroundColor = .black.withAlphaComponent(0.5)
            UIView.animate(withDuration: 0.1) {
                self.drawerView.transform = .identity
            } completion: { (status) in
                self.isSideDrawerMenuShown = true
            }
        }
    }
    
    
    
    
    //its called when we tap on Drawer back view and we want to dismiss drawer
    @objc func drawerBackViewTapGesture(_ sender: UITapGestureRecognizer) {
        
        
        hideSideDrawer()
        
        
    }
    
    func hideSideDrawer(isPresent: Bool = false, drawerItemType: DrawerItemType = .notes) {
        
        UIView.animate(withDuration: 0.1) {
            self.drawerView.transform = CGAffineTransform(translationX: 10, y: 0)
        } completion: { (status) in
            UIView.animate(withDuration: 0.1) {
                self.view.backgroundColor = .clear
                self.drawerView.transform = CGAffineTransform(translationX: -self.drawerView.frame.width, y: 0)
            } completion: { (status) in
                self.view.isHidden = true
                self.isSideDrawerMenuShown = false
                //                self.dismiss(animated: false)
                self.dismiss(animated: false, completion: {
                    //it only call on table row click and not on tap gesture click
                    if isPresent {
                        // i am sending enum for particular selected row so i can present particular screen
                        self.presentNewScreenDelegate?.presentNewController(drawerItemType: drawerItemType)
                    }
                })
            }
        }
    }
    
    
    
    
    //it called when we touch drawer back view
    //it asks touches accept or not
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        //        print("==============>\(touch.view != drawerView)")
        return touch.view != tableViewMenu   //tableViewMenu  //drawerView
        
    }
    
    
    
    
    
    //==================================================================================================
    
    
    //    var selectedIndex = IndexPath(row: -1, section: 0)
    //    after selcting drawer menue navigate to perticular controller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        print("indexPath.section=======>\(indexPath.section)")
        //        print("indexPath.row=======>\(indexPath.row)")
        
        //=-------------------------
        //        let indexesToRedraw = [indexPath]
        //        print("indexesToRedraw==========hh>\(indexesToRedraw)")
        //
        //        selectedIndex = indexPath
        //        tableView.reloadRows(at: indexesToRedraw, with: .fade)
        
        //=-------------------------
        var drawerRowIndex = 0
        if indexPath.section == 0 && indexPath.row == 0 {
            drawerRowIndex = 0
        } else if indexPath.section == 0 && indexPath.row == 1 {
            drawerRowIndex = 1
        } else if indexPath.section == 1 && indexPath.row == 0 {
            drawerRowIndex = 2
        } else if indexPath.section == 1 && indexPath.row == 1 {
            drawerRowIndex = 3
        } else if indexPath.section == 2 && indexPath.row == 0 {
            drawerRowIndex = 4
        } else if indexPath.section == 2 && indexPath.row == 1 {
            drawerRowIndex = 5
        }
        
        //navigate according to index row to particular screen
        let drawerItemType = DrawerItemType(rawValue: drawerRowIndex)!
        //        let drawerItemType = DrawerItemType(rawValue: indexPath.row)!
        //        print("============>>>>>drawerItemType ==\(drawerItemType)")
        selectedDrawerItemType = drawerItemType
        hideSideDrawer(isPresent: true, drawerItemType: drawerItemType)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DrawerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DrawerTableViewCell
        
        cell.tableViewImage.image = UIImage(systemName: tableViewImageArray[indexPath.section][indexPath.row] )
        cell.tableViewLabel.text = tableViewMenueArray[indexPath.section][indexPath.row]
        //        cell.clipsToBounds = true
        cell.layer.cornerRadius = 24
        //this is for corner radius of selected cell
        cell.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
        
        //=-------------------------
        //        let backgroundView = UIView()
        //        backgroundView.backgroundColor = UIColor.yellow
        //        cell.selectedBackgroundView = backgroundView
        
        
        //        if selectedIndex == indexPath { cell.backgroundColor = UIColor.black }
        //=-------------------------
        return cell
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
        //        print("section===============>\(section)")
        return tableViewSectionTitle[section]
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewMenueArray[section].count
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
    
    
    
    
}

extension MenuDrawerViewController {
    
    //Side drawer movment code
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (isSideDrawerMenuShown) {
            if let touch = touches.first {
                let location = touch.location(in: self.view)
                //                print("start at \(location.x)")
                beginPoint = location.x
            }
        }
    }
    
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(isSideDrawerMenuShown){
            if let touch = touches.first {
                let location = touch.location(in: self.view)
                let differenceFromBeginPoint  =  beginPoint - location.x
                if (differenceFromBeginPoint>0 || differenceFromBeginPoint < -310){
                    self.drawerView.transform = CGAffineTransform(translationX: -differenceFromBeginPoint, y: 0)
                    //                    self.leadingConstraintForDrawerView.constant = -differenceFromBeginPoint
                    difference = differenceFromBeginPoint
                    //                    self.backViewForDrawer.alpha = 0.75 - (0.75*differenceFromBeginPoint/310 )
                    let alphaValue = 0.75 - (0.75*differenceFromBeginPoint/310 )
                    self.view.backgroundColor = .black.withAlphaComponent(alphaValue)
                    //                    print("moved at \(differenceFromBeginPoint)====>\(beginPoint)====>\(location.x)")
                    
                }
            }
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (isSideDrawerMenuShown ) {
            //            if let touch = touches.first {
            //                let location = touch.location(in: self.view)
            
            if(difference > 155){
                //close the side drawer
                UIView.animate(withDuration: 0.1) {
                    self.drawerView.transform = CGAffineTransform(translationX: -self.drawerView.frame.width, y: 0)
                    //                        self.leadingConstraintForDrawerView.constant = -310  //-320
                } completion: { (status) in
                    //                        self.backViewForDrawer.alpha = 0.0
                    self.view.backgroundColor = .clear
                    self.isSideDrawerMenuShown = false
                    self.view.isHidden = true
                    self.dismiss(animated: false )
                }
            }else{
                //openside drawer
                UIView.animate(withDuration: 0.5) {
                    self.drawerView.transform = .identity
                    //                        self.leadingConstraintForDrawerView.constant = 0   //-10
                } completion: { (status) in
                    //                        self.backViewForDrawer.alpha = 0.75
                    self.view.backgroundColor = .black.withAlphaComponent(0.5)
                    self.isSideDrawerMenuShown = true
                    self.view.isHidden = false
                }
            }
            //                print("end  at \(location.x)")
            //            }
        }
    }
}


extension MenuDrawerViewController {
    
    func addBottomShadow() {
        
        //for topbar buttom shadow
        drawerTopBarVeiw.layer.masksToBounds = false
        drawerTopBarVeiw.layer.shadowRadius = 4
        drawerTopBarVeiw.layer.shadowOpacity = 1
        drawerTopBarVeiw.layer.shadowColor = UIColor.gray.cgColor
        drawerTopBarVeiw.layer.shadowOffset = CGSize(width: 0 , height: 2)
        drawerTopBarVeiw.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                                      y: drawerTopBarVeiw.bounds.maxY - drawerTopBarVeiw.layer.shadowRadius,
                                                                      width: drawerTopBarVeiw.bounds.width,
                                                                      height: drawerTopBarVeiw.layer.shadowRadius)).cgPath
        
    }
    
    func  addTopbarButtomBorder() {
        
        //    for topbar buttom border
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0.0, y: drawerTopBarVeiw.frame.size.height-1, width: drawerTopBarVeiw.frame.width, height: 1.0)
        bottomBorder.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        drawerTopBarVeiw.layer.addSublayer(bottomBorder)
    }
}









