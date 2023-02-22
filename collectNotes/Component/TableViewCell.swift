//
//  TableTableViewCell.swift
//  collectNotes
//
//  Created by MD Faizan on 15/02/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var tableViewImage: UIImageView!
    
    @IBOutlet weak var tableViewLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
