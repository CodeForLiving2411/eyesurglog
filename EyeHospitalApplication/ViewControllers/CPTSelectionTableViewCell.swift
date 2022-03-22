//
//  CPTSelectionTableViewCell.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 02/11/20.
//  Copyright © 2020 abhishek dwivedi. All rights reserved.
//

import UIKit



class CPTSelectionTableViewCell: UITableViewCell {
       
    // MARK:- Properties
    
    let cptLabel : UILabel = {
        let label = UILabel()
        label.text = "Test Label"
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.numberOfLines = 2
        return label
    }()
    
    
    // MARK:- Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK:- Selectors
    
    
    // MARK:- Helpers
    
   func  configureUI(){
        
        addSubview(cptLabel)
        cptLabel.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 8, paddingLeft: 20, paddingBottom: 0, paddingRight: 20,  height: 60)
    }
    
    
   

}
