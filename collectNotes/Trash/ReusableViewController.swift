//
//  ReusableViewController.swift
//  collectNotes
//
//  Created by MD Faizan on 23/02/23.
//

import UIKit

class ReusableCollectionView: UICollectionView {
    
    
    
//        var notes:[String] = ["Bedsheets&Bedsheets&","BedsheetsklgfjBedsheets&Bedsheets&Bedsheets&Bedsheets&Bedsheets&Bedsheets&sjflsgk","good boy","hero panti","Furniture","kitchen","plane","bike","good","boy"]
    

//    var notes:[Note] = []
    override func numberOfItems(inSection section: Int) -> Int {
        return 5
    }
    
    override func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell? {
        return UICollectionViewCell()
        
    }
   
    
    
    
    
}
