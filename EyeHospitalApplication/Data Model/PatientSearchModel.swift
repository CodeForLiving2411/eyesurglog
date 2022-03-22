//
//  PatientSearchDataModel.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 14/12/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import Foundation

struct PatientSearchModel {
    var personId:Int?
    var firstName: String?
    var lastName: String?
    var patientMrn:String?
    var surgeryDate: String?
    var eye : String?
    var status : Int?
}

struct PatientSearchModelUnlogged {
   
    var personId:Int?
    var firstName: String?
    var lastName: String?
    var dob : String?
    var patientMrn:String?
    var surgeryDate: String?
    var status : Int?
}
