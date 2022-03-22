//
//  TableViewCell.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 21/12/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit

class UnloggedCaseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fNameLabel: UILabel!
    
    @IBOutlet weak var lNameLabel: UILabel!
    @IBOutlet weak var surgDateLabel: UILabel!
    
    @IBOutlet weak var mrnNumberLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
