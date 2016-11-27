//
//  FrankenTableViewCell.swift
//  Frankentable
//
//  Created by Eric Chang on 11/27/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FrankenTableViewCell: UITableViewCell {

    @IBOutlet weak var wordTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
