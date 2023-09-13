//
//  SearchViewController.swift
//  collectNotes
//
//  Created by MD Faizan on 29/03/23.
//

/**
 1)call function after type string textfield
 2)call function from searchcontroller to commoncollection and pass string
 3)search using string show notes
 
 */

import UIKit

class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var viewCommonCollectionBack: CommonCollectionView!
    
    
    @IBOutlet weak var textFieldSearch: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewCommonCollectionBack.cleanArrayInitialData()
        
        //callback --- calling showNoteDetailsViewcontroller() from CommonCollection file
        viewCommonCollectionBack.showNotesDetailsViewControllerCallback = {(noteItem) in
            self.showNoteDetailsViewcontroller(note: noteItem)
        }
    }
    
    
    //    override func viewWillAppear(_ animated: Bool) {
    //
    //        viewCommonCollectionBack.showParticularNotesCollectionData(type: .SearchController)
    //
    //    }
    
    
    @IBAction func searchChanged(_ sender: UITextField) {
        
        //        print("textFieldSearch======= \(String(describing: textFieldSearch.text))" )
        //        viewCommonCollectionBack.getSearchNotes(searchString: textFieldSearch.text!)
        viewCommonCollectionBack.getNotes(isSearch:true,searchString: textFieldSearch.text!)
    }
    
    //after clicking on cross icon clean text field
    @IBAction func cleanTextFeildText(_ sender: UIButton) {
        
        textFieldSearch.text = ""
        viewCommonCollectionBack.getNotes(isSearch:true,searchString: textFieldSearch.text!)
    }
    
    @IBAction func buttonBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    
    
}
