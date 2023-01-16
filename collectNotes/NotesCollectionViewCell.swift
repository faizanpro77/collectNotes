//
//  NotesCollectionViewCell.swift
//  collectNotes
//
//  Created by MD Faizan on 15/01/23.
//

import UIKit

class NotesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!    
    @IBOutlet weak var labelDescription: UILabel!
    
    
    //When an object receives an awakeFromNib message, it is guaranteed to have all its outlet and action connections already established.
    //The commonly recommended place to do custom initialization for custom views
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        print("awakeFromNib called===============>")
        labelTitle.textColor = .black
        labelDescription.textColor = .gray
        labelTitle.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        labelDescription.font = UIFont.systemFont(ofSize: 18)
        
//        self.contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight]
        
        
    }
    
    //any time the frame changes layoutSubviews() is called
    //Subclasses can override this method as needed to perform more precise layout of their subviews. You should override this method only if the autoresizing and constraint-based behaviors

    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubviews called===============>")
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 10
        layer.borderWidth = 1
        
    }
    
}
