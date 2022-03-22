//
//  TableViewCell.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 16/12/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit
 @available(iOS 13.0, *)
 class SearchCaseTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var lastNameLAbel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var mrnNumber: UILabel!
    
    @IBOutlet weak var eyeType: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
         overrideUserInterfaceStyle = .light    
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // 
        // Configure the view for the selected state
    }

}
