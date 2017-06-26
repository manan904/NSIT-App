//
//  SubjectsTableViewCell.swift
//  NSITApp
//
//  Created by Manan Manwani on 26/06/17.
//  Copyright © 2017 Manan Manwani. All rights reserved.
//

import UIKit

class SubjectsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var subjectName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
