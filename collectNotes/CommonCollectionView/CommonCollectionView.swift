//
//  CommonCollectionView.swift
//  collectNotes
//
//  Created by MD Faizan on 11/03/23.
//


//MARK: it is a common collection view xib file
import UIKit

enum CommonCollectionController {
    
    case dashboardController
    case archiveController
    case TrashController
//    case SearchController
    
}



//@IBDesignable
class CommonCollectionView: UIView {
    
    
    @IBOutlet weak var commonCollection: UICollectionView!
    
    //protocol type variable for calling function
    //    var showNoteDetailsProtocolDelegate: ShowNoteDetailsDelegate?
    
    @IBOutlet var containerView: UIView!
    
    
    
    var filterNoteData: [Note] = [Note(title: "Loading", description: "......", id: "1",trash: false, archive: false)]
    
    //it is callback variable for calling archive function
    var showNotesDetailsViewControllerCallback: ((Note) -> ())?

    // clean Note Array initial data or default data for search screen
    func cleanArrayInitialData() {
        let emptyArray: [Note] = []
        filterNoteData = emptyArray
    }
    
    func getNotes(isArchive:Bool = false, isTrash:Bool = false, isNotes:Bool = false, isSearch:Bool = false, searchString:String = "") {
        FirebaseNoteService().toGetNotesData{ (notesData) in
            
            if isArchive == true {
                self.filterNoteData = notesData.filter{$0.archive == true && $0.trash == false}
            } else if isTrash == true {
                self.filterNoteData = notesData.filter{$0.trash == true }
            } else if isNotes == true {
                self.filterNoteData = notesData.filter{$0.trash == false &&  $0.archive == false  }
            } else if isSearch == true {
                self.filterNoteData = notesData.filter({
                    $0.title.range(of: searchString, options: .caseInsensitive) != nil || $0.description.range(of: searchString, options: .caseInsensitive) != nil
                })
            }
            
            self.commonCollection.reloadData()
        }
        
    }
    
    
    
    
    //    var notes:[String] = ["Bedsheets","dsheets&Bedsheets","good boy","hero panti","Furniture","kitchen","plane","bike","good","boy","Bedsheets","dsheets&Bedsheets","good boy","hero panti","Furniture","kitchen","plane","bike","good"]
    
    //    var notes:[String] = ["loading.."]
    
    
    func showParticularNotesCollectionData (type:CommonCollectionController) {
        
        switch type {
        case .archiveController:
//            print("commonCollection==============>>archive")
            getNotes(isArchive:true)
            
        case .TrashController:
//            print("commonCollection==============>>bin")
            getNotes(isTrash: true)
            
        case .dashboardController:
//            print("commonCollection==============>>dashboard")
            getNotes(isNotes: true)
            
        default:
            break
        }
        
        commonCollection.reloadData()
//        print("=============333=>>\(filterNoteData)")
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
        //        containerView.backgroundColor = .red
        initCollectionView()
        
    }
    
    
    private func initCollectionView() {
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        commonCollection.register(nib, forCellWithReuseIdentifier: "CustomCell")
        commonCollection.dataSource = self
        commonCollection.delegate = self
        
        //it is use for collection view bottom and top space
        commonCollection.contentInset.top = 10
        commonCollection.contentInset.bottom = 10
        
        commonCollection.contentInset.left = 10
        commonCollection.contentInset.right = 10
    }
    
    //this is for change grid List View it is calling from ArchiveViewControllre,TrashViewController,DashboardViewController
    var isGrideListActive:Bool = false
    func changeGridList(gridList:Bool) {
        isGrideListActive = gridList
        self.commonCollection.reloadData()
        
        
    }
    
}


extension CommonCollectionView: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterNoteData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCollectionViewCell else {
            fatalError("can't dequeue Custom Cell")
        }
        //        cell.noteTitle.text =  notes[indexPath.row]
        //        cell.noteDescription.text = notes[indexPath.row]
        let note = filterNoteData[indexPath.row]
        cell.noteTitle.text =  note.title
        cell.noteDescription.text = note.description
        
        //         cell.configureCell(note: notes[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        print("good")
        //        let width:CGFloat = (collectionView.frame.width - 15) / 2
        
        var width:CGFloat = (collectionView.frame.width - 35) / 2
        if isGrideListActive {
            width = collectionView.frame.width - 20
        } else {
            
            width = (collectionView.frame.width - 35) / 2
        }
        
        return CGSize(width: width, height: 200)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        print("goood")
        var noteData:Note
        noteData = filterNoteData[indexPath.item]
        
        //by using callback function
        showNotesDetailsViewControllerCallback?((noteData))
        
        //by using protocol we call Archive controller function here
        //        showNoteDetailsProtocolDelegate?.showNoteDetailVC(note: noteData)
        
        
        
    }
}


