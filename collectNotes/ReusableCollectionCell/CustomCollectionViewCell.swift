//
//  CustomCollectionViewCell.swift
//  collectNotes
//
//  Created by MD Faizan on 11/03/23.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var noteTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 10
        layer.borderWidth = 1
        
    }

}
