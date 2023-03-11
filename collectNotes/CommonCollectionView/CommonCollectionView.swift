//
//  CommonCollectionView.swift
//  collectNotes
//
//  Created by MD Faizan on 11/03/23.
//

import UIKit

//@IBDesignable
class CommonCollectionView: UIView {

    
    @IBOutlet weak var commonCollection: UICollectionView!
    
    
    @IBOutlet var containerView: UIView!
    

    @IBOutlet weak var lblTitle: UILabel!
    
    /**
     
     var notes: [Note] = [Note(title: "Loading", description: "......", id: "1")]
     
     func getNotes() {
         FirebaseNoteService().toGetNotesData{ (notesData) in
             self.notes = notesData
             self.collectionViewDashboard.reloadData()
         }
     
     */
    
    
//    var notes:[String] = ["Bedsheets","dsheets&Bedsheets","good boy","hero panti","Furniture","kitchen","plane","bike","good","boy","Bedsheets","dsheets&Bedsheets","good boy","hero panti","Furniture","kitchen","plane","bike","good"]
    
    var notes:[String] = ["loading.."]
    
    
    func showParticularNotesCollectionData (type:DrawerItemType) {
        
        switch type {
        case .archive:
            print("commonCollection==============>>archive")
             notes = ["archive","archive","archive","archive","archive","archive","archive","archive","archive","archive","archive","archive"]
        case .bin:
            print("commonCollection==============>>bin")
             notes = ["Bin","Bin","Bin","Bin","Bin","Bin","Bin","Bin","Bin","Bin","Bin","Bin","Bin","Bin","Bin","Bin","Bin","Bin"]
        default:
            break
        }
        
        commonCollection.reloadData()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
        
    }
    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//
//    }
    
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           
        commonInit()
       }
    
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("CommonCollectionView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        containerView.backgroundColor = .red
        initCollectionView()
        
    }
    
    
    private func initCollectionView() {
      let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        commonCollection.register(nib, forCellWithReuseIdentifier: "CustomCell")
        commonCollection.dataSource = self
        commonCollection.delegate = self
    }
    
}


extension CommonCollectionView: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        1
//    }
//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCollectionViewCell else {
            fatalError("can't dequeue Custom Cell")
        }
        cell.noteTitle.text =  notes[indexPath.row]//"\(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("good")
        let width:CGFloat = (collectionView.frame.width - 15) / 2
        
        return CGSize(width: width, height: 200)
    }
}


