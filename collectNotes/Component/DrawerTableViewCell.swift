//
//  DrawerTableViewCell.swift
//  collectNotes
//
//  Created by MD Faizan on 28/02/23.
//

import UIKit

class DrawerTableViewCell: UITableViewCell {

  
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
