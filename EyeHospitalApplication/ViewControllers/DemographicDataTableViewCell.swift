//
//  DemographicDataTableViewCell.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 17/12/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit

class DemographicDataTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dataLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
