//
//  SurgeryDataTableViewCell.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 18/12/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SurgeryDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dataLabel: UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
         overrideUserInterfaceStyle = .light    
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
