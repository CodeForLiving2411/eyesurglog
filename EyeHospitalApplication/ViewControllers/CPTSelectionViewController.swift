//
//  CPTSelectionViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 02/11/20.
//  Copyright © 2020 abhishek dwivedi. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)

protocol CptCodesDelegate {
    func SelectedCptCodes(cptCodes : [Any])
    
}



protocol CptCodesEditDelegate {
    func SelectedCptEditCodes(cptCodes : [Any])
    
}

protocol IlmCodesDelegate  {
    func SelectedIlmCodes(ilmCodes : [Any])
}

protocol IlmCodesEditDelegate  {
    func SelectedIlmEditCodes(ilmCodes : [Any])
}

protocol GaugeCodeDelegate {
    func SelectGaugeCode(gaugeCodes : [Any])
}


@available(iOS 13.0, *)
class CPTSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK:- Table View Function
    //==================================
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        
        switch codeType {
        case 1: count = dataList.count
            break
        case 2: count = ilmPeelDataList.count
            break
        case 3: count = gaugeDatalist.count
            break
        default:
            print("wrong option")
        }
       
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CPTSelectionTableViewCell
        
        
        switch codeType {
               case 1:  cell.cptLabel.text = dataList[indexPath.row]
                   break
               case 2: cell.cptLabel.text = ilmPeelDataList[indexPath.row]
                   break
               case 3: cell.cptLabel.text = gaugeDatalist[indexPath.row]
                   break
               default:
                   print("wrong option")
               }
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleSelectedData()
        
    }
   
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        handleSelectedData()
    }
   
    //==================================

    // MARK:- Properties
    
    private var cellReuseIdentifier  = "cptSelectionCell"
    var selectedData : [Any] = []
    var cptCodesDelegate : CptCodesDelegate?
    var cptCodesEditDelegate : CptCodesEditDelegate?
    var ilmCodesDelegate : IlmCodesDelegate?
    var ilmCodesEditDelegate : IlmCodesEditDelegate?
    var gaugeCodeDelegate :GaugeCodeDelegate?
    
    // WHETHER ITS CPT CODE TYPE R ILM PEEL CODE TYPE
    var codeType = 0
    
    var dataList = [ "Select CPT Code" ,"67036 - PPV" , "67039 - PPV with focal laser" , "67040 - PPV with PRP laser" , "67041 - PPV for ERM" , "67042 - PPV with ILM peel (MH)"  , "67043 - PPV with subretinal membrane removal" , "67107 - Scleral buckle for RRD" , "67108 - PPV with or without SB for RRD" , "67110 - Pneumatic retinopexy" , "67113 - Complex RD repair" , "67121 - Removal of implanted material" ,"67141 - Cryo tear" , "67145 - Laser tear or lattice" , "66825 - IOL reposition" , "66850 - Removal of lens material" , "66985 - Insert secondary IOL" , "66986 - IOL exchange" , "65236 - Remove IOFB from AC" , "65260 - Remove IOFB from vitreous with magnet" , "65265 - Remove IOFB from vitreous without magnet" , "67015- Choroidal Drainage" ]
    
    var ilmPeelDataList = ["Select ILM Peel Code" ,"ICG","BBG" , "triamcinolone" , "None"]
    
    var gaugeDatalist = [ "20" , "23", "25" , "27"  ]
    
    // Cpt Code Title Label
        let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Select CPT Codes"
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .link
        return label
    }()
    //
    let titleLabelIlm : UILabel = {
           let label = UILabel()
           label.text = "Select ILM Peel Codes"
           label.font = UIFont.boldSystemFont(ofSize: 14.0)
           label.textAlignment = .center
           label.numberOfLines = 2
           label.textColor = .link
           return label
       }()
    
   
    let titleLabeGauge : UILabel = {
              let label = UILabel()
              label.text = "Select Gauge"
              label.font = UIFont.boldSystemFont(ofSize: 14.0)
              label.textAlignment = .center
              label.numberOfLines = 2
              label.textColor = .link
              return label
          }()
    
    // Done Button
    private let doneButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true // height
     
     button.widthAnchor.constraint(equalToConstant: 70).isActive = true // height
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18) // font
       // button.addTarget(self, action: #selector(), for: .touchUpInside)
        return button
       
    }()
    
    var tableView : UITableView =  {
        
        let tView = UITableView()
        tView.rowHeight = 40
        tView.separatorStyle = .none
        tView.backgroundColor = UIColor(white: 1, alpha: 0.95)
    
        tView.allowsMultipleSelection = true
        tView.allowsMultipleSelectionDuringEditing = true
        tView.showsVerticalScrollIndicator = false
       
        return tView
    }()
    
    
    override func viewDidAppear(_ animated: Bool) {
       ConfigureUI()
    }
    
    
    
     // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .init(white: 1, alpha: 1)
        
       
    }
    
    
    
    
    // MARK:- Selectors
    
    @objc func handleDoneButton(){
        
        if selectedData.count >= 1 && selectedData.count < 4 {
        cptCodesDelegate?.SelectedCptCodes(cptCodes: selectedData)
            
       cptCodesEditDelegate?.SelectedCptEditCodes(cptCodes: selectedData)
            
        dismiss(animated: true, completion: nil)
        }
        else {
            displayAlertMessage(messageToDisplay: "Please select aleast 1 or altmost 3 CPT Codes. If nothing to be selected then select the first option")
        }
    }
    
    
    @objc func handleIlmDoneButton(){
        
        if selectedData.count >= 1 && selectedData.count < 3 {
            ilmCodesDelegate?.SelectedIlmCodes(ilmCodes: selectedData)
            
            ilmCodesEditDelegate?.SelectedIlmEditCodes(ilmCodes: selectedData)
            
         dismiss(animated: true, completion: nil)
        }
        else {
            displayAlertMessage(messageToDisplay: "Please select aleast 1 or altmost 2 ILM Codes. If nothing to be selected then select the first option")
        }
    }
    
    
    @objc func handleGaugeDoneButton(){
        
        if selectedData.count >= 1 && selectedData.count < 3 {
            gaugeCodeDelegate?.SelectGaugeCode(gaugeCodes: selectedData)
          
         dismiss(animated: true, completion: nil)
        }
        else {
            displayAlertMessage(messageToDisplay: "Please select aleast 1 or altmost 2 Gauges. If nothing to be selected then select the first option")
        }
    }
    
    
    
    
    
    // MARK:- Helpers
    
    func ConfigureUI(){
        
        // Code Type  1 For the Cpt Code and Code Type 2 for ILM Peel Codes
        if codeType == 1 {
            doneButton.addTarget(self, action: #selector(handleDoneButton), for: .touchUpInside)
                 configureTableView()
                 tableViewDelegate()
                  
                  view.addSubview(titleLabel)
                  titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30,  height: 40)
                  
                  view.addSubview(doneButton)
                  doneButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,  right: view.rightAnchor, paddingTop: 30,  paddingRight: 20, width: 100, height: 40)
                  
                  view.addSubview(tableView)
                  
                  tableView.register(CPTSelectionTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier )
                  tableView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 30, paddingBottom: 30,  height: 60)
        }
        else if codeType == 2 {
            
            doneButton.addTarget(self, action: #selector(handleIlmDoneButton), for: .touchUpInside)
                            configureTableView()
                            tableViewDelegate()
                             
                             view.addSubview(titleLabelIlm)
                             titleLabelIlm.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30,  height: 40)
                             
                             view.addSubview(doneButton)
                             doneButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,  right: view.rightAnchor, paddingTop: 30,  paddingRight: 20, width: 100, height: 40)
                             
                             view.addSubview(tableView)
                             
                             tableView.register(CPTSelectionTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier )
                             tableView.anchor(top: titleLabelIlm.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 30, paddingBottom: 30,  height: 60)
        }
        
        else if codeType == 3 {
            
            doneButton.addTarget(self, action: #selector(handleGaugeDoneButton), for: .touchUpInside)
                            configureTableView()
                            tableViewDelegate()
                             
                             view.addSubview(titleLabeGauge)
                             titleLabeGauge.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30,  height: 40)
                             
                             view.addSubview(doneButton)
                             doneButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,  right: view.rightAnchor, paddingTop: 30,  paddingRight: 20, width: 100, height: 40)
                             
                             view.addSubview(tableView)
                             
                             tableView.register(CPTSelectionTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier )
                             tableView.anchor(top: titleLabeGauge.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 30, paddingBottom: 30,  height: 60)
        }
        else {
            print("Invalid Selection...")
        }
        
     
        
    }
    
    
          // configure Table View
       func configureTableView(){
            tableViewDelegate()
          
       }
         // configure Table View Delegate
       func tableViewDelegate(){
           tableView.delegate = self
           tableView.dataSource = self
           
       }
    
    func handleSelectedData(){
        
        let selectedIndexPaths = tableView.indexPathsForSelectedRows
        
        print(" DEBUG : Selected index path  "  , selectedIndexPaths)
        
        if codeType == 1 {
            self.selectedData = selectedIndexPaths?.map { dataList[$0.row] } as! [Any]
        } else if codeType == 2 {
             self.selectedData = selectedIndexPaths?.map { ilmPeelDataList[$0.row] } as! [Any]
        }
        else if codeType == 3 {
             self.selectedData = selectedIndexPaths?.map { gaugeDatalist[$0.row] } as! [Any]
        }
        else {
            print("In correct choice at data selection at surgery drop downs")
        }
        
        
        print("selected Data " , selectedData   )


    }
    
    

    func displayAlertMessage(messageToDisplay : String)
    {
        let alertController = UIAlertController(title: "Alert",
                                                message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title : "Ok", style : .default){
            (action :UIAlertAction) in
         
           
        }
       alertController.addAction(OKAction)
        self.present(alertController, animated: true,completion: nil)
        
        
    }
    
    
    
    
    
    
    

}
