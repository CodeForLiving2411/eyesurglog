//
//  DBManager.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 25/11/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import Foundation


class DatabaseManager: NSObject{
    
   
    
    static let shared: DatabaseManager = DatabaseManager()
    
//    class func getInstance() -> DatabaseManager{
//        if shareInstance.database == nil{
//            shareInstance.database = FMDatabase(path: Util.getPath("SurgLogAppDB.db"))
//        }
//        return shareInstance
//    }
    
    
   
    let databaseFileName = "SurgLogAppDB.sqlite3"
    
    var pathToDatabase: String!
    
    var database: FMDatabase!
    
   
    override init() {
        super.init()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    
    
   // for the creation of Database and table of Registration Table
    func createDatabase() -> Bool {
        
        var created = false
        
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)
            
            if database != nil {
                // Open the database.
                if database.open() {
                    let createRegistrationTableQuery = "CREATE TABLE IF NOT EXISTS Registration ( personId integer primary key autoincrement not null, firstName text, lastName text, emailId text, employeeCode text, password text , securityQuestion text , securityAnswer text)"
                    
                    do {
                        try database.executeUpdate(createRegistrationTableQuery, values: nil)
                        created = true
                    }
                    catch {
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }
                    
                    // At the end close the database.
                    database.close()
                }
                else {
                    print("Could not open the database.")
                }
            }
        }
        
        return created
    }
   
    //  functioon to open the database everytime
    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        
        if database != nil {
            if database.open() {
                return true
            }
        }
        
        return false
    }
    
    
  // to insert data in registration table
    func insertRegistrationData(_ modelInfo:RegistrationModel) -> Bool {
     //   var query = ""
        
      
        if openDatabase() {
            do{
                    
                if !database.executeUpdate("INSERT INTO Registration (firstName, lastName, emailid, employeeCode, password , securityQuestion, securityAnswer) VALUES (?,?,?,?,?,?,?)" , withArgumentsIn: [modelInfo.firstName,modelInfo.lastName,modelInfo.emailid,modelInfo.employeeCode, modelInfo.password , modelInfo.securityQuestion , modelInfo.answer])
                    {
                        print("Failed to insert initial data into the database.")
                        print(database.lastError(), database.lastErrorMessage())
                       return false
                    }
                }
                
         
        }
            
            database.close()

        return true
        }
    // search details of patient by date
    func loadRegistrationData() -> [RegistrationModel]! {
        
               var registrationModelList: [RegistrationModel]!
               var fetchStatus: Bool = false
            
               if openDatabase() {
                   
                 //  print(date)
                   let query = "select firstName, lastName, emailId, employeeCode, password, securityQuestion, securityAnswer from Registration"
                   let firstNameColumn = "firstName"
                   let lastNameColumn = "lastName"
                   let emailIdColumn = "emailId"
                   let employeeCodeColumn = "employeeCode"
                   let passwordCloumn = "password"
                   let securityQuestionColumn = "securityQuestion"
                   let answerColumn = "securityAnswer"
                  
                
                   do {
                       
                       print(database)
                       
                       let results = try! database.executeQuery(query, values : nil )
                       fetchStatus = true
                       print("patient details fetched during search" ,fetchStatus)

            
                       while (results.next()) {
                           print("while loop entered in search patient by date")
                        let registrationModel = RegistrationModel(firstName: results.string(forColumn: firstNameColumn), lastName: results.string(forColumn: lastNameColumn), emailid: results.string(forColumn: emailIdColumn), employeeCode: results.string(forColumn: employeeCodeColumn), password: results.string(forColumn: passwordCloumn),securityQuestion: results.string(forColumn: securityQuestionColumn) ,answer: results.string(forColumn: answerColumn))
                                                                  
                        
                        
                                         if registrationModelList == nil {
                                                            registrationModelList = [RegistrationModel]()
                                                        }
                      
                                     registrationModelList.append(registrationModel)
                           
                           
                                 }
                       
                       print("details of patient list in dbManger while serching by date ", registrationModelList)
                   
                   }
                   
               }
             
            return registrationModelList
           }
    
    
    
    // Update Registration password on the basis of old password and enamil
    func updatePassword(emailId : String , Oldassword : String ,newPassword : String ) -> Bool {
        var created = false
                   if openDatabase() {
                      
          
                       let query2 = "update Registration set password = '\(newPassword)' where emailId = '\(emailId)' and password = '\(Oldassword)' "
            
                       do {
                           try database.executeUpdate(query2, values: nil )
                           created = true
                       }
                       catch {
                           print(error.localizedDescription)
                       }
                
                       database.close()
                   }
                   return created
        
    }
    
    // Update Registration HospitalName or Asc Name -- the EmpCode is Alias Name for hospital Name or ASc Name
    func updateHospital(emailId : String , hospitalName : String  ) -> Bool {
        var created = false
                   if openDatabase() {
                      
          
                       let query2 = "update Registration set employeeCode = '\(hospitalName)' where emailId = '\(emailId)' "
            
                       do {
                           try database.executeUpdate(query2, values: nil )
                           created = true
                       }
                       catch {
                           print(error.localizedDescription)
                       }
                
                       database.close()
                   }
                   return created
        
    }
    
    
    
   
    
    // creating table for Demographics1 Table
    // variable includes lastName, firstName ,.....
    func createDemographics1Table() -> Bool {
        var created = false
        
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
       
            
            if database != nil {
                // Open the database.
                
                if database.open() {
                    let createDemographics1TableQuery = "CREATE TABLE IF NOT EXISTS Demographics1 ( personIdDemo1 integer primary key autoincrement not null, lastName text, firstName text, dob text, mrn integer default 0 , eye text, fellowInvolvement text, level text, fellowInvolvementPercentage text, surgerySetting text, hospitalName text, date text , status integer)"
                    
                    do {
                        try database.executeUpdate(createDemographics1TableQuery, values: nil)
                        created = true
                    }
                    catch {
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }
                    
                    // At the end close the database.
                    database.close()
                }
                else {
                    print("Could not open the database.")
        
                }
        }
               
      
        return created
    }
    
    // func for inserting Dhemographics1 Data
    // values include like lastNaME, FIRSTNAME, DOB ETC
    func insertDemographics1Data(_ modelInfo: Demographics1Model) -> Bool {
        //   var query = ""
        
        if openDatabase() {
            do{
                
                if !database.executeUpdate("INSERT INTO Demographics1 (lastName, firstname, dob, mrn, eye, fellowInvolvement, level, fellowInvolvementPercentage, surgerySetting, hospitalName,date,status) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)" , withArgumentsIn: [modelInfo.lastName,modelInfo.firstName,modelInfo.dob,modelInfo.mrn, modelInfo.eye, modelInfo.fellowInvolvement,modelInfo.levelSelect, modelInfo.fellowInvolvementPercentage,modelInfo.surjurySetting,modelInfo.hospitalName,modelInfo.date,modelInfo.status])
                {
                    print("Failed to insert initial data into the database.")
                    print(database.lastError(), database.lastErrorMessage())
                    return false
                }
            }
        }
        database.close()
        return true
        }
    // for creation Demographics2 table
    func createDemographics2Table() -> Bool {
        var created = false
        
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        
        
        if database != nil {
            // Open the database.
            if database.open() {
                let createDemographics2TableQuery = "CREATE TABLE IF NOT EXISTS Demographics2 ( personIdDemo2 integer primary key autoincrement not null, personIdFromDemo1 integer, aphakia text, cataract text, choroidalEffusion text, choroidalHemorrhage text, diabeticTrd text, dislocatedIntraocularLens text, endophthalmitis text, epiretinalMembrane text, fevr text, floaters text, fullThicknessMacularHole text, intraocularForeignBody text, lamellarMacularHole text, latticeDegeneration text, pdr text, primaryRdWithPvr text, recurrentRdWithPvr text, recurrentRdWithOutPvr text, retainedLensFragments text, retinalTear text, retinalVeinOcclusion text, rhegmatogenousRdMaculaOff text, rhegmatogenousRdMaculaOn text, rop text, sickleCell text, spRdRepairWithSiliconeOil text, subluxedCrystallineLens text, vitreousHemorrhage text , retinalDefect text , otherField text , otherField2 text, otherField3 text, otherField4 text,status integer)"
                do {
                    try database.executeUpdate(createDemographics2TableQuery, values: nil)
                    created = true
                }
                catch {
                    print("Could not create table.")
                    print(error.localizedDescription)
                }
                
                // At the end close the database.
                database.close()
            }
            else {
                print("Could not open the database.")
                
            }
        }
        
        return created
    }
    
    // For inserting data into Demographics 2 table
    func insertDemographics2Data(_ modelInfo: Demographics2Model) -> Bool {
        //   var query = ""
        
        if openDatabase() {
            do{
                
                
                if !database.executeUpdate("INSERT INTO Demographics2 ( personIdFromDemo1 , aphakia , cataract , choroidalEffusion , choroidalHemorrhage , diabeticTrd , dislocatedIntraocularLens , endophthalmitis , epiretinalMembrane , fevr , floaters , fullThicknessMacularHole , intraocularForeignBody , lamellarMacularHole, latticeDegeneration , pdr , primaryRdWithPvr , recurrentRdWithPvr , recurrentRdWithOutPvr, retainedLensFragments, retinalTear , retinalVeinOcclusion , rhegmatogenousRdMaculaOff, rhegmatogenousRdMaculaOn , rop , sickleCell , spRdRepairWithSiliconeOil , subluxedCrystallineLens , vitreousHemorrhage , retinalDefect , otherField , otherField2 , otherField3 , otherField4 , status ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)" , withArgumentsIn: [modelInfo.personIdFromDemo1,modelInfo.aphakia, modelInfo.cataract, modelInfo.choroidalEffusion, modelInfo.choroidalHemorrhage, modelInfo.diabeticTrd, modelInfo.dislocatedIntraocularLens, modelInfo.endophthalmitis, modelInfo.epiretinalMembrane, modelInfo.fevr , modelInfo.floaters, modelInfo.fullThicknessMacularHole,modelInfo.intraocularForeignBody, modelInfo.lamellarMacularHole, modelInfo.latticeDegeneration,modelInfo.pdr, modelInfo.primaryRdWithPvr, modelInfo.recurrentRdWithPvr, modelInfo.recurrentRdWithOutPvr, modelInfo.retainedLensFragments, modelInfo.retinalTear, modelInfo.retinalVeinOcclusion, modelInfo.rhegmatogenousRdMaculaOff, modelInfo.rhegmatogenousRdMaculaOn, modelInfo.rop, modelInfo.sickleCell, modelInfo.spRdRepairWithSiliconeOil, modelInfo.subluxedCrystallineLens, modelInfo.vitreousHemorrhage, modelInfo.retinalDefect,modelInfo.otherField,modelInfo.otherField2 ,modelInfo.otherField3,modelInfo.otherField4 ,modelInfo.status])
                {
                    print("Failed to insert initial data into the database.")
                    print(database.lastError(), database.lastErrorMessage())
                    return false
                }
            }
        }
        database.close()
        return true
    }
    
    // creation of surgery table
    func createSurguryTable() -> Bool {
        
        
        var created = false
        
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        
        
        if database != nil {
            // Open the database.
            
            if database.open() {
                let createSurgeryTableQuery = "CREATE TABLE IF NOT EXISTS Surgery ( personIdDemo1 integer primary key autoincrement not null, personIdfromDemo1 integer, gauge text, band text, sleeve text, tamponad1 text, srfDrain text, acTap text, radialElement text, membranePeel text, ilmPeel text, retinectomy text, fluidAirExchange text, pfo text, focalEndolaser text, prpLaser text, indirectLaserTear text, iolExchange text, aciol text, sulcusIol text, sutured text, sutureless text,  pplWithFrag text, pplWithoutFrag text, tamponade2 text,percentageTamponade text default '', otherFieldTamponade text default '' , comments text, retinalDetachment text default 'NA',macularHoleClosed text default 'NA', pomVisualAcuity text default 'NA', pom3VisualAcuity text default 'NA', otherOutcomeData text default 'NA', otherField2Surgery text default '', virectomy text , scleralBuckle text , iolInsertion text ,  iolName text , iolPower text ,positioning text , siliconeOilRemoval text , siliconeOilExchange text , corodialDrainage text, iolReposition text , cptCodeDropdown text , cptFreeTextBox text , cryotherapy text , ilmDropDown text , status integer)"
                
                
                do {
                    try database.executeUpdate(createSurgeryTableQuery, values: nil)
                    created = true
                }
                catch {
                    print("Could not create table.")
                    print(error.localizedDescription)
                }
                
                // At the end close the database.
                database.close()
            }
            else {
                print("Could not open the database.")
                
            }
        }
        
        return created
    }
    
    // inserting into surgery table 
    func insertSurgeryData(_ modelInfo: SurgeryModel) -> Bool {
        //   var query = ""
        
        if openDatabase() {
            do{
                
                if !database.executeUpdate( "INSERT INTO Surgery(personIdfromDemo1, gauge, band, sleeve, tamponad1, srfDrain, acTap,radialElement, membranePeel, ilmPeel, retinectomy, fluidAirExchange, pfo, focalEndolaser, prpLaser, indirectLaserTear, iolExchange, aciol, sulcusIol, sutured, sutureless, pplWithFrag, pplWithoutFrag, tamponade2, percentageTamponade , otherFieldTamponade, comments , otherField2Surgery, virectomy, scleralBuckle , iolInsertion , iolName , iolPower , positioning ,siliconeOilRemoval , siliconeOilExchange , corodialDrainage, iolReposition, cptCodeDropdown, cptFreeTextBox , cryotherapy, ilmDropDown ,status) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)" , withArgumentsIn: [modelInfo.personIdfromDemo1, modelInfo.gauge, modelInfo.band, modelInfo.sleeve, modelInfo.tamponad1, modelInfo.srfDrain, modelInfo.acTap,modelInfo.radialElement, modelInfo.membranePeel, modelInfo.ilmPeel , modelInfo.retinectomy, modelInfo.fluidAirExchange,modelInfo.pfo, modelInfo.focalEndolaser, modelInfo.prpLaser,modelInfo.indirectLaserTear, modelInfo.iolExchange, modelInfo.aciol, modelInfo.sulcusIol, modelInfo.sutured, modelInfo.sutureless, modelInfo.pplWithFrag, modelInfo.pplWithoutFrag,modelInfo.tamponade1,modelInfo.percentageTamponade, modelInfo.otherFieldTamponade, modelInfo.comments,modelInfo.otherField2,modelInfo.virectomy,modelInfo.scleralBuckle,modelInfo.iolInsertion , modelInfo.iolName, modelInfo.iolPower, modelInfo.positioning
                    ,modelInfo.siliconeOilRemoval,
                     modelInfo.siliconeOilExchange, modelInfo.corodialDrainage, modelInfo.iolReposition , modelInfo.cptCodeDropdown ,modelInfo.cptFreeTextBox ,modelInfo.cryotherapy, modelInfo.ilmDropDown,modelInfo.status])
                {
                    print("Failed to insert initial data into the database.")
                    print(database.lastError(), database.lastErrorMessage())
                    return false
                }
            }
        }
        database.close()
        return true
    }
    //CameraViewController Table
    // Creating CameraImageQuery -- table the for storing images taken from camera or gallery
    func createCameraImageTable() -> Bool {
        var created = false
        
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
       
            
            if database != nil {
                // Open the database.
                
                if database.open() {
                    let createCameraImageTableQuery = "CREATE TABLE IF NOT EXISTS CameraImage ( imageId integer primary key autoincrement not null, imageUniqueId integer, image text, mrn text , comment text ,  status integer)"
                    
                    do {
                        try database.executeUpdate(createCameraImageTableQuery, values: nil)
                        created = true
                    }
                    catch {
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }
                    
                    // At the end close the database.
                    database.close()
                }
                else {
                    print("Could not open the database.")
        
                }
        }
               
        return created
    }
    
    // function to insert images in CameraImage Table 
    func insertCameraImageData(_ modelInfo: ImageModel) -> Bool {
           //   var query = ""
           
           if openDatabase() {
               do{
                   
                if !database.executeUpdate("INSERT INTO CameraImage(imageUniqueId,image,mrn,comment, status) VALUES (?,?,?,?,?)" , withArgumentsIn: [modelInfo.imageUniqueId,modelInfo.image, modelInfo.mrn, modelInfo.comment,modelInfo.status ])
                   {
                       print("Failed to insert initial data into the database.")
                       print(database.lastError(), database.lastErrorMessage())
                       return false
                   }
               }
           }
           database.close()
           return true
       }
        



    // fuction to get the unique id of column from Demographic model
func loadData() -> Int {
      //  var movie: [Demographics1Model]!
       var idvalue: Int = 0
        if openDatabase() {
         
         
         
            // let query = "SELECT personIdDemo1 FROM Demographics1"
//            let query = "SELECT *
//            FROM    TABLE
//            WHERE   ID = (SELECT MAX(ID)  FROM TABLE)"
            let query = "select personIdDemo1 from Demographics1 WHERE personIdDemo1 = (SELECT MAX(personIdDemo1) from Demographics1)"
           
        let personid: String = "personIdDemo1"
          
            do {
                print(database)
               let results = try database.executeQuery(query, values: nil)
                
               if results.next() {
                
       var id: Int   =   Int(results.int(forColumn: personid))
                 print("value of person id ", id)
                idvalue = id
               
                }
                         
                   
                }
         
            catch {
                print(error.localizedDescription)
            }
     
            database.close()
        }
     
        return idvalue
}
    
    // upadation of demographics1 status column on EyeProcedureViewController No button
    func UpdateDemographics1StatusColumn(_ ID: Int) -> Bool {
        
         var created = false
        if openDatabase() {
            let query1 = "update Demographics1 set status = 1 where personIdDemo1 =?"
            do {
                try database.executeUpdate(query1, values: [ID])
                created = true
            }
            catch {
                print(error.localizedDescription)
            }
     
            database.close()
        }
        return created
    }
    
     // upadation of demographics2 status column on EyeProcedureViewController No button
        func UpdateDemographics2StatusColumn(_ ID: Int) -> Bool {
          
             var created = false
            if openDatabase() {
               
   
                let query2 = "update Demographics2 set status = 1 where personIdFromDemo1 =?"
     
                do {
                    try database.executeUpdate(query2, values: [ID])
                    created = true
                }
                catch {
                    print(error.localizedDescription)
                }
         
                database.close()
            }
            return created
        }
    
    // upadation of Surgery status column on EyeProcedureViewController No button
         func UpdateSurgeryStatusColumn(_ ID: Int) -> Bool {
            
              var created = false
             if openDatabase() {
            
                 let query3 = "update Surgery set status = 1 where personIdFromDemo1 =?"
   
    
    
                 
          
                 do {
                     try database.executeUpdate(query3, values: [ID])
                     created = true
                 }
                 catch {
                     print(error.localizedDescription)
                 }
          
                 database.close()
             }
             return created
         }
    
    // upadation of CameraImage status column on EyeProcedureViewController No button
            func UpdateCameraImageStatusColumn(_ ID: Int) -> Bool {
               
                 var created = false
                if openDatabase() {
      
                    let query4 = "update CameraImage set status = 1 where imageUniqueId =?"
       
                    
             
                    do {
                        try database.executeUpdate(query4, values: [ID])
                        created = true
                    }
                    catch {
                        print(error.localizedDescription)
                    }
             
                    database.close()
                }
                return created
            }
    
    
    // Update image Path after editing in camera module 
    func UpdateCameraImagePathAfterEding(_ ID: Int ,_ imagePath : String , comment : String) -> Bool {
             
               var created = false
              if openDatabase() {
    
                  let query4 = "update CameraImage set image = '\(imagePath)' , comment = '\(comment)'  where imageUniqueId =?"
     
                  
           
                  do {
                      try database.executeUpdate(query4, values: [ID])
                      created = true
                  }
                  catch {
                      print(error.localizedDescription)
                  }
           
                  database.close()
              }
              return created
          }
    
    
    
    
     
    //searching a patient with help of  mrn
    // details required - personIdDemo1, firstName, lastName, mrn, date
    func loadPatientSearchDetailsByMrn(withID mrn: Int) -> [PatientSearchModel]! {
        var patientSearchModelList: [PatientSearchModel]!
        var fetchStatus: Bool = false
     
        if openDatabase() {
            
            print(mrn)
            let query = "select personIdDemo1, firstName, lastName, mrn, date, eye, status from Demographics1 where mrn =? and status = 1"
     
            let personidColumn : String = "personIdDemo1"
            let firstNameColumn : String = "firstName"
            let lastNameColumn : String = "lastName"
            let patientMrnColumn : String = "mrn"
            let surgeryDate1Column : String = "date"
            let eyeColumn : String = "eye"
            let statusColumn = "status"
            do {
                
                print(database)
                
                let results = try! database.executeQuery(query, values :[mrn] )
                fetchStatus = true
                print("patient details fetched during search" ,fetchStatus)

     
                while (results.next()) {
                    print("while loop entered")
                    let patientSearchModel = PatientSearchModel(personId: Int(results.int(forColumn: personidColumn)),
                                                                firstName:  results.string(forColumn: firstNameColumn),
                                                                lastName:  results.string(forColumn: lastNameColumn),
                                                                patientMrn:  results.string(forColumn:patientMrnColumn ),
                                                                surgeryDate: results.string(forColumn: surgeryDate1Column),
                                                                eye: results.string(forColumn: eyeColumn),
                                                                status:Int(results.int(forColumn: statusColumn))
                                                    
                              )
               
                                  if patientSearchModelList == nil {
                                                     patientSearchModelList = [PatientSearchModel]()
                                                 }
               
                              patientSearchModelList.append(patientSearchModel)
                    
                    
                          }
                
//                print("details of patient list in dbManger", patientSearchModelList)
            
            }
            catch {
                print(error.localizedDescription)
            }
            
        }
       return patientSearchModelList
    }
    
    // search details of patient by date
    func loadPatientSearchDetailsByDate(withID startDate: String , endDate: String ) -> [PatientSearchModel]! {
            var patientSearchModelList: [PatientSearchModel]!
            var fetchStatus: Bool = false
         
            if openDatabase() {
                
                print(startDate, endDate)
                let query = "select personIdDemo1, firstName, lastName, mrn, date, eye, status from Demographics1 where (date between '\(startDate)' and '\(endDate)') and status = 1"
         
                  let personidColumn : String = "personIdDemo1"
                  let firstNameColumn : String = "firstName"
                  let lastNameColumn : String = "lastName"
                  let patientMrnColumn : String = "mrn"
                  let surgeryDate1Column : String = "date"
                  let eyeColumn : String = "eye"
                  let statusColumn = "status"
                do {
                    
                    print(database)
                    
                    let results = try! database.executeQuery(query, values : nil )
                    fetchStatus = true
                    print("patient details fetched during search" ,fetchStatus)

         
                    while (results.next()) {
                       
                        let patientSearchModel = PatientSearchModel(personId: Int(results.int(forColumn: personidColumn)),
                                                                    firstName:  results.string(forColumn: firstNameColumn),
                                                                    lastName:  results.string(forColumn: lastNameColumn),
                                                                    patientMrn:  results.string(forColumn:patientMrnColumn ),
                                                                    surgeryDate: results.string(forColumn: surgeryDate1Column),
                                                                    eye: results.string(forColumn: eyeColumn) ,
                                                                    status:Int(results.int(forColumn: statusColumn))
                                                        
                                  )
                   
                                      if patientSearchModelList == nil {
                                                         patientSearchModelList = [PatientSearchModel]()
                                                     }
                   
                                  patientSearchModelList.append(patientSearchModel)
                        
                        
                              }
                    
                    print("details of patient list in dbManger while serching by date ", patientSearchModelList)
                
                }
                catch {
                    print(error.localizedDescription)
                }
                
            }
           return patientSearchModelList
        }
    
    // search details of patient by SurgeryType
       func loadPatientSearchDetailsByType(withID surgeryType: String , surgeryStatus: String ) -> [PatientSearchModel]! {
               var patientSearchModelList: [PatientSearchModel]!
               var fetchStatus: Bool = false

               if openDatabase() {

                   print(surgeryType, surgeryStatus)
               
                let query = "select D.personIdDemo1, D.firstName, D.lastName, D.mrn, D.date, D.eye ,  D.status from Demographics1 D INNER JOIN Surgery S Where D.personIdDemo1 = S.personIdDemo1 and D.status = 1 and S.\(surgeryType) = '\(surgeryStatus)' "

                   let personidColumn : String = "personIdDemo1"
                   let firstNameColumn : String = "firstName"
                   let lastNameColumn : String = "lastName"
                   let patientMrnColumn : String = "mrn"
                   let surgeryDate1Column : String = "date"
                   let eyeColumn : String = "eye"
                   let statusColumn = "status"
                   do {

                       print(database)

                       let results = try! database.executeQuery(query, values : nil )
                       fetchStatus = true
                       print("patient details fetched during search" ,fetchStatus)


                       while (results.next()) {
                           print("while loop entered in search patient by Surgery")
                           let patientSearchModel = PatientSearchModel(personId: Int(results.int(forColumn: personidColumn)),
                                                                       firstName:  results.string(forColumn: firstNameColumn),
                                                                       lastName:  results.string(forColumn: lastNameColumn),
                                                                       patientMrn:  results.string(forColumn:patientMrnColumn ),
                                                                       surgeryDate: results.string(forColumn: surgeryDate1Column),
                                                                       eye: results.string(forColumn: eyeColumn),
                                                                       status:Int(results.int(forColumn: statusColumn))

                                     )

                                         if patientSearchModelList == nil {
                                                            patientSearchModelList = [PatientSearchModel]()
                                                        }

                                     patientSearchModelList.append(patientSearchModel)


                                 }

                       print("details of patient list in dbManger while serching by Surgery type ", patientSearchModelList)

                   }
                catch {
                    print(error.localizedDescription)
                }

               }
              return patientSearchModelList
           }

       // search details of patient by Diagnosis Type
             func loadPatientSearchDetailsByDiagnosisType(withID diagnosisType: String , diagnosisStatus: String ) -> [PatientSearchModel]! {
                     var patientSearchModelList: [PatientSearchModel]!
                     var fetchStatus: Bool = false

                     if openDatabase() {

                         print(diagnosisType, diagnosisStatus)
                     
                      let query = "select D1.personIdDemo1, D1.firstName, D1.lastName, D1.mrn, D1.date, D1.eye , D1.status from Demographics1 D1 INNER JOIN Demographics2 D2  Where D1.personIdDemo1 = D2.personIdDemo2 and D1.status = 1 and D2.\(diagnosisType) = '\(diagnosisStatus)' "

                         let personidColumn : String = "personIdDemo1"
                         let firstNameColumn : String = "firstName"
                         let lastNameColumn : String = "lastName"
                         let patientMrnColumn : String = "mrn"
                         let surgeryDate1Column : String = "date"
                        let eyeColumn : String = "eye"
                         let statusColumn = "status"
                         do {

                             print(database)

                             let results = try! database.executeQuery(query, values : nil )
                             fetchStatus = true
                             print("patient details fetched during search" ,fetchStatus)


                             while (results.next()) {
                                 print("while loop entered in search patient by Surgery")
                                 let patientSearchModel = PatientSearchModel(personId: Int(results.int(forColumn: personidColumn)),
                                                                             firstName:  results.string(forColumn: firstNameColumn),
                                                                             lastName:  results.string(forColumn: lastNameColumn),
                                                                             patientMrn:  results.string(forColumn:patientMrnColumn ),
                                                                             surgeryDate: results.string(forColumn: surgeryDate1Column),
                                                                             eye: results.string(forColumn: eyeColumn),
                                                                             status:Int(results.int(forColumn: statusColumn))

                                           )

                                               if patientSearchModelList == nil {
                                                                  patientSearchModelList = [PatientSearchModel]()
                                                              }

                                           patientSearchModelList.append(patientSearchModel)


                                       }

                             print("details of patient list in dbManger while serching by Surgery type ", patientSearchModelList)

                         }
                      catch {
                          print(error.localizedDescription)
                      }

                     }
                    return patientSearchModelList
                 }

             
    
    
    
    
    // load all patient details whose case is uncomplete.
                  // searching on the basis of status ,
                  // If the case is uncomplete the status is zero (0)
                  // If the case is uncomplete the status is zero
              func  PatientUnLoggedCasesListForEditing() -> [PatientSearchModelUnlogged]! {
                          var patientSearchModelUnLoggedList: [PatientSearchModelUnlogged]!
                          var fetchStatus: Bool = false
                       
                          if openDatabase() {
                              
                             
                              let query = "select personIdDemo1, firstName, lastName, mrn, dob, date , status from Demographics1 where status = 0"
                       
                              let personidColumn : String = "personIdDemo1"
                              let firstNameColumn : String = "firstName"
                              let lastNameColumn : String = "lastName"
                              let patientMrnColumn : String = "mrn"
                              let dateOfBirthColumn : String = "dob"
                              let surgeryDate1Column : String = "date"
                            
                            let statusColumn = "status"
                              do {
                                  
                                  print(database)
                                  
                                let results = try! database.executeQuery(query, values : nil )
                                  fetchStatus = true
                                  print("patient details fetched during search" ,fetchStatus)

                       
                                  while (results.next()) {
                                      print("while loop entered")
                                      let patientSearchModelUnlogged = PatientSearchModelUnlogged(personId: Int(results.int(forColumn: personidColumn)),
                                                                                  firstName:  results.string(forColumn: firstNameColumn),
                                                                                  lastName:  results.string(forColumn: lastNameColumn), dob: results.string(forColumn: dateOfBirthColumn),
                                                                                  patientMrn:  results.string(forColumn:patientMrnColumn ),
                                                                                  
                                                                                  surgeryDate: results.string(forColumn: surgeryDate1Column),
                                
                                                                                  status:Int(results.int(forColumn: statusColumn))
                                                                      
                                                )
                                 
                                                    if patientSearchModelUnLoggedList == nil {
                                                                       patientSearchModelUnLoggedList = [PatientSearchModelUnlogged]()
                                                                   }
                                 
                                                patientSearchModelUnLoggedList.append(patientSearchModelUnlogged)
                                      
                                      
                                            }
                                  
                                print("details of patient list in dbManger", patientSearchModelUnLoggedList)
                              
                              }
                  
              catch {
                  print(error.localizedDescription)
              }
       
              database.close()
          }
       
          return patientSearchModelUnLoggedList
      }
                
              
    
     //searching Demographics Details with help of date and mrn
    func loadPatientDemographicsDetails(withID Id: Int) -> [Any]  {
            var demographicsDetailsList : [Any] = []
            var fetchStatus: Bool = false
         
            if openDatabase() {
                
                print(Id)
                let query = "Select personIdDemo1, lastName, firstname, dob, mrn, eye, fellowInvolvement, level, surgerySetting, hospitalName,fellowInvolvementPercentage , date from Demographics1 where personIdDemo1 =? and status = 1"
         
                let personidColumn : String = "personIdDemo1"
                let firstNameColumn : String = "firstName"
                let lastNameColumn : String = "lastName"
                let patientMrnColumn : String = "mrn"
                let surgeryDateColumn : String = "date"
                let dobColumn : String = "dob"
                let eyeTypeColumn : String = "eye"
                let fellowInvolvementColumn : String = "fellowInvolvement"
                let fellowLevelColumn : String = "level"
                let surgerySettingColumn : String = "surgerySetting"
                let hospitalAscNameCoumn : String = "hospitalName"
                let fellowInvolvementPercentageColumn : String = "fellowInvolvementPercentage"
               
                do {
                    
                    print(database)
                    
                    let results = try! database.executeQuery(query, values :[Id] )
                    fetchStatus = true
                    print("patient details fetched during search" ,fetchStatus)

         
                    while (results.next()) {
                        print("entered while loop")
                        let personid = results.int(forColumn: personidColumn)
                    demographicsDetailsList.append(personid)
                        let fName = results.string(forColumn: firstNameColumn)
                        print("fname" , fName)
                        demographicsDetailsList.append(fName)
                        let lname = results.string( forColumn:lastNameColumn)
                        demographicsDetailsList.append(lname)
                        let dateOfBirth = results.string(forColumn: dobColumn)
                        demographicsDetailsList.append(dateOfBirth)
                        let mrn = results.string(forColumn:patientMrnColumn)
                        demographicsDetailsList.append(mrn)
                        let eyeType = results.string(forColumn: eyeTypeColumn)
                        demographicsDetailsList.append(eyeType!)
                        let fellowInvovement = results.string(forColumn: fellowInvolvementColumn)
                        demographicsDetailsList.append(fellowInvovement!)
                        let fellowPercentage = results.string(forColumn: fellowInvolvementPercentageColumn  )
                        demographicsDetailsList.append(fellowPercentage!)
                        let fellowLevel = results.string(forColumn: fellowLevelColumn)
                        demographicsDetailsList.append(fellowLevel!)
                        let surgurySetting = results.string(forColumn: surgerySettingColumn)
                        demographicsDetailsList.append(surgurySetting!)
                        let hospitalName = results.string(forColumn: hospitalAscNameCoumn)
                        demographicsDetailsList.append(hospitalName!)
                        let surgeryDate = results.string(forColumn: surgeryDateColumn)
                        demographicsDetailsList.append(surgeryDate!)
                        
                        
                        
                        
                       // let dateOfBirth =
                        
                        
                              }
                    
                    print("details of patient list in dbManger", demographicsDetailsList)
                }
                catch {
                    print(error.localizedDescription)
                }
         
                database.close()
            }
         
          return demographicsDetailsList
        }
    
    
    
    //searching Demographics Details with help of mrn and status = 0 for editing puposes
      func  loadPatientDemographicsDetailsDuringEditing(withID Id: Int) -> [Any]  {
              var demographicsDetailsList : [Any] = []
              var fetchStatus: Bool = false
           
              if openDatabase() {
                  
                  print(Id)
                  let query = "Select personIdDemo1, lastName, firstname, dob, mrn, eye, fellowInvolvement, level, surgerySetting, hospitalName, date from Demographics1 where personIdDemo1 =? and status = 0"
           
                  let personidColumn : String = "personIdDemo1"
                  let firstNameColumn : String = "firstName"
                  let lastNameColumn : String = "lastName"
                  let patientMrnColumn : String = "mrn"
                  let surgeryDateColumn : String = "date"
                  let dobColumn : String = "dob"
                  let eyeTypeColumn : String = "eye"
                  let fellowInvolvementColumn : String = "fellowInvolvement"
                  let fellowLevelColumn : String = "level"
                  let surgerySettingColumn : String = "surgerySetting"
                  let hospitalAscNameCoumn : String = "hospitalName"
                 
                  do {
                      
                      print(database)
                      
                      let results = try! database.executeQuery(query, values :[Id] )
                      fetchStatus = true
                      print("patient details fetched during search" ,fetchStatus)

           
                      while (results.next()) {
                          print("entered while loop")
                          let personid = results.int(forColumn: personidColumn)
                      demographicsDetailsList.append(personid)
                          let fName = results.string(forColumn: firstNameColumn)
                          print("fname" , fName)
                          demographicsDetailsList.append(fName)
                          let lname = results.string( forColumn:lastNameColumn)
                          demographicsDetailsList.append(lname)
                          let dateOfBirth = results.string(forColumn: dobColumn)
                          demographicsDetailsList.append(dateOfBirth)
                          let mrn = results.string(forColumn:patientMrnColumn)
                          demographicsDetailsList.append(mrn)
                          let eyeType = results.string(forColumn: eyeTypeColumn)
                          demographicsDetailsList.append(eyeType)
                          let fellowInvovement = results.string(forColumn: fellowInvolvementColumn)
                          demographicsDetailsList.append(fellowInvovement)
                          let fellowLevel = results.string(forColumn: fellowLevelColumn)
                          demographicsDetailsList.append(fellowLevel)
                          let surgurySetting = results.string(forColumn: surgerySettingColumn)
                          demographicsDetailsList.append(surgurySetting)
                          let hospitalName = results.string(forColumn: hospitalAscNameCoumn)
                          demographicsDetailsList.append(hospitalName)
                          let surgeryDate = results.string(forColumn: surgeryDateColumn)
                          demographicsDetailsList.append(surgeryDate)
                          
                          
                          
                          
                         // let dateOfBirth =
                          
                          
                                }
                      
                      print("details of patient list in dbManger", demographicsDetailsList)
                  }
                  catch {
                      print(error.localizedDescription)
                  }
           
                  database.close()
              }
           
            return demographicsDetailsList
          }
     
    
    //searching Diagnosis Details with help of id (personIdFromDemo1)
       func loadPatientDiagnosisDetails(withID Id: Int) -> [Any]  {
               var diagnosisDetailsList : [Any] = []
               var fetchStatus: Bool = false
            
               if openDatabase() {
                   
                   print(Id)
                   let query = "Select personIdFromDemo1, aphakia, cataract, choroidalEffusion, choroidalHemorrhage, diabeticTrd, dislocatedIntraocularLens, endophthalmitis, epiretinalMembrane, fevr, floaters, fullThicknessMacularHole, intraocularForeignBody, lamellarMacularHole, latticeDegeneration, pdr, primaryRdWithPvr, recurrentRdWithPvr, recurrentRdWithOutPvr, retainedLensFragments, retinalTear, retinalVeinOcclusion, rhegmatogenousRdMaculaOff, rhegmatogenousRdMaculaOn, rop, sickleCell, spRdRepairWithSiliconeOil, subluxedCrystallineLens, vitreousHemorrhage, retinalDefect , otherField ,otherField2,otherField3,otherField4  from Demographics2 where personIdFromDemo1 =? and status = 1"
            
                  
                  
                   do {
                       
                       print(database)
                       
                    let results = try! database.executeQuery(query, values :[Id] )
                       fetchStatus = true
                       print("patient details fetched during search" ,fetchStatus)
                    let  personIdFromDemo1Column : String = "personIdFromDemo1" // 1
                    let aphakiaColumn : String = "aphakia"   // 2
                    let cataractColumn : String = "cataract" // 3
                    let choroidalEffusionColumn : String = "choroidalEffusion" // 4
                    let choroidalHemorrhageColumn : String = "choroidalHemorrhage" //5
                    let diabeticTrdColumn : String = "diabeticTrd" //6
                    let dislocatedIntraocularLensColumn : String = "dislocatedIntraocularLens" // 7
                    let endophthalmitisColumn : String = "endophthalmitis" // 8
                    let epiretinalMembraneColumn : String = "epiretinalMembrane" //9
                    let fevrColumn : String = "fevr" //10
                    let floatersColumn : String = "floaters" //11
                    let fullThicknessMacularHoleColumn : String = "fullThicknessMacularHole" //12
                    let intraocularForeignBodyColumn : String = "intraocularForeignBody" //13
                    let lamellarMacularHoleColumn : String = "lamellarMacularHole" //14
                    let latticeDegenerationColumn : String = "latticeDegeneration" //15
                    let pdrColumn : String = "pdr" //16
                    let primaryRdWithPvrColumn : String = "primaryRdWithPvr" //17
                    let recurrentRdWithPvrColumn : String = "recurrentRdWithPvr" //18
                    let recurrentRdWithOutPvrColumn : String = "recurrentRdWithOutPvr" // 19
                    let retainedLensFragmentsColumn : String = "retainedLensFragments" //20
                    let retinalTearColumn : String = "retinalTear" // 21
                    let retinalVeinOcclusionColumn : String = "retinalVeinOcclusion" // 22
                    let rhegmatogenousRdMaculaOffColumn : String = "rhegmatogenousRdMaculaOff" //23
                    let rhegmatogenousRdMaculaOnColumn : String = "rhegmatogenousRdMaculaOn" // 24
                    let ropColumn : String = "rop" // 25
                    let sickleCelColumn : String = "sickleCell" //26
                    let spRdRepairWithSiliconeOilColumn : String =  "spRdRepairWithSiliconeOil" // 27
                    let subluxedCrystallineLensColumn : String =
                    "subluxedCrystallineLens" // 28
                    let vitreousHemorrhageColumn : String =
                    "vitreousHemorrhage" // 29
                    let retinalDefectColumn : String = "retinalDefect"
                    let otherField1Column : String = "otherField"
                    let otherField2Column : String = "otherField2"
                    let otherField3Column : String = "otherField3"
                    let otherField4Column : String = "otherField4"
                   
                    
                       while (results.next()) {
                           print("entered while loop")
                        
                        let personIdFromDemo1 = results.int(forColumn: personIdFromDemo1Column) // 1
                        diagnosisDetailsList.append(personIdFromDemo1Column)
                        
                        let aphakia = results.string(forColumn: aphakiaColumn) //2
                        diagnosisDetailsList.append(aphakia)
                        
                        let cataract = results.string(forColumn: cataractColumn) //3
                        diagnosisDetailsList.append(cataract)
                        
                        let choroidalEffusion = results.string(forColumn: choroidalEffusionColumn) //4
                        diagnosisDetailsList.append(choroidalEffusion)
                        
                        let choroidalHemorrhage = results.string(forColumn: choroidalHemorrhageColumn) //5
                         diagnosisDetailsList.append(choroidalHemorrhage)
                        
                        let diabeticTrd = results.string(forColumn: diabeticTrdColumn) // 6
                        diagnosisDetailsList.append(diabeticTrd)
                        
                        let dislocatedIntraocularLens = results.string(forColumn: dislocatedIntraocularLensColumn) // 7
                         diagnosisDetailsList.append(dislocatedIntraocularLens)
                        
                        let endophthalmitis = results.string(forColumn: endophthalmitisColumn) // 8
                        diagnosisDetailsList.append(endophthalmitis)
                        
                        let epiretinalMembrane = results.string(forColumn: epiretinalMembraneColumn) // 9
                        diagnosisDetailsList.append(epiretinalMembrane)
                        
                        let fevr = results.string(forColumn: fevrColumn) // 10
                        diagnosisDetailsList.append(fevr)
                        
                        let floaters = results.string(forColumn: floatersColumn) // 11
                           diagnosisDetailsList.append(floaters)
                       
                        let fullThicknessMacularHole = results.string(forColumn: fullThicknessMacularHoleColumn) // 12
                      diagnosisDetailsList.append(fullThicknessMacularHole)
                        
                        let intraocularForeignBody = results.string(forColumn: intraocularForeignBodyColumn) // 13
                       diagnosisDetailsList.append(intraocularForeignBody)
                        
                        let lamellarMacularHole = results.string(forColumn: lamellarMacularHoleColumn) //14
                        diagnosisDetailsList.append(lamellarMacularHole)
                        
                        let latticeDegeneration = results.string(forColumn: latticeDegenerationColumn) // 15
                        diagnosisDetailsList.append(latticeDegeneration)
                        
                        let pdr = results.string(forColumn: pdrColumn) // 16
                        diagnosisDetailsList.append(pdr)
                        
                        let primaryRdWithPvr = results.string(forColumn: primaryRdWithPvrColumn) // 17
                    diagnosisDetailsList.append(primaryRdWithPvr)
                        
                        let recurrentRdWithPvr = results.string(forColumn: recurrentRdWithPvrColumn) // 18
                    diagnosisDetailsList.append(recurrentRdWithPvr)
                        
                        let recurrentRdWithOutPvr = results.string(forColumn: recurrentRdWithOutPvrColumn) // 19
                    diagnosisDetailsList.append(recurrentRdWithOutPvr)
                        
                        let retainedLensFragments = results.string(forColumn: retainedLensFragmentsColumn) // 20
                    diagnosisDetailsList.append(retainedLensFragments)
                        
                        let retinalTear =  results.string(forColumn: retinalTearColumn) // 21
                         diagnosisDetailsList.append(retinalTear)
                        
                        let retinalVeinOcclusion = results.string(forColumn: retinalVeinOcclusionColumn) // 22
                    diagnosisDetailsList.append(retinalVeinOcclusion)
                        
                        let rhegmatogenousRdMaculaOff = results.string(forColumn: rhegmatogenousRdMaculaOffColumn) // 23
                         diagnosisDetailsList.append(rhegmatogenousRdMaculaOff)
                        
                        let rhegmatogenousRdMaculaOn =
                        results.string(forColumn: rhegmatogenousRdMaculaOnColumn) // 24
                        diagnosisDetailsList.append(rhegmatogenousRdMaculaOn)
                        
                        let rop = results.string(forColumn: ropColumn) // 25
                        diagnosisDetailsList.append(rop)
                        
                        let sickleCell = results.string(forColumn: sickleCelColumn) // 26
                        diagnosisDetailsList.append(sickleCell)
                        
                        let spRdRepairWithSiliconeOil = results.string(forColumn: spRdRepairWithSiliconeOilColumn) // 27
                        diagnosisDetailsList.append(spRdRepairWithSiliconeOil)
                        
                        let subluxedCrystallineLens = results.string(forColumn: subluxedCrystallineLensColumn) // 28
                        diagnosisDetailsList.append(subluxedCrystallineLens)
                        
                        let vitreousHemorrhage = results.string(forColumn: vitreousHemorrhageColumn) // 29
                        diagnosisDetailsList.append(vitreousHemorrhage)
                        let retinalDefect = results.string(forColumn: retinalDefectColumn) // 29
                           diagnosisDetailsList.append(retinalDefect)
                        let of1 = results.string(forColumn: otherField1Column) //30
                        diagnosisDetailsList.append(of1)
                        let of2 = results.string(forColumn: otherField2Column) //31
                        diagnosisDetailsList.append(of2)
                        let of3 = results.string(forColumn: otherField3Column) //32
                        diagnosisDetailsList.append(of3)
                        let of4 = results.string(forColumn: otherField4Column) //33
                        diagnosisDetailsList.append(of4)
                       
                        
                        
//
        
                                 }
                       
                       print("details of diagnosis list in dbManger", diagnosisDetailsList)
                   }
                   catch {
                       print(error.localizedDescription)
                   }
            
                   database.close()
               }
            
             return diagnosisDetailsList
           }
    
    //searching Diagnosis Details(Demographics2ViewController) with help of id (personIdFromDemo1) for editing purposes
    
    func loadPatientDiagnosisDetailsWhileEditing( uniqueId: Int) -> [String]  {
        var diagnosisDetailsList : [String] = []
            var fetchStatus: Bool = false
         
            if openDatabase() {
                
                print(uniqueId)
                let query = "Select aphakia, cataract, choroidalEffusion, choroidalHemorrhage, diabeticTrd, dislocatedIntraocularLens, endophthalmitis, epiretinalMembrane, fevr, floaters, fullThicknessMacularHole, intraocularForeignBody, lamellarMacularHole, latticeDegeneration, pdr, primaryRdWithPvr, recurrentRdWithPvr, recurrentRdWithOutPvr, retainedLensFragments, retinalTear, retinalVeinOcclusion, rhegmatogenousRdMaculaOff, rhegmatogenousRdMaculaOn, rop, sickleCell, spRdRepairWithSiliconeOil, subluxedCrystallineLens, vitreousHemorrhage,otherField , otherField2, otherField3 ,otherField4 , retinalDefect  from Demographics2 where personIdFromDemo1 ='\(uniqueId)' and status = 1"
         
               
               
                do {
                    
                    print(database)
                    
                 let results = try! database.executeQuery(query, values :[uniqueId] )
                    fetchStatus = true
                    print("patient details fetched during search" ,fetchStatus)
//                 let  personIdFromDemo1Column : String = "personIdFromDemo1" // 1
                 let aphakiaColumn : String = "aphakia"   // 2
                 let cataractColumn : String = "cataract" // 3
                 let choroidalEffusionColumn : String = "choroidalEffusion" // 4
                 let choroidalHemorrhageColumn : String = "choroidalHemorrhage" //5
                 let diabeticTrdColumn : String = "diabeticTrd" //6
                 let dislocatedIntraocularLensColumn : String = "dislocatedIntraocularLens" // 7
                 let endophthalmitisColumn : String = "endophthalmitis" // 8
                 let epiretinalMembraneColumn : String = "epiretinalMembrane" //9
                 let fevrColumn : String = "fevr" //10
                 let floatersColumn : String = "floaters" //11
                 let fullThicknessMacularHoleColumn : String = "fullThicknessMacularHole" //12
                 let intraocularForeignBodyColumn : String = "intraocularForeignBody" //13
                 let lamellarMacularHoleColumn : String = "lamellarMacularHole" //14
                 let latticeDegenerationColumn : String = "latticeDegeneration" //15
                 let pdrColumn : String = "pdr" //16
                 let primaryRdWithPvrColumn : String = "primaryRdWithPvr" //17
                 let recurrentRdWithPvrColumn : String = "recurrentRdWithPvr" //18
                 let recurrentRdWithOutPvrColumn : String = "recurrentRdWithOutPvr" // 19
                 let retainedLensFragmentsColumn : String = "retainedLensFragments" //20
                 let retinalTearColumn : String = "retinalTear" // 21
                 let retinalVeinOcclusionColumn : String = "retinalVeinOcclusion" // 22
                 let rhegmatogenousRdMaculaOffColumn : String = "rhegmatogenousRdMaculaOff" //23
                 let rhegmatogenousRdMaculaOnColumn : String = "rhegmatogenousRdMaculaOn" // 24
                 let ropColumn : String = "rop" // 25
                 let sickleCelColumn : String = "sickleCell" //26
                 let spRdRepairWithSiliconeOilColumn : String =  "spRdRepairWithSiliconeOil" // 27
                 let subluxedCrystallineLensColumn : String =
                 "subluxedCrystallineLens" // 28
                 let vitreousHemorrhageColumn : String =
                 "vitreousHemorrhage" // 29
                 let retinalDefectColumn : String = "retinalDefect"
                 let otherField1Column : String = "otherField" // 30
                 let otherField2Column : String = "otherField2" // 31
                 let otherField3Column : String = "otherField3" // 32
                 let otherField4Column : String = "otherField4" // 33
         
                    while (results.next()) {
                        print("entered while loop")
                     
//                     let personIdFromDemo1 = results.int(forColumn: personIdFromDemo1Column) // 1
//                     diagnosisDetailsList.append(personIdFromDemo1Column)
                     
                     let aphakia = results.string(forColumn: aphakiaColumn) //2
                     diagnosisDetailsList.append(aphakia!)
                     
                     let cataract = results.string(forColumn: cataractColumn) //3
                     diagnosisDetailsList.append(cataract!)
                     
                     let choroidalEffusion = results.string(forColumn: choroidalEffusionColumn) //4
                     diagnosisDetailsList.append(choroidalEffusion!)
                     
                     let choroidalHemorrhage = results.string(forColumn: choroidalHemorrhageColumn) //5
                      diagnosisDetailsList.append(choroidalHemorrhage!)
                     
                     let diabeticTrd = results.string(forColumn: diabeticTrdColumn) // 6
                     diagnosisDetailsList.append(diabeticTrd!)
                     
                     let dislocatedIntraocularLens = results.string(forColumn: dislocatedIntraocularLensColumn) // 7
                      diagnosisDetailsList.append(dislocatedIntraocularLens!)
                     
                     let endophthalmitis = results.string(forColumn: endophthalmitisColumn) // 8
                     diagnosisDetailsList.append(endophthalmitis!)
                     
                     let epiretinalMembrane = results.string(forColumn: epiretinalMembraneColumn) // 9
                     diagnosisDetailsList.append(epiretinalMembrane!)
                     
                     let fevr = results.string(forColumn: fevrColumn) // 10
                     diagnosisDetailsList.append(fevr!)
                     
                     let floaters = results.string(forColumn: floatersColumn) // 11
                        diagnosisDetailsList.append(floaters!)
                    
                     let fullThicknessMacularHole = results.string(forColumn: fullThicknessMacularHoleColumn) // 12
                   diagnosisDetailsList.append(fullThicknessMacularHole!)
                     
                     let intraocularForeignBody = results.string(forColumn: intraocularForeignBodyColumn) // 13
                    diagnosisDetailsList.append(intraocularForeignBody!)
                     
                     let lamellarMacularHole = results.string(forColumn: lamellarMacularHoleColumn) //14
                     diagnosisDetailsList.append(lamellarMacularHole!)
                     
                     let latticeDegeneration = results.string(forColumn: latticeDegenerationColumn) // 15
                     diagnosisDetailsList.append(latticeDegeneration!)
                     
                     let pdr = results.string(forColumn: pdrColumn) // 16
                     diagnosisDetailsList.append(pdr!)
                     
                     let primaryRdWithPvr = results.string(forColumn: primaryRdWithPvrColumn) // 17
                 diagnosisDetailsList.append(primaryRdWithPvr!)
                     
                     let recurrentRdWithPvr = results.string(forColumn: recurrentRdWithPvrColumn) // 18
                 diagnosisDetailsList.append(recurrentRdWithPvr!)
                     
                     let recurrentRdWithOutPvr = results.string(forColumn: recurrentRdWithOutPvrColumn) // 19
                 diagnosisDetailsList.append(recurrentRdWithOutPvr!)
                     
                     let retainedLensFragments = results.string(forColumn: retainedLensFragmentsColumn) // 20
                 diagnosisDetailsList.append(retainedLensFragments!)
                     
                     let retinalTear =  results.string(forColumn: retinalTearColumn) // 21
                      diagnosisDetailsList.append(retinalTear!)
                     
                     let retinalVeinOcclusion = results.string(forColumn: retinalVeinOcclusionColumn) // 22
                 diagnosisDetailsList.append(retinalVeinOcclusion!)
                     
                     let rhegmatogenousRdMaculaOff = results.string(forColumn: rhegmatogenousRdMaculaOffColumn) // 23
                      diagnosisDetailsList.append(rhegmatogenousRdMaculaOff!)
                     
                     let rhegmatogenousRdMaculaOn =
                     results.string(forColumn: rhegmatogenousRdMaculaOnColumn) // 24
                     diagnosisDetailsList.append(rhegmatogenousRdMaculaOn!)
                     
                     let rop = results.string(forColumn: ropColumn) // 25
                     diagnosisDetailsList.append(rop!)
                     
                     let sickleCell = results.string(forColumn: sickleCelColumn) // 26
                     diagnosisDetailsList.append(sickleCell!)
                     
                     let spRdRepairWithSiliconeOil = results.string(forColumn: spRdRepairWithSiliconeOilColumn) // 27
                     diagnosisDetailsList.append(spRdRepairWithSiliconeOil!)
                     
                     let subluxedCrystallineLens = results.string(forColumn: subluxedCrystallineLensColumn) // 28
                     diagnosisDetailsList.append(subluxedCrystallineLens!)
                     
                     let vitreousHemorrhage = results.string(forColumn: vitreousHemorrhageColumn) // 29
                     diagnosisDetailsList.append(vitreousHemorrhage!)
                       
                        let retinalDefect = results.string(forColumn: retinalDefectColumn) // 30
                        diagnosisDetailsList.append(retinalDefect!)
                       
                        
                        let of1 = results.string(forColumn: otherField1Column) //31
                        diagnosisDetailsList.append(of1!)
                        let of2 = results.string(forColumn: otherField2Column) //32
                        diagnosisDetailsList.append(of2!)
                        let of3 = results.string(forColumn: otherField3Column) //33
                        diagnosisDetailsList.append(of3!)
                        let of4 = results.string(forColumn: otherField4Column) //34
                        diagnosisDetailsList.append(of4!)
                     
                     
                    
     
                              }
                    
                    print("details of diagnosis list in dbManger", diagnosisDetailsList)
                }
                catch {
                    print(error.localizedDescription)
                }
         
                database.close()
            }
         
          return diagnosisDetailsList
        }
    // fetch patient surgery details with help of id
    func loadPatientSurgeryDetails(withID Id: Int) -> [Any]  {
               var surgeryDetailsList : [Any] = []
               var fetchStatus: Bool = false
            
               if openDatabase() {
                   
                   print(Id)
                   let query = "Select personIdfromDemo1, gauge, band, sleeve, tamponad1, srfDrain, acTap, radialElement, membranePeel, ilmPeel, retinectomy, fluidAirExchange, pfo, focalEndolaser, prpLaser, indirectLaserTear, iolExchange, aciol, sulcusIol, sutured, sutureless, pplWithFrag, pplWithoutFrag, tamponade2, comments , otherField2Surgery , IolName , IolPower , positioning  ,percentageTamponade,otherFieldTamponade,retinalDetachment, macularHoleClosed, pomVisualAcuity, pom3VisualAcuity, otherOutcomeData , siliconeOilRemoval, siliconeOilExchange ,corodialDrainage ,iolReposition, cptCodeDropdown,cptFreeTextBox,cryotherapy , ilmDropDown from  Surgery WHERE personIdfromDemo1 =? and status = 1"
            
                  
                  
                   do {
                       
                       print(database)
                       
                       let results = try! database.executeQuery(query, values :[Id] )
                       fetchStatus = true
                       print("patient details fetched during search" ,fetchStatus)
                    
                    let personIdfromDemo1Column = "personIdfromDemo1" // 1
                    let gaugeColumn = "gauge"  // 2
                    let bandColumn = "band"   // 3
                    let sleeveColumn = "sleeve"  // 4
                    let tamponad1Column = "tamponad1"  // 5
                    let srfDrainColumn = "srfDrain"   // 6
                    let acTapColumn = "acTap"   // 7
                    let membranePeelColumn = "membranePeel"  //8
                    let ilmPeelColumn = "ilmPeel"    //9
                    let retinectomyColumn = "retinectomy"    // 10
                    let fluidAirExchangeColumn = "fluidAirExchange"   // 11
                    let pfoColumn = "pfo"   // 12
                    let focalEndolaserColumn = "focalEndolaser"  //13
                    let prpLaserColumn = "prpLaser"    // 14
                    let indirectLaserTearColumn = "indirectLaserTear"    //15
                    let iolExchangeColumn = "iolExchange"     // 16
                    let aciolColumn = "aciol"    // 17
                    let sulcusIolColumn = "sulcusIol"   // 18
                    let suturedColumn = "sutured"      // 19
                    let suturelessColumn = "sutureless"  // 20
                    let pplWithFragColumn = "pplWithFrag"  // 21
                    let pplWithoutFragColumn = "pplWithoutFrag"  // 22
                    let tamponade2Column = "tamponade2"  //23
                    let percentageTamponadeColumn = "percentageTamponade" //24
                    let otherFieldTamponadeColumn = "otherFieldTamponade" // 25
                    let commentsColumn = "comments"  // 26
                    let retinalDetachmentColumn = "retinalDetachment" // 27
                    let macularHoleClosedColumn = "macularHoleClosed" // 28
                    let pomVisualAcuityColumn = "pomVisualAcuity" // 29
                    let pom3VisualAcuityColumn = "pom3VisualAcuity" // 30
                    let otherOutcomeDataColumn = "otherOutcomeData" // 31
                    let otherField2Column = "otherField2Surgery" // 32
                   
                    let iolNameColumn = "IolName" //33
                    let IolPowerColumn = "IolPower"  // 34
                    let positioningColumn = "positioning" //35
                    let siliconeOilRemovalColumn = "siliconeOilRemoval" // 36
                    let siliconeOilExchangeColumn = "siliconeOilExchange" //37
                    let corodialDrainageColumn = "corodialDrainage" // 38
                    let iolRepositionColumn : String = "iolReposition"
                    let cptCodeDropdownColumn : String = "cptCodeDropdown"
                    let cptFreeTextBoxColumn : String = "cptFreeTextBox"
                    let cryotherapyColumn : String = "cryotherapy"
                    let ilmDropDownColumn : String = "ilmDropDown"
                    let radialElementCoulumn : String = "radialElement"
                   
            
                       while (results.next()) {
                           print("entered while loop")
                        let personIdfromDemo1 = Int(results.int(forColumn: personIdfromDemo1Column)) // 1
                        surgeryDetailsList.append(personIdfromDemo1)
                        
                        let gauge = results.string(forColumn: gaugeColumn)  // 2
                         surgeryDetailsList.append(gauge)
                        
                        let band = results.string(forColumn: bandColumn)  // 3
                        surgeryDetailsList.append(band)
                        
                        let sleeve = results.string(forColumn: sleeveColumn)  // 4
                        surgeryDetailsList.append(sleeve)
                        
                        let tamponad1 = results.string(forColumn: tamponad1Column)  // 5
                        surgeryDetailsList.append(tamponad1)
                        
                        let srfDrain = results.string(forColumn: srfDrainColumn)  // 6
                        surgeryDetailsList.append(srfDrain)
                        
                        let acTap = results.string(forColumn: acTapColumn) // 7
                         surgeryDetailsList.append(acTap)
                        
                        let radialElement = results.string(forColumn: radialElementCoulumn) // 7
                                               surgeryDetailsList.append(radialElement)
                        
                        let membranePeel = results.string(forColumn: membranePeelColumn) // 8
                        surgeryDetailsList.append(membranePeel)
                        
                        let ilmPeel = results.string(forColumn: ilmPeelColumn) // 9
                         surgeryDetailsList.append(ilmPeel)
                      
                        let retinectomy = results.string(forColumn: retinectomyColumn) // 10
                         surgeryDetailsList.append(retinectomy)
                       
                        let fluidAirExchange = results.string(forColumn: fluidAirExchangeColumn) // 11
                        surgeryDetailsList.append(fluidAirExchange)
                        
                        let pfo = results.string(forColumn: pfoColumn) // 12
                        surgeryDetailsList.append(pfo)
                        
                        let focalEndolaser =  results.string(forColumn: focalEndolaserColumn) // 13
                        surgeryDetailsList.append(focalEndolaser)
                        
                        let prpLaser = results.string(forColumn: prpLaserColumn) // 14
                        surgeryDetailsList.append(prpLaser)
                        
                        let indirectLaserTear = results.string(forColumn: indirectLaserTearColumn) // 15
                        surgeryDetailsList.append(indirectLaserTear)
                        
                        let iolExchange =  results.string(forColumn: iolExchangeColumn) // 16
                        surgeryDetailsList.append(iolExchange)
                        
                        let aciol = results.string(forColumn: iolExchangeColumn) // 17
                        surgeryDetailsList.append(iolExchange)
                        
                        let sulcusIol = results.string(forColumn: sulcusIolColumn) // 18
                        surgeryDetailsList.append(sulcusIol)
                        
                        let sutured = results.string(forColumn: suturedColumn) // 19
                        surgeryDetailsList.append(sutured)
                        
                        let sutureless =  results.string(forColumn: suturelessColumn) // 20
                           surgeryDetailsList.append(sutureless)
                        
                        let pplWithFrag =  results.string(forColumn: pplWithFragColumn) // 21
                           surgeryDetailsList.append(pplWithFrag)
                        
                        let pplWithoutFrag =  results.string(forColumn: pplWithoutFragColumn) // 22
                            surgeryDetailsList.append(pplWithoutFrag)
                        let tamponade2 = results.string(forColumn: tamponade2Column) // 23
                        surgeryDetailsList.append(tamponade2)
                        let percentageTamponade = results.string(forColumn: percentageTamponadeColumn) // 24
                        surgeryDetailsList.append(percentageTamponade)
                        
                        let otherFieldTamponade = results.string(forColumn: otherFieldTamponadeColumn) // 25
                                               surgeryDetailsList.append(otherFieldTamponade)
                        let otherField2 = results.string(forColumn: otherField2Column)
                        surgeryDetailsList.append(otherField2)
                        
                        let iolName = results.string(forColumn: iolNameColumn)
                        surgeryDetailsList.append(iolName)
                        
                        let iolPower = results.string(forColumn: IolPowerColumn)
                        surgeryDetailsList.append(iolPower)
                        
                        let positioning = results.string(forColumn: positioningColumn)
                        surgeryDetailsList.append(positioning)
                       
                        let siliconeOilRemoval = results.string(forColumn: siliconeOilRemovalColumn) // SilconeIolRemoval
                                                                      surgeryDetailsList.append(siliconeOilRemoval!)
                                                                      
                        let siliconeOilExchange = results.string(forColumn: siliconeOilExchangeColumn) // siliconeOilEcachange
                        surgeryDetailsList.append(siliconeOilExchange!)
                        
                        let corodialDrainage = results.string(forColumn: corodialDrainageColumn) // corodial Drainage
                        surgeryDetailsList.append(corodialDrainage)
                        let comments =  results.string(forColumn: commentsColumn)
                        surgeryDetailsList.append(comments)
                        
                       
                                               
                       
                        let retinalDetachment = results.string(forColumn: retinalDetachmentColumn)
                        surgeryDetailsList.append(retinalDetachment)
                        
                        let macularHoleClosed = results.string(forColumn: macularHoleClosedColumn)
                        surgeryDetailsList.append(macularHoleClosed)
                       
                        let pomVisualAcuity = results.string(forColumn: pomVisualAcuityColumn)
                         surgeryDetailsList.append(pomVisualAcuity)
                       
                        let pom3VisualAcuity = results.string(forColumn: pom3VisualAcuityColumn)
                        surgeryDetailsList.append(pom3VisualAcuity)
                       
                        let otherOutcomesData = results.string(forColumn: otherOutcomeDataColumn)
                        surgeryDetailsList.append(otherOutcomesData)
                        
                        // udated 2nt version
                        let iolReposition = results.string(forColumn: iolRepositionColumn)
                        surgeryDetailsList.append(iolReposition!)
                                                                      
                        let cptCodeDropdown = results.string(forColumn: cptCodeDropdownColumn)
                        surgeryDetailsList.append(cptCodeDropdown!)
                                                                      
                        let cptFreeTextBox = results.string(forColumn: cptFreeTextBoxColumn)
                        surgeryDetailsList.append(cptFreeTextBox!)
                                                                      
                        let cryotherapy = results.string(forColumn: cryotherapyColumn)
                        surgeryDetailsList.append(cryotherapy!)
                        
                        let ilmDropDown = results.string(forColumn: ilmDropDownColumn)
                        surgeryDetailsList.append(ilmDropDown!)
                       
                             
                                 }
                       
                       print("details of patient list in dbManger", surgeryDetailsList)
                   }
                   catch {
                       print(error.localizedDescription)
                   }
            
                   database.close()
               }
            
             return surgeryDetailsList
           }
    
    // fetch patient surgery details with help of id while editing
       func loadPatientSurgeryDetailsWhileEditing( Id: Int) -> [String]  {
                  var surgeryDetailsList : [String] = []
                  var fetchStatus: Bool = false
               
                  if openDatabase() {
                      
                      print(Id)
                      let query = "Select personIdfromDemo1, gauge, band, sleeve, tamponad1, srfDrain, acTap,  radialElement,membranePeel, ilmPeel, retinectomy, fluidAirExchange, pfo, focalEndolaser, prpLaser, indirectLaserTear, iolExchange, aciol, sulcusIol, sutured, sutureless, pplWithFrag, pplWithoutFrag, tamponade2,  comments , percentageTamponade , otherFieldTamponade , otherField2Surgery, virectomy, scleralBuckle , iolInsertion , iolName , iolPower , positioning  , siliconeOilRemoval, siliconeOilExchange , corodialDrainage ,iolReposition, cptCodeDropdown,cptFreeTextBox,cryotherapy , ilmDropDown from  Surgery WHERE personIdfromDemo1 ='\(Id)' and status = 1"
               
                     
                     
                      do {
                          
                          print(database)
                          
                       let results = try! database.executeQuery(query, values :[Id] )
                           fetchStatus = true
                          print("patient details fetched during search" ,fetchStatus)
                       
                    //   let personIdfromDemo1Column = "personIdfromDemo1"
                       let gaugeColumn = "gauge" //1
                       let bandColumn = "band"  //2
                       let sleeveColumn = "sleeve" //3
                       let tamponad1Column = "tamponad1" //4
                       let srfDrainColumn = "srfDrain"  //5
                       let acTapColumn = "acTap" //6
                       let membranePeelColumn = "membranePeel" //7
                       let ilmPeelColumn = "ilmPeel" //8
                       let retinectomyColumn = "retinectomy" //9
                       let fluidAirExchangeColumn = "fluidAirExchange" //10
                       let pfoColumn = "pfo" //11
                       let focalEndolaserColumn = "focalEndolaser" //12
                       let prpLaserColumn = "prpLaser" //13
                       let indirectLaserTearColumn = "indirectLaserTear" //14
                       let iolExchangeColumn = "iolExchange" //15
                       let aciolColumn = "aciol" //16
                       let sulcusIolColumn = "sulcusIol" //17
                        let suturedColumn = "sutured" //18
                       let suturelessColumn = "sutureless" //19
                       let pplWithFragColumn = "pplWithFrag" //20
                       let pplWithoutFragColumn = "pplWithoutFrag" //21
                       let tamponade2Column = "tamponade2" //22
                       let commentsColumn = "comments" //23
                       var percentageTamponadeColumn : String = "percentageTamponade" //24
                        var otherFieldTamponadeColumn : String = "otherFieldTamponade"
                                         //25
                        var otherFieldSurgery2Column : String = "otherField2Surgery" //26
                        var virectomyColumn : String = "virectomy"  //27
                        var scleralBuckleColumn : String = "scleralBuckle" //28
                         var iolInsertionColumn : String = "iolInsertion" //29
                        var iolNameColumn : String = "iolName" //30
                        var iolPowerColumn : String = "IolPower" //31
                        var positioningColumn : String = "positioning" //32
                        let siliconeOilRemovalColumn = "siliconeOilRemoval"
                        let siliconeOilExchangeColumn = "siliconeOilExchange"
                        let corodialDrainageColumn = "corodialDrainage"
                        let iolRepositionColumn : String = "iolReposition"
                        let cptCodeDropdownColumn : String = "cptCodeDropdown"
                        let cptFreeTextBoxColumn : String = "cptFreeTextBox"
                        let cryotherapyColumn : String = "cryotherapy"
                        let ilmDropDownColumn : String = "ilmDropDown"
                        let radialElementColumn : String = "radialElement"
                                       
                        while (results.next()) {
                              print("entered while loop")
//                           let personIdfromDemo1 = Int(results.int(forColumn: personIdfromDemo1Column)) // 1
//                           surgeryDetailsList.append(personIdfromDemo1)
//
                           let gauge = results.string(forColumn: gaugeColumn)
                            surgeryDetailsList.append(gauge!) //1
                           
                           let band = results.string(forColumn: bandColumn)
                           surgeryDetailsList.append(band!) //2
                           
                           let sleeve = results.string(forColumn: sleeveColumn)
                           surgeryDetailsList.append(sleeve!) //3
                           
                           let tamponad1 = results.string(forColumn: tamponad1Column)
                           surgeryDetailsList.append(tamponad1!) //4
                           
                           let srfDrain = results.string(forColumn: srfDrainColumn)
                           surgeryDetailsList.append(srfDrain!) //5
                           
                           let acTap = results.string(forColumn: acTapColumn)
                            surgeryDetailsList.append(acTap!) //6
                           
                           let membranePeel = results.string(forColumn: membranePeelColumn)
                           surgeryDetailsList.append(membranePeel!) //7
                           
                           let ilmPeel = results.string(forColumn: ilmPeelColumn)
                            surgeryDetailsList.append(ilmPeel!) //8
                         
                           let retinectomy = results.string(forColumn: retinectomyColumn)
                            surgeryDetailsList.append(retinectomy!) //9
                          
                           let fluidAirExchange = results.string(forColumn: fluidAirExchangeColumn)
                           surgeryDetailsList.append(fluidAirExchange!) //10
                           
                           let pfo = results.string(forColumn: pfoColumn)
                           surgeryDetailsList.append(pfo!) //11
                           
                           let focalEndolaser =  results.string(forColumn: focalEndolaserColumn)
                           surgeryDetailsList.append(focalEndolaser!) //12
                           
                           let prpLaser = results.string(forColumn: prpLaserColumn)
                           surgeryDetailsList.append(prpLaser!) //13
                           
                           let indirectLaserTear = results.string(forColumn: indirectLaserTearColumn)
                           surgeryDetailsList.append(indirectLaserTear!) //14
                           
                           let iolExchange =  results.string(forColumn: iolExchangeColumn)
                           surgeryDetailsList.append(iolExchange!) //15
                           
                           let aciol = results.string(forColumn: iolExchangeColumn)
                           surgeryDetailsList.append(iolExchange!) //16
                           
                           let sulcusIol = results.string(forColumn: sulcusIolColumn)
                           surgeryDetailsList.append(sulcusIol!) //17
                           
                           let sutured = results.string(forColumn: suturedColumn)
                           surgeryDetailsList.append(sutured!)  //18
                           
                           let sutureless =  results.string(forColumn: suturelessColumn)
                              surgeryDetailsList.append(sutureless!) //19
                           
                           let pplWithFrag =  results.string(forColumn: pplWithFragColumn)
                              surgeryDetailsList.append(pplWithFrag!) //20
                           
                           let pplWithoutFrag =  results.string(forColumn: pplWithoutFragColumn)
                               surgeryDetailsList.append(pplWithoutFrag!) //21
                           let tamponade2 = results.string(forColumn: tamponade2Column)
                           surgeryDetailsList.append(tamponade2!) //22
                           
                           let comments =  results.string(forColumn: commentsColumn) 
                           surgeryDetailsList.append(comments!) //23
        
        
        let percentageTamponade = results.string(forColumn: percentageTamponadeColumn)
        surgeryDetailsList.append(percentageTamponade!) //24
        
        let otherFieldTamponade = results.string(forColumn: otherFieldTamponadeColumn)
        surgeryDetailsList.append(otherFieldTamponade!) //25
        
        let otherField2 = results.string(forColumn: otherFieldSurgery2Column)
        surgeryDetailsList.append(otherField2!) //26
        
        
        let virectomy = results.string(forColumn: virectomyColumn)
        surgeryDetailsList.append(virectomy!) // 27
        
        
        let scleralBuckle = results.string(forColumn: scleralBuckleColumn)
        surgeryDetailsList.append(scleralBuckle!)  // 28
        
        let iolInsertion = results.string(forColumn: iolInsertionColumn)
        surgeryDetailsList.append(iolInsertion!) //29
        
        let iolName = results.string(forColumn: iolNameColumn)
        surgeryDetailsList.append(iolName!) //30
        
        let iolPower = results.string(forColumn: iolPowerColumn)
        surgeryDetailsList.append(iolPower!) // 31
        
        let positioning = results.string(forColumn: positioningColumn)
        
        surgeryDetailsList.append(positioning!) // 32
        
                            let siliconeOilRemoval = results.string(forColumn: siliconeOilRemovalColumn) // SilconeIolRemoval
                            surgeryDetailsList.append(siliconeOilRemoval!)
                                                                          
                            let siliconeOilExchange = results.string(forColumn: siliconeOilExchangeColumn) // siliconeOilEcachange
                            surgeryDetailsList.append(siliconeOilExchange!)
                            
                            
                            let corodialDrainage = results.string(forColumn: corodialDrainageColumn) // siliconeOilEcachange
                            surgeryDetailsList.append(corodialDrainage!)
                            
                            
                            
                            // udated 2nt version
                             let iolReposition = results.string(forColumn: iolRepositionColumn)
                             surgeryDetailsList.append(iolReposition!)
                                                                           
                             let cptCodeDropdown = results.string(forColumn: cptCodeDropdownColumn)
                             surgeryDetailsList.append(cptCodeDropdown!)
                                                                           
                            let cptFreeTextBox = results.string(forColumn: cptFreeTextBoxColumn)
                             surgeryDetailsList.append(cptFreeTextBox!)
                                                                           
                             let cryotherapy = results.string(forColumn: cryotherapyColumn)
                             surgeryDetailsList.append(cryotherapy!)
                            
                            let ilmDropDown = results.string(forColumn: ilmDropDownColumn)
                                                   surgeryDetailsList.append(ilmDropDown!)
                           let radialElement = results.string(forColumn: radialElementColumn)
                           surgeryDetailsList.append(radialElement!)
        
                                                     
                                    }
                          
                        print("details of patient list in dbManger", surgeryDetailsList)
                      }
                      catch {
                          print(error.localizedDescription)
                      }
               
                      database.close()
                  }
        
                return surgeryDetailsList
              }
      
    
    //searching Camera Details with help of mrn
       func loadCameraImageDetails(withID Id: Int) -> [Any]  {
               var cameraImageDetails : [Any] = []
               var fetchStatus: Bool = false
            
               if openDatabase() {
                   
                   print(Id)
                   let query = "Select imageUniqueId,image,mrn , comment from CameraImage  where imageUniqueId = '\(Id)' and status = 1"
            
        
                  
                  
                   do {
                       
                       print(database)
                       
                       let results = try! database.executeQuery(query, values : nil )
                       fetchStatus = true
                       print("patient details fetched during search" ,fetchStatus)

                    let imageUniqueIdColumn = "imageUniqueId"
                    let imageColumn = "image"
                    let mrnColumn = "mrn"
                    let commentColum = "comment"
                    
                       while (results.next()) {
                           print("entered while loop")
                          
                       let  imageUniqueId = Int(results.int(forColumn: imageUniqueIdColumn))
                        cameraImageDetails.append(imageUniqueId)
                     
                        let image = results.string(forColumn: imageColumn)
                        cameraImageDetails.append(image)
                        
                        let mrn = results.string(forColumn: mrnColumn)
                        cameraImageDetails.append(mrn)
                        
                        let comment = results.string(forColumn: commentColum)
                        cameraImageDetails.append(comment)
                           
                           
                        
                                               }
                       
                       print("details of patient list in dbManger", cameraImageDetails)
                   }
                   catch {
                       print(error.localizedDescription)
                   }
            
                   database.close()
               }
            
             return cameraImageDetails
           }
    
    // deleting data of previous View Controller at the back press of present controller
    func deleteDemographicsTempDataWhenBactPressedAtDiagnosis(withID ID: Int) -> Bool {
        var deleted = false
     
        if openDatabase() {
            let query = "delete from Demographics1  where personIdDemo1 =?"
     
            do {
                try database.executeUpdate(query, values: [ID])
                deleted = true
            }
            catch {
                print(error.localizedDescription)
            }
     
            database.close()
        }
     
        return deleted
    }
    
    // deleting data of previous View Controller at the back press of present controller
    func deleteDiagnosisTempDataWhenBactPressedAtSurgery(withID ID: Int) -> Bool {
        var deleted = false
     
        if openDatabase() {
            let query = "delete from Demographics2 where personIdfromDemo1 =?"
     
            do {
                try database.executeUpdate(query, values: [ID])
                deleted = true
            }
            catch {
                print(error.localizedDescription)
            }
     
            database.close()
        }
     
        return deleted
    }
    
    // deleting data of previous View Controller at the back press of present controller
      func deleteSurgeryTempDataWhenBactPressedAtCameraVC(withID ID: Int) -> Bool {
          var deleted = false
       
          if openDatabase() {
              let query = "delete from Surgery where personIdDemo1 =?"
       
              do {
                  try database.executeUpdate(query, values: [ID])
                      deleted = true
              }
              catch {
                  print(error.localizedDescription)
              }
       
              database.close()
          }
       
          return deleted
      }
    
    // deleting data of previous View Controller at the back press of present controller
        func deleteCameraImageTempDataWhenBactPressedAtFellowVC(withID ID: Int) -> Bool {
            var deleted = false
         
            if openDatabase() {
                let query = "delete from CameraImage where imageUniqueId =?"
         
                do {
                    try database.executeUpdate(query, values: [ID])
                        deleted = true
                }
                catch {
                    print(error.localizedDescription)
                }
         
                database.close()
            }
         
            return deleted
        }
    
    
    
    
    // select data for export to csv from demographics1 , demographics2, surgery tables on basis of Start date and End Date Selected
    func loadPatientDetailsForExportByDate(withID startDate: String , endDate : String) -> [CsvExportDataModel]! {
            var patientCsvDataExportModelList: [CsvExportDataModel]!
            var fetchStatus: Bool = false
         
            if openDatabase() {
                
                print(startDate)
                print(endDate)
                let query = "select lastName, firstname, dob, mrn, eye, fellowInvolvement, level, surgerySetting, hospitalName,date, aphakia, cataract, choroidalEffusion, choroidalHemorrhage, diabeticTrd, dislocatedIntraocularLens, endophthalmitis, epiretinalMembrane, fevr, floaters, fullThicknessMacularHole, intraocularForeignBody, lamellarMacularHole, latticeDegeneration, pdr, primaryRdWithPvr, recurrentRdWithPvr, recurrentRdWithOutPvr, retainedLensFragments, retinalTear, retinalVeinOcclusion, rhegmatogenousRdMaculaOff, rhegmatogenousRdMaculaOn, rop, sickleCell, spRdRepairWithSiliconeOil, subluxedCrystallineLens, vitreousHemorrhage,otherField, otherField2 ,otherField3, otherField4,gauge, band, sleeve, tamponad1, srfDrain, acTap, radialElement, membranePeel, ilmPeel, retinectomy, fluidAirExchange, pfo, focalEndolaser, prpLaser, indirectLaserTear, iolExchange, aciol, sulcusIol, sutured, sutureless, pplWithFrag, pplWithoutFrag, tamponade2, comments , percentageTamponade , otherFieldTamponade ,otherField2, virectomy, scleralBuckle , iolInsertion , iolName , iolPower , positioning ,siliconeOilRemoval, siliconeOilExchange , corodialDrainage  ,iolReposition, cptCodeDropdown,cptFreeTextBox,cryotherapy , ilmDropDown , retinalDetachment, macularHoleClosed ,  pomVisualAcuity , pom3VisualAcuity , otherOutcomeData , fellowInvolvementPercentage , retinalDefect from Demographics1 D1 inner join  Demographics2 D2 on   D1.personIdDemo1 = D2.personIdfromDemo1 inner join Surgery S  on  D1.personIdDemo1 = S.personIdfromDemo1 where D1.status = 1 and D1.date BETWEEN  '\(startDate)' and  '\(endDate)' "
         
                 var lastNameColumn: String = "lastName"
                 var firstnameColumn: String = "firstname"
                 var dobColumn: String = "dob"
                 var mrnColumn: String = "mrn"
                 var eyeColumn: String = "eye"
                 var fellowInvolvementColumn: String = "fellowInvolvement"
                 var levelColumn: String = "level"
                 var surgerySettingColumn: String = "surgerySetting"
                 var hospitalNameColumn: String = "hospitalName"
                 var dateColumn: String = "date"
                 var aphakiaColumn: String = "aphakia"
                 var cataractColumn: String = "cataract"
                 var choroidalEffusionColumn: String = "choroidalEffusion"
                 var choroidalHemorrhageColumn: String = "choroidalEffusion"
                 var diabeticTrdColumn: String = "diabeticTrd"
                 var dislocatedIntraocularLensColumn: String = "dislocatedIntraocularLens"
                 var endophthalmitisColumn: String = "endophthalmitis"
                 var epiretinalMembraneColumn: String = "epiretinalMembrane"
                 var fevrColumn: String = "fevr"
                 var floatersColumn: String  = "floaters"
                 var fullThicknessMacularHoleColumn:  String  = "fullThicknessMacularHole"
                 var intraocularForeignBodyColumn: String = "intraocularForeignBody"
                 var lamellarMacularHoleColumn: String  = "lamellarMacularHole"
                 var latticeDegenerationColumn: String = "latticeDegeneration"
                 var pdrColumn: String = "pdr"
                 var primaryRdWithPvrColumn: String = "primaryRdWithPvr"
                 var recurrentRdWithPvrColumn: String = "recurrentRdWithPvr"
                 var recurrentRdWithOutPvrColumn: String = "recurrentRdWithOutPvr"
                 var retainedLensFragmentsColumn: String  = "retainedLensFragments"
                 var retinalTearColumn: String = "retinalTear"
                 var retinalVeinOcclusionColumn: String = "retinalVeinOcclusion"
                 var rhegmatogenousRdMaculaOffColumn: String = "rhegmatogenousRdMaculaOff"
                 var rhegmatogenousRdMaculaOnColumn: String = "rhegmatogenousRdMaculaOn"
                 var ropColumn: String = "rop"
                 var sickleCellColumn: String = "sickleCell"
                 var spRdRepairWithSiliconeOilColumn: String = "spRdRepairWithSiliconeOil"
                 var subluxedCrystallineLensColumn: String = "subluxedCrystallineLens"
                 var vitreousHemorrhageColumn: String = "vitreousHemorrhage"
                 var otherFieldColumn: String = "otherField"
                 var otherField2Column: String = "otherField2"
                 var otherField3Column: String = "otherField3"
                 var otherField4Column: String = "otherField4"
                 var gaugeColumn: String = "gauge"
                 var bandColumn: String = "band"
                 var sleeveColumn: String = "sleeve"
                 var tamponad1Column: String = "tamponad1"
                 var srfDrainColumn: String = "srfDrain"
                 var acTapColumn: String = "acTap"
                 var membranePeelColumn: String = "membranePeel"
                 var ilmPeelColumn: String = "ilmPeel"
                 var retinectomyColumn: String = "retinectomy"
                 var fluidAirExchangeColumn: String = "fluidAirExchange"
                 var pfoColumn: String = "pfo"
                 var focalEndolaserColumn: String = "focalEndolaser"
                 var prpLaserColumn:String = "prpLaser"
                 var indirectLaserTearColumn: String = "indirectLaserTear"
                 var iolExchangeColumn: String = "iolExchange"
                 var aciolColumn: String = "aciol"
                 var sulcusIolColumn: String = "sulcusIol"
                 var suturedColumn: String = "sutured"
                 var suturelessColumn: String = "sutureless"
                 var pplWithFragColumn: String = "pplWithFrag"
                 var pplWithoutFragColumn: String = "pplWithoutFrag"
                 var tamponade2Column: String = "tamponade2"
                 var commentsColumn: String = "comments"
                 var percentageTamponadeColumn : String = "percentageTamponade"
                 var otherFieldTamponadeColumn : String = "otherFieldTamponade"
                 var otherFieldSurgery2Column : String = "otherField2"
                 var virectomyColumn : String = "virectomy"
                 var scleralBuckleColumn : String = "scleralBuckle"
                 var iolInsertionColumn : String = "iolInsertion"
                 var iolNameColumn : String = "iolName"
                 var iolPowerColumn : String = "IolPower"
                 var positioningColumn : String = "positioning"
                 var retinalDetachmentColumn : String = "retinalDetachment"
                 var macularHoleClosedColumn : String = "macularHoleClosed"
                 var pomVisualAcuityColumn: String = "pomVisualAcuity"
                 var pom3VisualAcuityColumn: String = "pom3VisualAcuity"
                 var otherOutcomeDataColumn : String = "otherOutcomeData"
                 var siliconeOilRemovalColumn : String = "siliconeOilRemoval"
                 var siliconeOilExchangeColumn : String = "siliconeOilExchange"
                 var corodialDrainageColumn : String = "corodialDrainage"
                 let iolRepositionColumn : String = "iolReposition"
                 let cptCodeDropdownColumn : String = "cptCodeDropdown"
                 let cptFreeTextBoxColumn : String = "cptFreeTextBox"
                 let cryotherapyColumn : String = "cryotherapy"
                 let ilmDropDownColumn : String = "ilmDropDown"
                 let radialElementColumn : String = "radialElement"
                let fellowInvolvementPercentageColumn : String = "fellowInvolvementPercentage"
                let retinalDefectColumn: String = "retinalDefect"
                do {
                    
                    print(database)
                    
                    let results = try! database.executeQuery(query, values : nil )
                    fetchStatus = true
                    print("patient details fetched during search" ,fetchStatus)

         
                    while (results.next()) {
                        print("while loop entered")
                        
                        let patientCsvDataExportModel = CsvExportDataModel(lastName: results.string(forColumn: lastNameColumn),
                                                                           firstname: results.string(forColumn: firstnameColumn),
                          
                                                                           dob: results.string(forColumn: dobColumn)
                            , mrn: results.string(forColumn: mrnColumn),
                              eye: results.string(forColumn: eyeColumn)
                              ,fellowInvolvement: results.string(forColumn: fellowInvolvementColumn), level: results.string(forColumn: levelColumn), surgerySetting: results.string(forColumn: surgerySettingColumn), hospitalName: results.string(forColumn: hospitalNameColumn), date: results.string(forColumn: dateColumn), aphakia: results.string(forColumn: aphakiaColumn), cataract: results.string(forColumn: cataractColumn), choroidalEffusion: results.string(forColumn: choroidalEffusionColumn), choroidalHemorrhage: results.string(forColumn: choroidalHemorrhageColumn), diabeticTrd: results.string(forColumn: diabeticTrdColumn), dislocatedIntraocularLens: results.string(forColumn: dislocatedIntraocularLensColumn), endophthalmitis: results.string(forColumn: endophthalmitisColumn), epiretinalMembrane: results.string(forColumn: epiretinalMembraneColumn),
                              fevr: results.string(forColumn: fevrColumn),
                              floaters: results.string(forColumn: floatersColumn),
                              fullThicknessMacularHole: results.string(forColumn: fullThicknessMacularHoleColumn),
                              intraocularForeignBody: results.string(forColumn: intraocularForeignBodyColumn),
                              lamellarMacularHole: results.string(forColumn: lamellarMacularHoleColumn),
                             latticeDegeneration: results.string(forColumn: latticeDegenerationColumn),
                             pdr: results.string(forColumn: pdrColumn),
                             primaryRdWithPvr: results.string(forColumn: primaryRdWithPvrColumn),
                             recurrentRdWithPvr: results.string(forColumn: recurrentRdWithPvrColumn),
                             recurrentRdWithOutPvr: results.string(forColumn: recurrentRdWithOutPvrColumn),
                             retainedLensFragments: results.string(forColumn: retainedLensFragmentsColumn), retinalTear: results.string(forColumn: retinalTearColumn),
                             retinalVeinOcclusion: results.string(forColumn: retinalVeinOcclusionColumn), rhegmatogenousRdMaculaOff: results.string(forColumn: rhegmatogenousRdMaculaOffColumn),
                             rhegmatogenousRdMaculaOn: results.string(forColumn: rhegmatogenousRdMaculaOnColumn) , rop: results.string(forColumn: ropColumn)!, sickleCell: results.string(forColumn: sickleCellColumn), spRdRepairWithSiliconeOil: results.string(forColumn: spRdRepairWithSiliconeOilColumn), subluxedCrystallineLens: results.string(forColumn: subluxedCrystallineLensColumn), vitreousHemorrhage: results.string(forColumn: vitreousHemorrhageColumn), otherField: results.string(forColumn: otherFieldColumn),otherField2 : results.string(forColumn: otherField2Column) , otherField3 : results.string(forColumn: otherField3Column), otherField4 : results.string(forColumn: otherField4Column) , gauge: results.string(forColumn: gaugeColumn), band: results.string(forColumn: bandColumn), sleeve: results.string(forColumn: sleeveColumn), tamponad1: results.string(forColumn: tamponad1Column), srfDrain: results.string(forColumn: srfDrainColumn), acTap: results.string(forColumn: acTapColumn), radialElement: results.string(forColumn: radialElementColumn) , membranePeel: results.string(forColumn: membranePeelColumn), ilmPeel: results.string(forColumn: ilmPeelColumn), retinectomy: results.string(forColumn: retinectomyColumn), fluidAirExchange: results.string(forColumn: fluidAirExchangeColumn), pfo: results.string(forColumn: pfoColumn), focalEndolaser: results.string(forColumn: focalEndolaserColumn), prpLaser: results.string(forColumn: prpLaserColumn), indirectLaserTear: results.string(forColumn: indirectLaserTearColumn), iolExchange: results.string(forColumn: iolExchangeColumn), aciol: results.string(forColumn: aciolColumn), sulcusIol: results.string(forColumn: sulcusIolColumn), sutured: results.string(forColumn: suturedColumn), sutureless: results.string(forColumn: suturelessColumn), pplWithFrag: results.string(forColumn: pplWithFragColumn), pplWithoutFrag: results.string(forColumn: pplWithoutFragColumn), tamponade2: results.string(forColumn: tamponade2Column),percentageTamponade: results.string(forColumn: percentageTamponadeColumn)  ,
                             otherFieldTamponade: results.string(forColumn: otherFieldTamponadeColumn) ,comments: results.string(forColumn: commentsColumn)  ,
                             otherField2Surgery: results.string(forColumn: otherFieldSurgery2Column),
                             virectomy: results.string(forColumn: virectomyColumn),
                             scleralBuckle: results.string(forColumn: scleralBuckleColumn),
                             iolInsertion: results.string(forColumn: iolInsertionColumn), siliconeOilRemoval: results.string(forColumn: siliconeOilRemovalColumn) , siliconeOilExchange: results.string(forColumn: siliconeOilExchangeColumn),corodialDrainage: results.string(forColumn: corodialDrainageColumn), iolReposition: results.string(forColumn: iolRepositionColumn),cptCodeDropdown: results.string(forColumn: cptCodeDropdownColumn), cptFreeTextBox: results.string(forColumn: cptFreeTextBoxColumn) , cryotherapy: results.string(forColumn: cryotherapyColumn),ilmCodeDropdown:  results.string(forColumn: ilmDropDownColumn) ,
                             iolName : results.string(forColumn: iolNameColumn),
                             iolPower: results.string(forColumn: iolPowerColumn ) , positioning: results.string(forColumn: positioningColumn ),
                             
                                  retinalDetachment: results.string(forColumn: retinalDetachmentColumn) , macularHoleClosed: results.string(forColumn: macularHoleClosedColumn) ,
                                                                           pomVisualAcuity: results.string(forColumn: pomVisualAcuityColumn) , pom3VisualAcuity: results.string(forColumn: pom3VisualAcuityColumn),otherOutcomeData: results.string(forColumn: otherOutcomeDataColumn ) ,fellowInvolvementPercentage: results.string(forColumn: fellowInvolvementPercentageColumn),retinalDefect: results.string(forColumn: retinalDefectColumn)
                                  
                             
                             
                             )
                        
                     
                       if patientCsvDataExportModelList  == nil {
                                                                           patientCsvDataExportModelList = [CsvExportDataModel]()
                                                                       }
                                     
                        patientCsvDataExportModelList.append(patientCsvDataExportModel)
                        
                              }
                    
                    print("details of patient list in dbManger", patientCsvDataExportModelList)
                
                }
                catch {
                    print(error.localizedDescription)
                }
                
            }
           return patientCsvDataExportModelList
        }
    
    // Export all the patient details
    func loadPatientDetailsForExportAllRecords() -> [CsvExportDataModel]! {
            var patientCsvDataExportModelList: [CsvExportDataModel]!
            var fetchStatus: Bool = false
         
            if openDatabase() {
                
               
                let query = "select lastName, firstname, dob, mrn, eye, fellowInvolvement, level, surgerySetting, hospitalName,date, aphakia, cataract, choroidalEffusion, choroidalHemorrhage, diabeticTrd, dislocatedIntraocularLens, endophthalmitis, epiretinalMembrane, fevr, floaters, fullThicknessMacularHole, intraocularForeignBody, lamellarMacularHole, latticeDegeneration, pdr, primaryRdWithPvr, recurrentRdWithPvr, recurrentRdWithOutPvr, retainedLensFragments, retinalTear, retinalVeinOcclusion, rhegmatogenousRdMaculaOff, rhegmatogenousRdMaculaOn, rop, sickleCell, spRdRepairWithSiliconeOil, subluxedCrystallineLens, vitreousHemorrhage,otherField, otherField2 ,otherField3, otherField4,gauge, band, sleeve, tamponad1, srfDrain, acTap, radialElement, membranePeel, ilmPeel, retinectomy, fluidAirExchange, pfo, focalEndolaser, prpLaser, indirectLaserTear, iolExchange, aciol, sulcusIol, sutured, sutureless, pplWithFrag, pplWithoutFrag, tamponade2, comments , percentageTamponade , otherFieldTamponade ,otherField2, virectomy, scleralBuckle , iolInsertion , iolName , iolPower , positioning ,siliconeOilRemoval, siliconeOilExchange , corodialDrainage  ,iolReposition, cptCodeDropdown,cptFreeTextBox,cryotherapy , ilmDropDown , retinalDetachment, macularHoleClosed ,  pomVisualAcuity , pom3VisualAcuity , otherOutcomeData , fellowInvolvementPercentage , retinalDefect from Demographics1 D1 inner join  Demographics2 D2 on   D1.personIdDemo1 = D2.personIdfromDemo1 inner join Surgery S  on  D1.personIdDemo1 = S.personIdfromDemo1 "
         
                 var lastNameColumn: String = "lastName"
                 var firstnameColumn: String = "firstname"
                 var dobColumn: String = "dob"
                 var mrnColumn: String = "mrn"
                 var eyeColumn: String = "eye"
                 var fellowInvolvementColumn: String = "fellowInvolvement"
                 var levelColumn: String = "level"
                 var surgerySettingColumn: String = "surgerySetting"
                 var hospitalNameColumn: String = "hospitalName"
                 var dateColumn: String = "date"
                 var aphakiaColumn: String = "aphakia"
                 var cataractColumn: String = "cataract"
                 var choroidalEffusionColumn: String = "choroidalEffusion"
                 var choroidalHemorrhageColumn: String = "choroidalEffusion"
                 var diabeticTrdColumn: String = "diabeticTrd"
                 var dislocatedIntraocularLensColumn: String = "dislocatedIntraocularLens"
                 var endophthalmitisColumn: String = "endophthalmitis"
                 var epiretinalMembraneColumn: String = "epiretinalMembrane"
                 var fevrColumn: String = "fevr"
                 var floatersColumn: String  = "floaters"
                 var fullThicknessMacularHoleColumn:  String  = "fullThicknessMacularHole"
                 var intraocularForeignBodyColumn: String = "intraocularForeignBody"
                 var lamellarMacularHoleColumn: String  = "lamellarMacularHole"
                 var latticeDegenerationColumn: String = "latticeDegeneration"
                 var pdrColumn: String = "pdr"
                 var primaryRdWithPvrColumn: String = "primaryRdWithPvr"
                 var recurrentRdWithPvrColumn: String = "recurrentRdWithPvr"
                 var recurrentRdWithOutPvrColumn: String = "recurrentRdWithOutPvr"
                 var retainedLensFragmentsColumn: String  = "retainedLensFragments"
                 var retinalTearColumn: String = "retinalTear"
                 var retinalVeinOcclusionColumn: String = "retinalVeinOcclusion"
                 var rhegmatogenousRdMaculaOffColumn: String = "rhegmatogenousRdMaculaOff"
                 var rhegmatogenousRdMaculaOnColumn: String = "rhegmatogenousRdMaculaOn"
                 var ropColumn: String = "rop"
                 var sickleCellColumn: String = "sickleCell"
                 var spRdRepairWithSiliconeOilColumn: String = "spRdRepairWithSiliconeOil"
                 var subluxedCrystallineLensColumn: String = "subluxedCrystallineLens"
                 var vitreousHemorrhageColumn: String = "vitreousHemorrhage"
                 var otherFieldColumn: String = "otherField"
                 var otherField2Column: String = "otherField2"
                 var otherField3Column: String = "otherField3"
                 var otherField4Column: String = "otherField4"
                 var gaugeColumn: String = "gauge"
                 var bandColumn: String = "band"
                 var sleeveColumn: String = "sleeve"
                 var tamponad1Column: String = "tamponad1"
                 var srfDrainColumn: String = "srfDrain"
                 var acTapColumn: String = "acTap"
                 var membranePeelColumn: String = "membranePeel"
                 var ilmPeelColumn: String = "ilmPeel"
                 var retinectomyColumn: String = "retinectomy"
                 var fluidAirExchangeColumn: String = "fluidAirExchange"
                 var pfoColumn: String = "pfo"
                 var focalEndolaserColumn: String = "focalEndolaser"
                 var prpLaserColumn:String = "prpLaser"
                 var indirectLaserTearColumn: String = "indirectLaserTear"
                 var iolExchangeColumn: String = "iolExchange"
                 var aciolColumn: String = "aciol"
                 var sulcusIolColumn: String = "sulcusIol"
                 var suturedColumn: String = "sutured"
                 var suturelessColumn: String = "sutureless"
                 var pplWithFragColumn: String = "pplWithFrag"
                 var pplWithoutFragColumn: String = "pplWithoutFrag"
                 var tamponade2Column: String = "tamponade2"
                 var commentsColumn: String = "comments"
                 var percentageTamponadeColumn : String = "percentageTamponade"
                 var otherFieldTamponadeColumn : String = "otherFieldTamponade"
                 var otherFieldSurgery2Column : String = "otherField2"
                 var virectomyColumn : String = "virectomy"
                 var scleralBuckleColumn : String = "scleralBuckle"
                 var iolInsertionColumn : String = "iolInsertion"
                 var iolNameColumn : String = "iolName"
                 var iolPowerColumn : String = "IolPower"
                 var positioningColumn : String = "positioning"
                 var retinalDetachmentColumn : String = "retinalDetachment"
                 var macularHoleClosedColumn : String = "macularHoleClosed"
                 var pomVisualAcuityColumn: String = "pomVisualAcuity"
                 var pom3VisualAcuityColumn: String = "pom3VisualAcuity"
                 var otherOutcomeDataColumn : String = "otherOutcomeData"
                 var siliconeOilRemovalColumn : String = "siliconeOilRemoval"
                 var siliconeOilExchangeColumn : String = "siliconeOilExchange"
                 var corodialDrainageColumn : String = "corodialDrainage"
                 let iolRepositionColumn : String = "iolReposition"
                 let cptCodeDropdownColumn : String = "cptCodeDropdown"
                 let cptFreeTextBoxColumn : String = "cptFreeTextBox"
                 let cryotherapyColumn : String = "cryotherapy"
                 let ilmDropDownColumn : String = "ilmDropDown"
                 let radialElementColumn : String = "radialElement"
                let fellowInvolvementPercentageColumn : String = "fellowInvolvementPercentage"
                let retinalDefectColumn: String = "retinalDefect"
                do {
                    
                    print(database)
                    
                    let results = try! database.executeQuery(query, values : nil )
                    fetchStatus = true
                    print("patient details fetched during search" ,fetchStatus)

         
                    while (results.next()) {
                        print("while loop entered")
                        
                        let patientCsvDataExportModel = CsvExportDataModel(lastName: results.string(forColumn: lastNameColumn),
                                                                           firstname: results.string(forColumn: firstnameColumn),
                          
                                                                           dob: results.string(forColumn: dobColumn)
                            , mrn: results.string(forColumn: mrnColumn),
                              eye: results.string(forColumn: eyeColumn)
                              ,fellowInvolvement: results.string(forColumn: fellowInvolvementColumn), level: results.string(forColumn: levelColumn), surgerySetting: results.string(forColumn: surgerySettingColumn), hospitalName: results.string(forColumn: hospitalNameColumn), date: results.string(forColumn: dateColumn), aphakia: results.string(forColumn: aphakiaColumn), cataract: results.string(forColumn: cataractColumn), choroidalEffusion: results.string(forColumn: choroidalEffusionColumn), choroidalHemorrhage: results.string(forColumn: choroidalHemorrhageColumn), diabeticTrd: results.string(forColumn: diabeticTrdColumn), dislocatedIntraocularLens: results.string(forColumn: dislocatedIntraocularLensColumn), endophthalmitis: results.string(forColumn: endophthalmitisColumn), epiretinalMembrane: results.string(forColumn: epiretinalMembraneColumn),
                              fevr: results.string(forColumn: fevrColumn),
                              floaters: results.string(forColumn: floatersColumn),
                              fullThicknessMacularHole: results.string(forColumn: fullThicknessMacularHoleColumn),
                              intraocularForeignBody: results.string(forColumn: intraocularForeignBodyColumn),
                              lamellarMacularHole: results.string(forColumn: lamellarMacularHoleColumn),
                             latticeDegeneration: results.string(forColumn: latticeDegenerationColumn),
                             pdr: results.string(forColumn: pdrColumn),
                             primaryRdWithPvr: results.string(forColumn: primaryRdWithPvrColumn),
                             recurrentRdWithPvr: results.string(forColumn: recurrentRdWithPvrColumn),
                             recurrentRdWithOutPvr: results.string(forColumn: recurrentRdWithOutPvrColumn),
                             retainedLensFragments: results.string(forColumn: retainedLensFragmentsColumn), retinalTear: results.string(forColumn: retinalTearColumn),
                             retinalVeinOcclusion: results.string(forColumn: retinalVeinOcclusionColumn), rhegmatogenousRdMaculaOff: results.string(forColumn: rhegmatogenousRdMaculaOffColumn),
                             rhegmatogenousRdMaculaOn: results.string(forColumn: rhegmatogenousRdMaculaOnColumn) , rop: results.string(forColumn: ropColumn)!, sickleCell: results.string(forColumn: sickleCellColumn), spRdRepairWithSiliconeOil: results.string(forColumn: spRdRepairWithSiliconeOilColumn), subluxedCrystallineLens: results.string(forColumn: subluxedCrystallineLensColumn), vitreousHemorrhage: results.string(forColumn: vitreousHemorrhageColumn), otherField: results.string(forColumn: otherFieldColumn),otherField2 : results.string(forColumn: otherField2Column) , otherField3 : results.string(forColumn: otherField3Column), otherField4 : results.string(forColumn: otherField4Column) , gauge: results.string(forColumn: gaugeColumn), band: results.string(forColumn: bandColumn), sleeve: results.string(forColumn: sleeveColumn), tamponad1: results.string(forColumn: tamponad1Column), srfDrain: results.string(forColumn: srfDrainColumn), acTap: results.string(forColumn: acTapColumn), radialElement: results.string(forColumn: radialElementColumn) , membranePeel: results.string(forColumn: membranePeelColumn), ilmPeel: results.string(forColumn: ilmPeelColumn), retinectomy: results.string(forColumn: retinectomyColumn), fluidAirExchange: results.string(forColumn: fluidAirExchangeColumn), pfo: results.string(forColumn: pfoColumn), focalEndolaser: results.string(forColumn: focalEndolaserColumn), prpLaser: results.string(forColumn: prpLaserColumn), indirectLaserTear: results.string(forColumn: indirectLaserTearColumn), iolExchange: results.string(forColumn: iolExchangeColumn), aciol: results.string(forColumn: aciolColumn), sulcusIol: results.string(forColumn: sulcusIolColumn), sutured: results.string(forColumn: suturedColumn), sutureless: results.string(forColumn: suturelessColumn), pplWithFrag: results.string(forColumn: pplWithFragColumn), pplWithoutFrag: results.string(forColumn: pplWithoutFragColumn), tamponade2: results.string(forColumn: tamponade2Column),percentageTamponade: results.string(forColumn: percentageTamponadeColumn)  ,
                             otherFieldTamponade: results.string(forColumn: otherFieldTamponadeColumn) ,comments: results.string(forColumn: commentsColumn)  ,
                             otherField2Surgery: results.string(forColumn: otherFieldSurgery2Column),
                             virectomy: results.string(forColumn: virectomyColumn),
                             scleralBuckle: results.string(forColumn: scleralBuckleColumn),
                             iolInsertion: results.string(forColumn: iolInsertionColumn), siliconeOilRemoval: results.string(forColumn: siliconeOilRemovalColumn) , siliconeOilExchange: results.string(forColumn: siliconeOilExchangeColumn),corodialDrainage: results.string(forColumn: corodialDrainageColumn), iolReposition: results.string(forColumn: iolRepositionColumn),cptCodeDropdown: results.string(forColumn: cptCodeDropdownColumn), cptFreeTextBox: results.string(forColumn: cptFreeTextBoxColumn) , cryotherapy: results.string(forColumn: cryotherapyColumn),ilmCodeDropdown:  results.string(forColumn: ilmDropDownColumn) ,
                             iolName : results.string(forColumn: iolNameColumn),
                             iolPower: results.string(forColumn: iolPowerColumn ) , positioning: results.string(forColumn: positioningColumn ),
                             
                                  retinalDetachment: results.string(forColumn: retinalDetachmentColumn) , macularHoleClosed: results.string(forColumn: macularHoleClosedColumn) ,
                                                                           pomVisualAcuity: results.string(forColumn: pomVisualAcuityColumn) , pom3VisualAcuity: results.string(forColumn: pom3VisualAcuityColumn),otherOutcomeData: results.string(forColumn: otherOutcomeDataColumn ) ,fellowInvolvementPercentage: results.string(forColumn: fellowInvolvementPercentageColumn),retinalDefect: results.string(forColumn: retinalDefectColumn)
                                  
                             
                             
                             )
                        
                     
                       if patientCsvDataExportModelList  == nil {
                                                                           patientCsvDataExportModelList = [CsvExportDataModel]()
                                                                       }
                                     
                        patientCsvDataExportModelList.append(patientCsvDataExportModel)
                        
                              }
                    
                    print("details of patient list in dbManger", patientCsvDataExportModelList)
                
                }
                catch {
                    print(error.localizedDescription)
                }
                
            }
           return patientCsvDataExportModelList
        }
    
    // function get patient details for Export on the basis of type od Surgery
    func loadPatientDetailsForExportBySurgery(withID surgeryType1 : String , surgeryType2 : String , surgeryType3 : String ,  surgeryStatus : String , queryStatus : Int ) -> [CsvExportDataModel]! {
               var patientCsvDataExportModelList: [CsvExportDataModel]!
               var fetchStatus: Bool = false
               var query = ""
            print("variables " ,surgeryType1 , surgeryType2 , surgeryType3 )
               if openDatabase() {
                   
                print("queryStatus" , queryStatus)
                    // to print the string
                  
                   let query1 = "select lastName, firstname, dob, mrn, eye, fellowInvolvement, level, surgerySetting, hospitalName,date, aphakia, cataract, choroidalEffusion, choroidalHemorrhage, diabeticTrd, dislocatedIntraocularLens, endophthalmitis, epiretinalMembrane, fevr, floaters, fullThicknessMacularHole, intraocularForeignBody, lamellarMacularHole, latticeDegeneration, pdr, primaryRdWithPvr, recurrentRdWithPvr, recurrentRdWithOutPvr, retainedLensFragments, retinalTear, retinalVeinOcclusion, rhegmatogenousRdMaculaOff, rhegmatogenousRdMaculaOn, rop, sickleCell, spRdRepairWithSiliconeOil, subluxedCrystallineLens, vitreousHemorrhage,otherField, otherField2 ,otherField3, otherField4,gauge, band, sleeve, tamponad1, srfDrain, acTap, radialElement ,membranePeel, ilmPeel, retinectomy, fluidAirExchange, pfo, focalEndolaser, prpLaser, indirectLaserTear, iolExchange, aciol, sulcusIol, sutured, sutureless, pplWithFrag, pplWithoutFrag, tamponade2, comments , percentageTamponade , otherFieldTamponade, otherField2, virectomy, scleralBuckle , iolInsertion , iolName , iolPower , positioning ,siliconeOilRemoval, siliconeOilExchange , corodialDrainage , iolReposition, cptCodeDropdown,cptFreeTextBox,cryotherapy ,ilmDropDown , macularHoleClosed ,pomVisualAcuity , pom3VisualAcuity ,  otherOutcomeData , retinalDetachment , fellowInvolvementPercentage , retinalDefect from Demographics1 D1 inner join  Demographics2 D2 on   D1.personIdDemo1 = D2.personIdfromDemo1 inner join Surgery S  on  D1.personIdDemo1 = S.personIdfromDemo1 where  S.\(surgeryType1) = '\(surgeryStatus)'  and D1.status = 1 "
                
                 let query2 = "select lastName, firstname, dob, mrn, eye, fellowInvolvement, level, surgerySetting, hospitalName,date, aphakia, cataract, choroidalEffusion, choroidalHemorrhage, diabeticTrd, dislocatedIntraocularLens, endophthalmitis, epiretinalMembrane, fevr, floaters, fullThicknessMacularHole, intraocularForeignBody, lamellarMacularHole, latticeDegeneration, pdr, primaryRdWithPvr, recurrentRdWithPvr, recurrentRdWithOutPvr, retainedLensFragments, retinalTear, retinalVeinOcclusion, rhegmatogenousRdMaculaOff, rhegmatogenousRdMaculaOn, rop, sickleCell, spRdRepairWithSiliconeOil, subluxedCrystallineLens, vitreousHemorrhage,otherField, otherField2 ,otherField3, otherField4,gauge, band, sleeve, tamponad1, srfDrain, acTap, radialElement ,membranePeel, ilmPeel, retinectomy, fluidAirExchange, pfo, focalEndolaser, prpLaser, indirectLaserTear, iolExchange, aciol, sulcusIol, sutured, sutureless, pplWithFrag, pplWithoutFrag, tamponade2, comments , percentageTamponade , otherFieldTamponade, otherField2, virectomy, scleralBuckle , iolInsertion , iolName , iolPower , positioning ,siliconeOilRemoval, siliconeOilExchange , corodialDrainage, iolReposition, cptCodeDropdown,cptFreeTextBox,cryotherapy , ilmDropDown , macularHoleClosed ,  pomVisualAcuity , pom3VisualAcuity ,  otherOutcomeData , retinalDetachment , fellowInvolvementPercentage , retinalDefect from Demographics1 D1 inner join  Demographics2 D2 on   D1.personIdDemo1 = D2.personIdfromDemo1 inner join Surgery S  on  D1.personIdDemo1 = S.personIdfromDemo1 where ( S.\(surgeryType1) = '\(surgeryStatus)'  OR S.\(surgeryType2) = '\(surgeryStatus)'  ) and D1.status = 1 "
                
                
                 let query3 = "select lastName, firstname, dob, mrn, eye, fellowInvolvement, level, surgerySetting, hospitalName,date, aphakia, cataract, choroidalEffusion, choroidalHemorrhage, diabeticTrd, dislocatedIntraocularLens, endophthalmitis, epiretinalMembrane, fevr, floaters, fullThicknessMacularHole, intraocularForeignBody, lamellarMacularHole, latticeDegeneration, pdr, primaryRdWithPvr, recurrentRdWithPvr, recurrentRdWithOutPvr, retainedLensFragments, retinalTear, retinalVeinOcclusion, rhegmatogenousRdMaculaOff, rhegmatogenousRdMaculaOn, rop, sickleCell, spRdRepairWithSiliconeOil, subluxedCrystallineLens, vitreousHemorrhage,otherField, otherField2 ,otherField3, otherField4,gauge, band, sleeve, tamponad1, srfDrain, acTap, radialElement ,membranePeel, ilmPeel, retinectomy, fluidAirExchange, pfo, focalEndolaser, prpLaser, indirectLaserTear, iolExchange, aciol, sulcusIol, sutured, sutureless, pplWithFrag, pplWithoutFrag, tamponade2, comments , percentageTamponade , otherFieldTamponade, otherField2, virectomy, scleralBuckle , iolInsertion , iolName , iolPower , positioning ,siliconeOilRemoval, siliconeOilExchange , corodialDrainage, iolReposition, cptCodeDropdown,cptFreeTextBox,cryotherapy ,ilmDropDown , macularHoleClosed , pomVisualAcuity , pom3VisualAcuity ,  otherOutcomeData , retinalDetachment , fellowInvolvementPercentage , retinalDefect from Demographics1 D1 inner join  Demographics2 D2 on   D1.personIdDemo1 = D2.personIdfromDemo1 inner join Surgery S  on  D1.personIdDemo1 = S.personIdfromDemo1 where (( S.\(surgeryType1) = '\(surgeryStatus)'  OR S.\(surgeryType2) = '\(surgeryStatus)'  )   OR S.\(surgeryType3) = '\(surgeryStatus)' ) and D1.status = 1 "
                
                
                if queryStatus == 1 {
                    query = query1
                }
                else if queryStatus == 2 {
                     query = query2
                }
                else {
                      query = query3
                }
                
                
             
                
                   
                    var lastNameColumn: String = "lastName"
                    var firstnameColumn: String = "firstname"
                    var dobColumn: String = "dob"
                    var mrnColumn: String = "mrn"
                    var eyeColumn: String = "eye"
                    var fellowInvolvementColumn: String = "fellowInvolvement"
                    var levelColumn: String = "level"
                    var surgerySettingColumn: String = "surgerySetting"
                    var hospitalNameColumn: String = "hospitalName"
                    var dateColumn: String = "date"
                    var aphakiaColumn: String = "aphakia"
                    var cataractColumn: String = "cataract"
                    var choroidalEffusionColumn: String = "choroidalEffusion"
                    var choroidalHemorrhageColumn: String = "choroidalEffusion"
                    var diabeticTrdColumn: String = "diabeticTrd"
                    var dislocatedIntraocularLensColumn: String = "dislocatedIntraocularLens"
                    var endophthalmitisColumn: String = "endophthalmitis"
                    var epiretinalMembraneColumn: String = "epiretinalMembrane"
                    var fevrColumn: String = "fevr"
                    var floatersColumn: String  = "floaters"
                    var fullThicknessMacularHoleColumn:  String  = "fullThicknessMacularHole"
                    var intraocularForeignBodyColumn: String = "intraocularForeignBody"
                    var lamellarMacularHoleColumn: String  = "lamellarMacularHole"
                    var latticeDegenerationColumn: String = "latticeDegeneration"
                    var pdrColumn: String = "pdr"
                    var primaryRdWithPvrColumn: String = "primaryRdWithPvr"
                    var recurrentRdWithPvrColumn: String = "recurrentRdWithPvr"
                    var recurrentRdWithOutPvrColumn: String = "recurrentRdWithOutPvr"
                    var retainedLensFragmentsColumn: String  = "retainedLensFragments"
                    var retinalTearColumn: String = "retinalTear"
                    var retinalVeinOcclusionColumn: String = "retinalVeinOcclusion"
                    var rhegmatogenousRdMaculaOffColumn: String = "rhegmatogenousRdMaculaOff"
                    var rhegmatogenousRdMaculaOnColumn: String = "rhegmatogenousRdMaculaOn"
                    var ropColumn: String = "rop"
                    var sickleCellColumn: String = "sickleCell"
                    var spRdRepairWithSiliconeOilColumn: String = "spRdRepairWithSiliconeOil"
                    var subluxedCrystallineLensColumn: String = "subluxedCrystallineLens"
                    var vitreousHemorrhageColumn: String = "vitreousHemorrhage"
                    var otherFieldColumn: String = "otherField"
                    var otherField2Column: String = "otherField2"
                    var otherField3Column: String = "otherField3"
                    var otherField4Column: String = "otherField4"
                    var gaugeColumn: String = "gauge"
                    var bandColumn: String = "band"
                    var sleeveColumn: String = "sleeve"
                    var tamponad1Column: String = "tamponad1"
                    var srfDrainColumn: String = "srfDrain"
                    var acTapColumn: String = "acTap"
                    var membranePeelColumn: String = "membranePeel"
                    var ilmPeelColumn: String = "ilmPeel"
                    var retinectomyColumn: String = "retinectomy"
                    var fluidAirExchangeColumn: String = "fluidAirExchange"
                    var pfoColumn: String = "pfo"
                    var focalEndolaserColumn: String = "focalEndolaser"
                    var prpLaserColumn:String = "prpLaser"
                    var indirectLaserTearColumn: String = "indirectLaserTear"
                    var iolExchangeColumn: String = "iolExchange"
                    var aciolColumn: String = "aciol"
                    var sulcusIolColumn: String = "sulcusIol"
                    var suturedColumn: String = "sutured"
                    var suturelessColumn: String = "sutureless"
                    var pplWithFragColumn: String = "pplWithFrag"
                    var pplWithoutFragColumn: String = "pplWithoutFrag"
                    var tamponade2Column: String = "tamponade2"
                    var commentsColumn: String = "comments"
                    var percentageTamponadeColumn : String = "percentageTamponade"
                    var otherFieldTamponadeColumn : String = "otherFieldTamponade"
                //
                var otherFieldSurgery2Column : String = "otherField2"
                var virectomyColumn : String = "virectomy"
                var scleralBuckleColumn : String = "scleralBuckle"
                var iolInsertionColumn : String = "iolInsertion"
                var iolNameColumn : String = "iolName"
                var iolPowerColumn : String = "IolPower"
                var positioningColumn : String = "positioning"
                //
                    var retinalDetachmentColumn : String = "retinalDetachment"
                    var macularHoleClosedColumn : String = "macularHoleClosed"
                    var pomVisualAcuityColumn: String = "pomVisualAcuity"
                    var pom3VisualAcuityColumn: String = "pom3VisualAcuity"
                    var otherOutcomeDataColumn : String = "otherOutcomeData"
                    var siliconeOilRemovalColumn : String = "siliconeOilRemoval"
                    var siliconeOilExchangeColumn : String = "siliconeOilExchange"
                    var corodialDrainageColumn : String = "corodialDrainage"
                    //
                    let iolRepositionColumn : String = "iolReposition"
                    let cptCodeDropdownColumn : String = "cptCodeDropdown"
                    let cptFreeTextBoxColumn : String = "cptFreeTextBox"
                    let cryotherapyColumn : String = "cryotherapy"
                    let ilmDropDownColumn : String = "ilmDropDown"
                    let radialElementColumn : String = "radialElement"
                   let fellowInvolvementPercentageColumn : String = "fellowInvolvementPercentage"
                   let retinalDefectColumn : String = "retinalDefect"
                   do {
                       
                       print(database)
                       
                       let results = try! database.executeQuery(query, values : nil )
                       fetchStatus = true
                       print("patient details fetched during search" ,fetchStatus)

            
                       while (results.next()) {
                           print("while loop entered")
                           
                           let patientCsvDataExportModel = CsvExportDataModel(lastName: results.string(forColumn: lastNameColumn),
                                                                              firstname: results.string(forColumn: firstnameColumn),
                             
                                                                              dob: results.string(forColumn: dobColumn)
                               , mrn: results.string(forColumn: mrnColumn),
                                 eye: results.string(forColumn: eyeColumn)
                                 ,fellowInvolvement: results.string(forColumn: fellowInvolvementColumn), level: results.string(forColumn: levelColumn), surgerySetting: results.string(forColumn: surgerySettingColumn), hospitalName: results.string(forColumn: hospitalNameColumn), date: results.string(forColumn: dateColumn), aphakia: results.string(forColumn: aphakiaColumn), cataract: results.string(forColumn: cataractColumn), choroidalEffusion: results.string(forColumn: choroidalEffusionColumn), choroidalHemorrhage: results.string(forColumn: choroidalHemorrhageColumn), diabeticTrd: results.string(forColumn: diabeticTrdColumn), dislocatedIntraocularLens: results.string(forColumn: dislocatedIntraocularLensColumn), endophthalmitis: results.string(forColumn: endophthalmitisColumn), epiretinalMembrane: results.string(forColumn: epiretinalMembraneColumn),
                                 fevr: results.string(forColumn: fevrColumn),
                                 floaters: results.string(forColumn: floatersColumn),
                                 fullThicknessMacularHole: results.string(forColumn: fullThicknessMacularHoleColumn),
                                 intraocularForeignBody: results.string(forColumn: intraocularForeignBodyColumn),
                                 lamellarMacularHole: results.string(forColumn: lamellarMacularHoleColumn),
                                latticeDegeneration: results.string(forColumn: latticeDegenerationColumn),
                                pdr: results.string(forColumn: pdrColumn),
                                primaryRdWithPvr: results.string(forColumn: primaryRdWithPvrColumn),
                                recurrentRdWithPvr: results.string(forColumn: recurrentRdWithPvrColumn),
                                recurrentRdWithOutPvr: results.string(forColumn: recurrentRdWithOutPvrColumn),
                                retainedLensFragments: results.string(forColumn: retainedLensFragmentsColumn), retinalTear: results.string(forColumn: retinalTearColumn),
                                retinalVeinOcclusion: results.string(forColumn: retinalVeinOcclusionColumn), rhegmatogenousRdMaculaOff: results.string(forColumn: rhegmatogenousRdMaculaOffColumn),
                                rhegmatogenousRdMaculaOn: results.string(forColumn: rhegmatogenousRdMaculaOnColumn) , rop: results.string(forColumn: ropColumn)!, sickleCell: results.string(forColumn: sickleCellColumn), spRdRepairWithSiliconeOil: results.string(forColumn: spRdRepairWithSiliconeOilColumn), subluxedCrystallineLens: results.string(forColumn: subluxedCrystallineLensColumn), vitreousHemorrhage: results.string(forColumn: vitreousHemorrhageColumn), otherField: results.string(forColumn: otherFieldColumn),otherField2 : results.string(forColumn: otherField2Column) , otherField3 : results.string(forColumn: otherField3Column), otherField4 : results.string(forColumn: otherField4Column) , gauge: results.string(forColumn: gaugeColumn), band: results.string(forColumn: bandColumn), sleeve: results.string(forColumn: sleeveColumn), tamponad1: results.string(forColumn: tamponad1Column), srfDrain: results.string(forColumn: srfDrainColumn), acTap: results.string(forColumn: acTapColumn), radialElement: results.string(forColumn: radialElementColumn), membranePeel: results.string(forColumn: membranePeelColumn), ilmPeel: results.string(forColumn: ilmPeelColumn), retinectomy: results.string(forColumn: retinectomyColumn), fluidAirExchange: results.string(forColumn: fluidAirExchangeColumn), pfo: results.string(forColumn: pfoColumn), focalEndolaser: results.string(forColumn: focalEndolaserColumn), prpLaser: results.string(forColumn: prpLaserColumn), indirectLaserTear: results.string(forColumn: indirectLaserTearColumn), iolExchange: results.string(forColumn: iolExchangeColumn), aciol: results.string(forColumn: aciolColumn), sulcusIol: results.string(forColumn: sulcusIolColumn), sutured: results.string(forColumn: suturedColumn), sutureless: results.string(forColumn: suturelessColumn), pplWithFrag: results.string(forColumn: pplWithFragColumn), pplWithoutFrag: results.string(forColumn: pplWithoutFragColumn), tamponade2: results.string(forColumn: tamponade2Column),percentageTamponade: results.string(forColumn: percentageTamponadeColumn)  ,
                                otherFieldTamponade: results.string(forColumn: otherFieldTamponadeColumn) ,comments: results.string(forColumn: commentsColumn),
                                otherField2Surgery: results.string(forColumn: otherFieldSurgery2Column),
                                virectomy: results.string(forColumn: virectomyColumn),
                                scleralBuckle: results.string(forColumn: scleralBuckleColumn),
                                iolInsertion: results.string(forColumn: iolInsertionColumn), siliconeOilRemoval: results.string(forColumn: siliconeOilRemovalColumn) , siliconeOilExchange: results.string(forColumn: siliconeOilExchangeColumn),corodialDrainage: results.string(forColumn: corodialDrainageColumn),  iolReposition: results.string(forColumn: iolRepositionColumn),cptCodeDropdown: results.string(forColumn: cptCodeDropdownColumn), cptFreeTextBox: results.string(forColumn: cptFreeTextBoxColumn) , cryotherapy: results.string(forColumn: cryotherapyColumn),  ilmCodeDropdown: results.string(forColumn: ilmDropDownColumn),
                                    iolName : results.string(forColumn: iolNameColumn),
                                   iolPower: results.string(forColumn: iolPowerColumn)  , positioning: results.string(forColumn: positioningColumn ),
                                     retinalDetachment: results.string(forColumn: retinalDetachmentColumn) , macularHoleClosed: results.string(forColumn: macularHoleClosedColumn) ,
                                                                              pomVisualAcuity: results.string(forColumn: pomVisualAcuityColumn) , pom3VisualAcuity: results.string(forColumn: pom3VisualAcuityColumn) ,otherOutcomeData: results.string(forColumn: otherOutcomeDataColumn) , fellowInvolvementPercentage: results.string(forColumn: fellowInvolvementPercentageColumn) , retinalDefect: results.string(forColumn: retinalDefectColumn) )
                        
                          if patientCsvDataExportModelList  == nil {
                                                                              patientCsvDataExportModelList = [CsvExportDataModel]()
                                                                          }
                                        
                           patientCsvDataExportModelList.append(patientCsvDataExportModel)
                           
                                 }
                       
                       print("details of patient list in dbManger", patientCsvDataExportModelList)
                   
                   }
                   catch {
                       print(error.localizedDescription)
                   }
                   
               }
              return patientCsvDataExportModelList
           }
    
    
    
    // function get patient details for Export on the basis of type of Diagnosis
    func loadPatientDetailsForExportByDiagnosis(withID diagnosisType1 : String , diagnosisType2 : String , diagnosisType3 : String ,  diagnosisStatus : String , queryStatus : Int) -> [CsvExportDataModel]! {
                  var patientCsvDataExportModelList: [CsvExportDataModel]!
                  var fetchStatus: Bool = false
                  var query = ""
        
        print( "variables" , diagnosisType1 , diagnosisType2 , diagnosisType3)
               
                  if openDatabase() {
                      
                     print("diagnosis type" ,  diagnosisType1 , diagnosisType2 , diagnosisType3)
                     print("Query Status " , queryStatus)
                     // Query 1
                       let query1 = "select lastName, firstname, dob, mrn, eye, fellowInvolvement, level, surgerySetting, hospitalName,date, aphakia, cataract, choroidalEffusion, choroidalHemorrhage, diabeticTrd, dislocatedIntraocularLens, endophthalmitis, epiretinalMembrane, fevr, floaters, fullThicknessMacularHole, intraocularForeignBody, lamellarMacularHole, latticeDegeneration, pdr, primaryRdWithPvr, recurrentRdWithPvr, recurrentRdWithOutPvr, retainedLensFragments, retinalTear, retinalVeinOcclusion, rhegmatogenousRdMaculaOff, rhegmatogenousRdMaculaOn, rop, sickleCell, spRdRepairWithSiliconeOil, subluxedCrystallineLens, vitreousHemorrhage,otherField, otherField2 ,otherField3, otherField4,gauge, band, sleeve, tamponad1, srfDrain, acTap, radialElement, membranePeel, ilmPeel, retinectomy, fluidAirExchange, pfo, focalEndolaser, prpLaser, indirectLaserTear, iolExchange, aciol, sulcusIol, sutured, sutureless, pplWithFrag, pplWithoutFrag, tamponade2, comments , percentageTamponade , otherFieldTamponade, otherField2, virectomy, scleralBuckle , iolInsertion , iolName , iolPower , positioning  ,siliconeOilRemoval, siliconeOilExchange, corodialDrainage,  iolReposition, cptCodeDropdown,cptFreeTextBox,cryotherapy , ilmDropDown , macularHoleClosed ,  pomVisualAcuity , pom3VisualAcuity ,  otherOutcomeData ,retinalDetachment , fellowInvolvementPercentage ,retinalDefect from Demographics1 D1 inner join  Demographics2 D2 on   D1.personIdDemo1 = D2.personIdfromDemo1 inner join Surgery S  on  D1.personIdDemo1 = S.personIdfromDemo1 where  D2.\(diagnosisType1) = '\(diagnosisStatus)'  and D1.status = 1 "
                    
                    
                     // Query 2
                    let query2 = "select lastName, firstname, dob, mrn, eye, fellowInvolvement, level, surgerySetting, hospitalName,date, aphakia, cataract, choroidalEffusion, choroidalHemorrhage, diabeticTrd, dislocatedIntraocularLens, endophthalmitis, epiretinalMembrane, fevr, floaters, fullThicknessMacularHole, intraocularForeignBody, lamellarMacularHole, latticeDegeneration, pdr, primaryRdWithPvr, recurrentRdWithPvr, recurrentRdWithOutPvr, retainedLensFragments, retinalTear, retinalVeinOcclusion, rhegmatogenousRdMaculaOff, rhegmatogenousRdMaculaOn, rop, sickleCell, spRdRepairWithSiliconeOil, subluxedCrystallineLens, vitreousHemorrhage,otherField, otherField2 ,otherField3, otherField4,gauge, band, sleeve, tamponad1, srfDrain, acTap, radialElement ,membranePeel, ilmPeel, retinectomy, fluidAirExchange, pfo, focalEndolaser, prpLaser, indirectLaserTear, iolExchange, aciol, sulcusIol, sutured, sutureless, pplWithFrag, pplWithoutFrag, tamponade2, comments , percentageTamponade , otherFieldTamponade, otherField2, virectomy, scleralBuckle , iolInsertion , iolName , iolPower , positioning ,siliconeOilRemoval, siliconeOilExchange , corodialDrainage, macularHoleClosed ,  iolReposition, cptCodeDropdown,cptFreeTextBox,cryotherapy , ilmDropDown, pomVisualAcuity , pom3VisualAcuity ,  otherOutcomeData, retinalDetachment , fellowInvolvementPercentage , retinalDefect from Demographics1 D1 inner join  Demographics2 D2 on   D1.personIdDemo1 = D2.personIdfromDemo1 inner join Surgery S  on  D1.personIdDemo1 = S.personIdfromDemo1 where ( D2.\(diagnosisType1) = '\(diagnosisStatus)'  OR D2.\(diagnosisType2) = '\(diagnosisStatus)'  ) and D1.status = 1 "
                    
                    // Query 3
                     let query3 = "select lastName, firstname, dob, mrn, eye, fellowInvolvement, level, surgerySetting, hospitalName,date, aphakia, cataract, choroidalEffusion, choroidalHemorrhage, diabeticTrd, dislocatedIntraocularLens, endophthalmitis, epiretinalMembrane, fevr, floaters, fullThicknessMacularHole, intraocularForeignBody, lamellarMacularHole, latticeDegeneration, pdr, primaryRdWithPvr, recurrentRdWithPvr, recurrentRdWithOutPvr, retainedLensFragments, retinalTear, retinalVeinOcclusion, rhegmatogenousRdMaculaOff, rhegmatogenousRdMaculaOn, rop, sickleCell, spRdRepairWithSiliconeOil, subluxedCrystallineLens, vitreousHemorrhage,otherField, otherField2 ,otherField3, otherField4,gauge, band, sleeve, tamponad1, srfDrain, acTap, radialElement ,membranePeel, ilmPeel, retinectomy, fluidAirExchange, pfo, focalEndolaser, prpLaser, indirectLaserTear, iolExchange, aciol, sulcusIol, sutured, sutureless, pplWithFrag, pplWithoutFrag, tamponade2, comments , percentageTamponade , otherFieldTamponade, otherField2, virectomy, scleralBuckle , iolInsertion , iolName , iolPower , positioning ,siliconeOilRemoval, siliconeOilExchange , corodialDrainage ,  iolReposition, cptCodeDropdown,cptFreeTextBox,cryotherapy , ilmDropDown , macularHoleClosed ,  pomVisualAcuity , pom3VisualAcuity ,  otherOutcomeData ,retinalDetachment , fellowInvolvementPercentage , retinalDefect from Demographics1 D1 inner join  Demographics2 D2 on   D1.personIdDemo1 = D2.personIdfromDemo1 inner join Surgery S  on  D1.personIdDemo1 = S.personIdfromDemo1 where (( D2.\(diagnosisType1) = '\(diagnosisStatus)'  OR D2.\(diagnosisType2) = '\(diagnosisStatus)'  )   OR D2.\(diagnosisType3) = '\(diagnosisStatus)' ) and D1.status = 1 "
                    
                    
                    if queryStatus == 1 {
                                                     query = query1
                                                 }
                                                 else if queryStatus == 2 {
                                                      query = query2
                                                 }
                                                 else {
                                                       query = query3
                                                 }
                    
                    
                       var lastNameColumn: String = "lastName"
                       var firstnameColumn: String = "firstname"
                       var dobColumn: String = "dob"
                       var mrnColumn: String = "mrn"
                       var eyeColumn: String = "eye"
                       var fellowInvolvementColumn: String = "fellowInvolvement"
                       var levelColumn: String = "level"
                       var surgerySettingColumn: String = "surgerySetting"
                       var hospitalNameColumn: String = "hospitalName"
                       var dateColumn: String = "date"
                       var aphakiaColumn: String = "aphakia"
                       var cataractColumn: String = "cataract"
                       var choroidalEffusionColumn: String = "choroidalEffusion"
                       var choroidalHemorrhageColumn: String = "choroidalEffusion"
                       var diabeticTrdColumn: String = "diabeticTrd"
                       var dislocatedIntraocularLensColumn: String = "dislocatedIntraocularLens"
                       var endophthalmitisColumn: String = "endophthalmitis"
                       var epiretinalMembraneColumn: String = "epiretinalMembrane"
                       var fevrColumn: String = "fevr"
                       var floatersColumn: String  = "floaters"
                       var fullThicknessMacularHoleColumn:  String  = "fullThicknessMacularHole"
                       var intraocularForeignBodyColumn: String = "intraocularForeignBody"
                       var lamellarMacularHoleColumn: String  = "lamellarMacularHole"
                       var latticeDegenerationColumn: String = "latticeDegeneration"
                       var pdrColumn: String = "pdr"
                       var primaryRdWithPvrColumn: String = "primaryRdWithPvr"
                       var recurrentRdWithPvrColumn: String = "recurrentRdWithPvr"
                       var recurrentRdWithOutPvrColumn: String = "recurrentRdWithOutPvr"
                       var retainedLensFragmentsColumn: String  = "retainedLensFragments"
                       var retinalTearColumn: String = "retinalTear"
                       var retinalVeinOcclusionColumn: String = "retinalVeinOcclusion"
                       var rhegmatogenousRdMaculaOffColumn: String = "rhegmatogenousRdMaculaOff"
                       var rhegmatogenousRdMaculaOnColumn: String = "rhegmatogenousRdMaculaOn"
                       var ropColumn: String = "rop"
                       var sickleCellColumn: String = "sickleCell"
                       var spRdRepairWithSiliconeOilColumn: String = "spRdRepairWithSiliconeOil"
                       var subluxedCrystallineLensColumn: String = "subluxedCrystallineLens"
                       var vitreousHemorrhageColumn: String = "vitreousHemorrhage"
                       var otherFieldColumn: String = "otherField"
                       var otherField2Column: String = "otherField2"
                       var otherField3Column: String = "otherField3"
                       var otherField4Column: String = "otherField4"
                       var gaugeColumn: String = "gauge"
                       var bandColumn: String = "band"
                       var sleeveColumn: String = "sleeve"
                       var tamponad1Column: String = "tamponad1"
                       var srfDrainColumn: String = "srfDrain"
                       var acTapColumn: String = "acTap"
                       var membranePeelColumn: String = "membranePeel"
                       var ilmPeelColumn: String = "ilmPeel"
                       var retinectomyColumn: String = "retinectomy"
                       var fluidAirExchangeColumn: String = "fluidAirExchange"
                       var pfoColumn: String = "pfo"
                       var focalEndolaserColumn: String = "focalEndolaser"
                       var prpLaserColumn:String = "prpLaser"
                       var indirectLaserTearColumn: String = "indirectLaserTear"
                       var iolExchangeColumn: String = "iolExchange"
                       var aciolColumn: String = "aciol"
                       var sulcusIolColumn: String = "sulcusIol"
                       var suturedColumn: String = "sutured"
                       var suturelessColumn: String = "sutureless"
                       var pplWithFragColumn: String = "pplWithFrag"
                       var pplWithoutFragColumn: String = "pplWithoutFrag"
                       var tamponade2Column: String = "tamponade2"
                       var commentsColumn: String = "comments"
                       var percentageTamponadeColumn : String = "percentageTamponade"
                       var otherFieldTamponadeColumn : String = "otherFieldTamponade"
                   //
                   var otherFieldSurgery2Column : String = "otherField2"
                   var virectomyColumn : String = "virectomy"
                   var scleralBuckleColumn : String = "scleralBuckle"
                   var iolInsertionColumn : String = "iolInsertion"
                   var iolNameColumn : String = "iolName"
                   var iolPowerColumn : String = "IolPower"
                   var positioningColumn : String = "positioning"
                   //
                       var retinalDetachmentColumn : String = "retinalDetachment"
                       var macularHoleClosedColumn : String = "macularHoleClosed"
                       var pomVisualAcuityColumn: String = "pomVisualAcuity"
                       var pom3VisualAcuityColumn: String = "pom3VisualAcuity"
                       var otherOutcomeDataColumn : String = "otherOutcomeData"
                       var siliconeOilRemovalColumn : String = "siliconeOilRemoval"
                       var siliconeOilExchangeColumn : String = "siliconeOilExchange"
                    var corodialDrainageColumn : String = "corodialDrainage"
                    //
                                       let iolRepositionColumn : String = "iolReposition"
                                       let cptCodeDropdownColumn : String = "cptCodeDropdown"
                                       let cptFreeTextBoxColumn : String = "cptFreeTextBox"
                                       let cryotherapyColumn : String = "cryotherapy"
                    let ilmDropDownColumn : String = "ilmDropDown"
                    let radialElementColumn : String = "radialElement"
                      let fellowInvolvementPercentageColumn : String = "fellowInvolvementPercentage"
                      let retinalDefectColumn : String = "retinalDefect"
                      
                      do {
                          
                          print(database)
                          
                          let results = try! database.executeQuery(query, values : nil )
                          fetchStatus = true
                          print("patient details fetched during search" ,fetchStatus)

               
                          while (results.next()) {
                              print("while loop entered")
                              
                              let patientCsvDataExportModel = CsvExportDataModel(lastName: results.string(forColumn: lastNameColumn),
                                                                                 firstname: results.string(forColumn: firstnameColumn),
                                
                                                                                 dob: results.string(forColumn: dobColumn)
                                  , mrn: results.string(forColumn: mrnColumn),
                                    eye: results.string(forColumn: eyeColumn)
                                    ,fellowInvolvement: results.string(forColumn: fellowInvolvementColumn), level: results.string(forColumn: levelColumn), surgerySetting: results.string(forColumn: surgerySettingColumn), hospitalName: results.string(forColumn: hospitalNameColumn), date: results.string(forColumn: dateColumn), aphakia: results.string(forColumn: aphakiaColumn), cataract: results.string(forColumn: cataractColumn), choroidalEffusion: results.string(forColumn: choroidalEffusionColumn), choroidalHemorrhage: results.string(forColumn: choroidalHemorrhageColumn), diabeticTrd: results.string(forColumn: diabeticTrdColumn), dislocatedIntraocularLens: results.string(forColumn: dislocatedIntraocularLensColumn), endophthalmitis: results.string(forColumn: endophthalmitisColumn), epiretinalMembrane: results.string(forColumn: epiretinalMembraneColumn),
                                    fevr: results.string(forColumn: fevrColumn),
                                    floaters: results.string(forColumn: floatersColumn),
                                    fullThicknessMacularHole: results.string(forColumn: fullThicknessMacularHoleColumn),
                                    intraocularForeignBody: results.string(forColumn: intraocularForeignBodyColumn),
                                    lamellarMacularHole: results.string(forColumn: lamellarMacularHoleColumn),
                                   latticeDegeneration: results.string(forColumn: latticeDegenerationColumn),
                                   pdr: results.string(forColumn: pdrColumn),
                                   primaryRdWithPvr: results.string(forColumn: primaryRdWithPvrColumn),
                                   recurrentRdWithPvr: results.string(forColumn: recurrentRdWithPvrColumn),
                                   recurrentRdWithOutPvr: results.string(forColumn: recurrentRdWithOutPvrColumn),
                                   retainedLensFragments: results.string(forColumn: retainedLensFragmentsColumn), retinalTear: results.string(forColumn: retinalTearColumn),
                                   retinalVeinOcclusion: results.string(forColumn: retinalVeinOcclusionColumn), rhegmatogenousRdMaculaOff: results.string(forColumn: rhegmatogenousRdMaculaOffColumn),
                                   rhegmatogenousRdMaculaOn: results.string(forColumn: rhegmatogenousRdMaculaOnColumn) , rop: results.string(forColumn: ropColumn)!, sickleCell: results.string(forColumn: sickleCellColumn), spRdRepairWithSiliconeOil: results.string(forColumn: spRdRepairWithSiliconeOilColumn), subluxedCrystallineLens: results.string(forColumn: subluxedCrystallineLensColumn), vitreousHemorrhage: results.string(forColumn: vitreousHemorrhageColumn), otherField: results.string(forColumn: otherFieldColumn),otherField2 : results.string(forColumn: otherField2Column) , otherField3 : results.string(forColumn: otherField3Column), otherField4 : results.string(forColumn: otherField4Column) , gauge: results.string(forColumn: gaugeColumn), band: results.string(forColumn: bandColumn), sleeve: results.string(forColumn: sleeveColumn), tamponad1: results.string(forColumn: tamponad1Column), srfDrain: results.string(forColumn: srfDrainColumn), acTap: results.string(forColumn: acTapColumn), radialElement: results.string(forColumn: radialElementColumn),membranePeel: results.string(forColumn: membranePeelColumn), ilmPeel: results.string(forColumn: ilmPeelColumn), retinectomy: results.string(forColumn: retinectomyColumn), fluidAirExchange: results.string(forColumn: fluidAirExchangeColumn), pfo: results.string(forColumn: pfoColumn), focalEndolaser: results.string(forColumn: focalEndolaserColumn), prpLaser: results.string(forColumn: prpLaserColumn), indirectLaserTear: results.string(forColumn: indirectLaserTearColumn), iolExchange: results.string(forColumn: iolExchangeColumn), aciol: results.string(forColumn: aciolColumn), sulcusIol: results.string(forColumn: sulcusIolColumn), sutured: results.string(forColumn: suturedColumn), sutureless: results.string(forColumn: suturelessColumn), pplWithFrag: results.string(forColumn: pplWithFragColumn), pplWithoutFrag: results.string(forColumn: pplWithoutFragColumn), tamponade2: results.string(forColumn: tamponade2Column),percentageTamponade: results.string(forColumn: percentageTamponadeColumn)  ,
                                   otherFieldTamponade: results.string(forColumn: otherFieldTamponadeColumn) ,comments: results.string(forColumn: commentsColumn),
                                   otherField2Surgery: results.string(forColumn: otherFieldSurgery2Column),
                                   virectomy: results.string(forColumn: virectomyColumn),
                                   scleralBuckle: results.string(forColumn: scleralBuckleColumn),
                                   iolInsertion: results.string(forColumn: iolInsertionColumn),
                                   siliconeOilRemoval: results.string(forColumn: siliconeOilRemovalColumn) , siliconeOilExchange: results.string(forColumn: siliconeOilExchangeColumn) , corodialDrainage: results.string(forColumn: corodialDrainageColumn) ,   iolReposition: results.string(forColumn: iolRepositionColumn),cptCodeDropdown: results.string(forColumn: cptCodeDropdownColumn), cptFreeTextBox: results.string(forColumn: cptFreeTextBoxColumn) , cryotherapy: results.string(forColumn: cryotherapyColumn), ilmCodeDropdown:  results.string(forColumn: ilmDropDownColumn) ,
                                   iolName : results.string(forColumn: iolNameColumn),
                                   iolPower: results.string(forColumn: iolPowerColumn ) , positioning: results.string(forColumn: positioningColumn)
                               ,
                                        retinalDetachment: results.string(forColumn: retinalDetachmentColumn) , macularHoleClosed: results.string(forColumn: macularHoleClosedColumn) ,
                                                                                 pomVisualAcuity: results.string(forColumn: pomVisualAcuityColumn) , pom3VisualAcuity: results.string(forColumn: pom3VisualAcuityColumn) ,otherOutcomeData: results.string(forColumn: otherOutcomeDataColumn) , fellowInvolvementPercentage: results.string(forColumn: fellowInvolvementPercentageColumn),retinalDefect: results.string(forColumn: retinalDefectColumn) )
                           
                             if patientCsvDataExportModelList  == nil {
                                                                                 patientCsvDataExportModelList = [CsvExportDataModel]()
                                                                             }
                                           
                              patientCsvDataExportModelList.append(patientCsvDataExportModel)
                              
                                    }
                          
                          print("details of patient list in dbManger", patientCsvDataExportModelList)
                      
                      }
                      catch {
                          print(error.localizedDescription)
                      }
                      
                  }
                 return patientCsvDataExportModelList
              
    }
      
    
    
    
    
    // For updating outcomes data for Surgery Section
    func UpdateOutcomesDataInSurgeryTable(personid: Int,retinalDetachment: String, macularHoleClosed: String, pomVisualAcuity : String, pom3VisualAcuity: String,
         otherOutcomeData : String  ) -> Bool   {
       
        var created = false
                     
        if openDatabase() {
             
                        let query = "update Surgery set retinalDetachment = '\(retinalDetachment)', macularHoleClosed = '\(macularHoleClosed)', pomVisualAcuity = '\(pomVisualAcuity)', pom3VisualAcuity = '\(pom3VisualAcuity)', otherOutcomeData = '\(otherOutcomeData)'      where personIdfromDemo1 ='\(personid)'"
              
                           
                    
                           do {
                               try database.executeUpdate(query, values: nil)
                               created = true
                           }
                           catch {
                               print(error.localizedDescription)
                           }
                    
                           database.close()
                       }
        return created
                       
        
    }
    
    func UpdateDemographicsDataAfterEditing(demographic1Model : Demographics1Model , id : Int) -> Bool {
        
        var created = false
                                
                   if openDatabase() {
                        
                       let query = "update Demographics1 set lastName = '\(demographic1Model.lastName!)', firstname = '\(demographic1Model.firstName!)' , dob = '\(demographic1Model.dob!)' , mrn = '\(demographic1Model.mrn!)' , eye = '\(demographic1Model.eye!)' ,fellowInvolvement = '\(demographic1Model.fellowInvolvement!)', level = '\(demographic1Model.levelSelect!)' , fellowInvolvementPercentage ='\(demographic1Model.fellowInvolvementPercentage!)' , surgerySetting = '\(demographic1Model.surjurySetting!)' , hospitalName = '\(demographic1Model.hospitalName!)' , date = '\(demographic1Model.date!)' where personIdDemo1 = \(id) and status = 1"
                    
                    
                                      do {
                                          try database.executeUpdate(query, values: nil)
                                          created = true
                                      }
                                      catch {
                                          print(error.localizedDescription)
                                      }
                               
                                      database.close()
                                  }
                   return created
                
        
    }
    
    func UpdateDemographics2DataAfterEding(demographics2Model : Demographics2Model , id : Int) -> Bool
    {
        var created = false
                          
             if openDatabase() {
                  
                 let query = "update Demographics2 set aphakia = '\(demographics2Model.aphakia!)', cataract ='\(demographics2Model.cataract!)', choroidalEffusion ='\(demographics2Model.choroidalEffusion!)', choroidalHemorrhage = '\(demographics2Model.choroidalHemorrhage!)', diabeticTrd  = '\(demographics2Model.diabeticTrd!)', dislocatedIntraocularLens = '\(demographics2Model.dislocatedIntraocularLens!)', endophthalmitis = '\(demographics2Model.endophthalmitis!)' , epiretinalMembrane = '\(demographics2Model.epiretinalMembrane!)', fevr = '\(demographics2Model.fevr!)', floaters = '\(demographics2Model.floaters!)', fullThicknessMacularHole = '\(demographics2Model.fullThicknessMacularHole!)', intraocularForeignBody = '\(demographics2Model.intraocularForeignBody!)', lamellarMacularHole = '\(demographics2Model.lamellarMacularHole!)', latticeDegeneration = '\(demographics2Model.latticeDegeneration!)', pdr = '\(demographics2Model.pdr!)', primaryRdWithPvr = '\(demographics2Model.primaryRdWithPvr!)', recurrentRdWithPvr = '\(demographics2Model.recurrentRdWithPvr!)', recurrentRdWithOutPvr = '\(demographics2Model.recurrentRdWithOutPvr!)', retainedLensFragments = '\(demographics2Model.retainedLensFragments!)', retinalTear = '\(demographics2Model.retinalTear!)', retinalVeinOcclusion = '\(demographics2Model.retinalVeinOcclusion!)', rhegmatogenousRdMaculaOff = '\(demographics2Model.rhegmatogenousRdMaculaOff!)', rhegmatogenousRdMaculaOn = '\(demographics2Model.rhegmatogenousRdMaculaOn!)', rop = '\(demographics2Model.rop!)', sickleCell = '\(demographics2Model.sickleCell!)', spRdRepairWithSiliconeOil = '\(demographics2Model.spRdRepairWithSiliconeOil!)', subluxedCrystallineLens = '\(demographics2Model.subluxedCrystallineLens!)', vitreousHemorrhage = '\(demographics2Model.vitreousHemorrhage!)' , retinalDefect = '\(demographics2Model.retinalDefect!)' , otherField = '\(demographics2Model.otherField!)' , otherField2 = '\(demographics2Model.otherField2!)' , otherField3 = '\(demographics2Model.otherField3!)' , otherField4 = '\(demographics2Model.otherField4!)' where personIdFromDemo1 = \(id) and status = 1"
                                do {
                                    try database.executeUpdate(query, values: nil)
                                    created = true
                                }
                                catch {
                                    print(error.localizedDescription)
                                }
                         
                                database.close()
                            }
             return created
          
        
        
    }
    
    
    // function get patient details for Export on the basis of type of MRN
       func loadPatientDetailsForExportByMRN(withID mrn : String ) -> [CsvExportDataModel]! {
                  var patientCsvDataExportModelList: [CsvExportDataModel]!
                  var fetchStatus: Bool = false
        
      //  print("variables" , diagnosisType1 , diagnosisType2 , diagnosisType3)
               
                  if openDatabase() {
                      
                       // to print the string
                     
                      let query = "select lastName, firstname, dob, mrn, eye, fellowInvolvement, level, surgerySetting, hospitalName,date, aphakia, cataract, choroidalEffusion, choroidalHemorrhage, diabeticTrd, dislocatedIntraocularLens, endophthalmitis, epiretinalMembrane, fevr, floaters, fullThicknessMacularHole, intraocularForeignBody, lamellarMacularHole, latticeDegeneration, pdr, primaryRdWithPvr, recurrentRdWithPvr, recurrentRdWithOutPvr, retainedLensFragments, retinalTear, retinalVeinOcclusion, rhegmatogenousRdMaculaOff, rhegmatogenousRdMaculaOn, rop, sickleCell, spRdRepairWithSiliconeOil, subluxedCrystallineLens, vitreousHemorrhage,otherField, otherField2 ,otherField3, otherField4,gauge, band, sleeve, tamponad1, srfDrain, acTap,radialElement , membranePeel, ilmPeel, retinectomy, fluidAirExchange, pfo, focalEndolaser, prpLaser, indirectLaserTear, iolExchange, aciol, sulcusIol, sutured, sutureless, pplWithFrag, pplWithoutFrag, tamponade2, comments , percentageTamponade , otherFieldTamponade, otherField2, virectomy, scleralBuckle , iolInsertion , siliconeOilRemoval, siliconeOilExchange , corodialDrainage,  iolReposition, cptCodeDropdown,cptFreeTextBox,cryotherapy ,ilmDropDown , iolName , iolPower , positioning  , macularHoleClosed ,  pomVisualAcuity , pom3VisualAcuity ,  otherOutcomeData , retinalDetachment , fellowInvolvementPercentage , retinalDefect from Demographics1 D1 inner join  Demographics2 D2 on   D1.personIdDemo1 = D2.personIdfromDemo1 inner join Surgery S  on  D1.personIdDemo1 = S.personIdfromDemo1 where  D1.mrn = \(mrn)  and D1.status = 1 "
                    
                      
                       var lastNameColumn: String = "lastName"
                       var firstnameColumn: String = "firstname"
                       var dobColumn: String = "dob"
                       var mrnColumn: String = "mrn"
                       var eyeColumn: String = "eye"
                       var fellowInvolvementColumn: String = "fellowInvolvement"
                       var levelColumn: String = "level"
                       var surgerySettingColumn: String = "surgerySetting"
                       var hospitalNameColumn: String = "hospitalName"
                       var dateColumn: String = "date"
                       var aphakiaColumn: String = "aphakia"
                       var cataractColumn: String = "cataract"
                       var choroidalEffusionColumn: String = "choroidalEffusion"
                       var choroidalHemorrhageColumn: String = "choroidalEffusion"
                       var diabeticTrdColumn: String = "diabeticTrd"
                       var dislocatedIntraocularLensColumn: String = "dislocatedIntraocularLens"
                       var endophthalmitisColumn: String = "endophthalmitis"
                       var epiretinalMembraneColumn: String = "epiretinalMembrane"
                       var fevrColumn: String = "fevr"
                       var floatersColumn: String  = "floaters"
                       var fullThicknessMacularHoleColumn:  String  = "fullThicknessMacularHole"
                       var intraocularForeignBodyColumn: String = "intraocularForeignBody"
                       var lamellarMacularHoleColumn: String  = "lamellarMacularHole"
                       var latticeDegenerationColumn: String = "latticeDegeneration"
                       var pdrColumn: String = "pdr"
                       var primaryRdWithPvrColumn: String = "primaryRdWithPvr"
                       var recurrentRdWithPvrColumn: String = "recurrentRdWithPvr"
                       var recurrentRdWithOutPvrColumn: String = "recurrentRdWithOutPvr"
                       var retainedLensFragmentsColumn: String  = "retainedLensFragments"
                       var retinalTearColumn: String = "retinalTear"
                       var retinalVeinOcclusionColumn: String = "retinalVeinOcclusion"
                       var rhegmatogenousRdMaculaOffColumn: String = "rhegmatogenousRdMaculaOff"
                       var rhegmatogenousRdMaculaOnColumn: String = "rhegmatogenousRdMaculaOn"
                       var ropColumn: String = "rop"
                       var sickleCellColumn: String = "sickleCell"
                       var spRdRepairWithSiliconeOilColumn: String = "spRdRepairWithSiliconeOil"
                       var subluxedCrystallineLensColumn: String = "subluxedCrystallineLens"
                       var vitreousHemorrhageColumn: String = "vitreousHemorrhage"
                       var otherFieldColumn: String = "otherField"
                       var otherField2Column: String = "otherField2"
                       var otherField3Column: String = "otherField3"
                       var otherField4Column: String = "otherField4"
                       var gaugeColumn: String = "gauge"
                       var bandColumn: String = "band"
                       var sleeveColumn: String = "sleeve"
                       var tamponad1Column: String = "tamponad1"
                       var srfDrainColumn: String = "srfDrain"
                       var acTapColumn: String = "acTap"
                       var membranePeelColumn: String = "membranePeel"
                       var ilmPeelColumn: String = "ilmPeel"
                       var retinectomyColumn: String = "retinectomy"
                       var fluidAirExchangeColumn: String = "fluidAirExchange"
                       var pfoColumn: String = "pfo"
                       var focalEndolaserColumn: String = "focalEndolaser"
                       var prpLaserColumn:String = "prpLaser"
                       var indirectLaserTearColumn: String = "indirectLaserTear"
                       var iolExchangeColumn: String = "iolExchange"
                       var aciolColumn: String = "aciol"
                       var sulcusIolColumn: String = "sulcusIol"
                       var suturedColumn: String = "sutured"
                       var suturelessColumn: String = "sutureless"
                       var pplWithFragColumn: String = "pplWithFrag"
                       var pplWithoutFragColumn: String = "pplWithoutFrag"
                       var tamponade2Column: String = "tamponade2"
                       var commentsColumn: String = "comments"
                       var percentageTamponadeColumn : String = "percentageTamponade"
                       var otherFieldTamponadeColumn : String = "otherFieldTamponade"
                   //
                   var otherFieldSurgery2Column : String = "otherField2"
                   var virectomyColumn : String = "virectomy"
                   var scleralBuckleColumn : String = "scleralBuckle"
                   var iolInsertionColumn : String = "iolInsertion"
                   var iolNameColumn : String = "iolName"
                   var iolPowerColumn : String = "IolPower"
                   var positioningColumn : String = "positioning"
                   //
                       var retinalDetachmentColumn : String = "retinalDetachment"
                       var macularHoleClosedColumn : String = "macularHoleClosed"
                       var pomVisualAcuityColumn: String = "pomVisualAcuity"
                       var pom3VisualAcuityColumn: String = "pom3VisualAcuity"
                       var otherOutcomeDataColumn : String = "otherOutcomeData"
                       var siliconeOilRemovalColumn : String = "siliconeOilRemoval"
                       var siliconeOilExchangeColumn : String = "siliconeOilExchange"
                       var corodialDrainageColumn : String = "corodialDrainage"
                      
                      let iolRepositionColumn : String = "iolReposition"
                      let cptCodeDropdownColumn : String = "cptCodeDropdown"
                      let cptFreeTextBoxColumn : String = "cptFreeTextBox"
                      let cryotherapyColumn : String = "cryotherapy"
                      let ilmDropDownColumn : String = "ilmDropDown"
                     let radialElementColumn : String = "radialElement"
                      let fellowInvolvementPercentageColumn : String = "fellowInvolvementPercentage"
                      let retinalDefectColumn : String = "retinalDefect"
                    
                       
                      
                      
                      do {
                          
                          print(database)
                          
                          let results = try! database.executeQuery(query, values : nil )
                          fetchStatus = true
                          print("patient details fetched during search" ,fetchStatus)

               
                          while (results.next()) {
                              print("while loop entered")
                              
                              let patientCsvDataExportModel = CsvExportDataModel(lastName: results.string(forColumn: lastNameColumn),
                                                                                 firstname: results.string(forColumn: firstnameColumn),
                                
                                                                                 dob: results.string(forColumn: dobColumn)
                                  , mrn: results.string(forColumn: mrnColumn),
                                    eye: results.string(forColumn: eyeColumn)
                                    ,fellowInvolvement: results.string(forColumn: fellowInvolvementColumn), level: results.string(forColumn: levelColumn), surgerySetting: results.string(forColumn: surgerySettingColumn), hospitalName: results.string(forColumn: hospitalNameColumn), date: results.string(forColumn: dateColumn), aphakia: results.string(forColumn: aphakiaColumn), cataract: results.string(forColumn: cataractColumn), choroidalEffusion: results.string(forColumn: choroidalEffusionColumn), choroidalHemorrhage: results.string(forColumn: choroidalHemorrhageColumn), diabeticTrd: results.string(forColumn: diabeticTrdColumn), dislocatedIntraocularLens: results.string(forColumn: dislocatedIntraocularLensColumn), endophthalmitis: results.string(forColumn: endophthalmitisColumn), epiretinalMembrane: results.string(forColumn: epiretinalMembraneColumn),
                                    fevr: results.string(forColumn: fevrColumn),
                                    floaters: results.string(forColumn: floatersColumn),
                                    fullThicknessMacularHole: results.string(forColumn: fullThicknessMacularHoleColumn),
                                    intraocularForeignBody: results.string(forColumn: intraocularForeignBodyColumn),
                                    lamellarMacularHole: results.string(forColumn: lamellarMacularHoleColumn),
                                   latticeDegeneration: results.string(forColumn: latticeDegenerationColumn),
                                   pdr: results.string(forColumn: pdrColumn),
                                   primaryRdWithPvr: results.string(forColumn: primaryRdWithPvrColumn),
                                   recurrentRdWithPvr: results.string(forColumn: recurrentRdWithPvrColumn),
                                   recurrentRdWithOutPvr: results.string(forColumn: recurrentRdWithOutPvrColumn),
                                   retainedLensFragments: results.string(forColumn: retainedLensFragmentsColumn), retinalTear: results.string(forColumn: retinalTearColumn),
                                   retinalVeinOcclusion: results.string(forColumn: retinalVeinOcclusionColumn), rhegmatogenousRdMaculaOff: results.string(forColumn: rhegmatogenousRdMaculaOffColumn),
                                   rhegmatogenousRdMaculaOn: results.string(forColumn: rhegmatogenousRdMaculaOnColumn) , rop: results.string(forColumn: ropColumn)!, sickleCell: results.string(forColumn: sickleCellColumn), spRdRepairWithSiliconeOil: results.string(forColumn: spRdRepairWithSiliconeOilColumn), subluxedCrystallineLens: results.string(forColumn: subluxedCrystallineLensColumn), vitreousHemorrhage: results.string(forColumn: vitreousHemorrhageColumn), otherField: results.string(forColumn: otherFieldColumn),otherField2 : results.string(forColumn: otherField2Column) , otherField3 : results.string(forColumn: otherField3Column), otherField4 : results.string(forColumn: otherField4Column) , gauge: results.string(forColumn: gaugeColumn), band: results.string(forColumn: bandColumn), sleeve: results.string(forColumn: sleeveColumn), tamponad1: results.string(forColumn: tamponad1Column), srfDrain: results.string(forColumn: srfDrainColumn), acTap: results.string(forColumn: acTapColumn), radialElement: results.string(forColumn: radialElementColumn), membranePeel: results.string(forColumn: membranePeelColumn), ilmPeel: results.string(forColumn: ilmPeelColumn), retinectomy: results.string(forColumn: retinectomyColumn), fluidAirExchange: results.string(forColumn: fluidAirExchangeColumn), pfo: results.string(forColumn: pfoColumn), focalEndolaser: results.string(forColumn: focalEndolaserColumn), prpLaser: results.string(forColumn: prpLaserColumn), indirectLaserTear: results.string(forColumn: indirectLaserTearColumn), iolExchange: results.string(forColumn: iolExchangeColumn), aciol: results.string(forColumn: aciolColumn), sulcusIol: results.string(forColumn: sulcusIolColumn), sutured: results.string(forColumn: suturedColumn), sutureless: results.string(forColumn: suturelessColumn), pplWithFrag: results.string(forColumn: pplWithFragColumn), pplWithoutFrag: results.string(forColumn: pplWithoutFragColumn), tamponade2: results.string(forColumn: tamponade2Column),percentageTamponade: results.string(forColumn: percentageTamponadeColumn)  ,
                                   otherFieldTamponade: results.string(forColumn: otherFieldTamponadeColumn) ,comments: results.string(forColumn: commentsColumn),
                                   otherField2Surgery: results.string(forColumn: otherFieldSurgery2Column),
                                   virectomy: results.string(forColumn: virectomyColumn),
                                   scleralBuckle: results.string(forColumn: scleralBuckleColumn),
                                   iolInsertion: results.string(forColumn: iolInsertionColumn),
                                   siliconeOilRemoval: results.string(forColumn: siliconeOilRemovalColumn),
                                   siliconeOilExchange: results.string(forColumn: siliconeOilExchangeColumn),corodialDrainage: results.string(forColumn: corodialDrainageColumn), iolReposition: results.string(forColumn: iolRepositionColumn),cptCodeDropdown: results.string(forColumn: cptCodeDropdownColumn), cptFreeTextBox: results.string(forColumn: cptFreeTextBoxColumn) , cryotherapy: results.string(forColumn: cryotherapyColumn), ilmCodeDropdown:  results.string(forColumn: cryotherapyColumn) ,
                                       iolName : results.string(forColumn: iolNameColumn),
                                       iolPower: results.string(forColumn: iolPowerColumn ) , positioning: results.string(forColumn: positioningColumn )
                               
                               
                               
                               ,
                                        retinalDetachment: results.string(forColumn: retinalDetachmentColumn) , macularHoleClosed: results.string(forColumn: macularHoleClosedColumn) ,
                                                                                 pomVisualAcuity: results.string(forColumn: pomVisualAcuityColumn) , pom3VisualAcuity: results.string(forColumn: pom3VisualAcuityColumn) ,otherOutcomeData: results.string(forColumn: otherOutcomeDataColumn) ,fellowInvolvementPercentage: results.string(forColumn: fellowInvolvementPercentageColumn), retinalDefect: results.string(forColumn: retinalDefectColumn) )
                           
                             if patientCsvDataExportModelList  == nil {
                                                                                 patientCsvDataExportModelList = [CsvExportDataModel]()
                                                                             }
                                           
                              patientCsvDataExportModelList.append(patientCsvDataExportModel)
                              
                                    }
                          
                          print("details of patient list in dbManger", patientCsvDataExportModelList)
                      
                      }
                      catch {
                          print(error.localizedDescription)
                      }
                      
                  }
                 return patientCsvDataExportModelList
              }
      
    
    
    
    
    // For updating outcomes data for Surgery Section
//    func UpdateOutcomesDataInSurgeryTable(personid: Int,retinalDetachment: String, macularHoleClosed: String, pomVisualAcuity : String, pom3VisualAcuity: String,
//         otherOutcomeData : String  ) -> Bool   {
//
//        var created = false
//
//        if openDatabase() {
//
//                        let query = "update Surgery set retinalDetachment = '\(retinalDetachment)', macularHoleClosed = '\(macularHoleClosed)', pomVisualAcuity = '\(pomVisualAcuity)', pom3VisualAcuity = '\(pom3VisualAcuity)', otherOutcomeData = '\(otherOutcomeData)'      where personIdfromDemo1 ='\(personid)'"
//
//
//
//                           do {
//                               try database.executeUpdate(query, values: nil)
//                               created = true
//                           }
//                           catch {
//                               print(error.localizedDescription)
//                           }
//
//                           database.close()
//                       }
//        return created
//
//
//    }

//    func UpdateDemographics2DataAfterEding(demographics2Model : Demographics2Model , id : Int) -> Bool
//    {
//        var created = false
//
//             if openDatabase() {
//
//                let query = "update Demographics2 set aphakia = '\(demographics2Model.aphakia!)', cataract ='\(demographics2Model.cataract!)', choroidalEffusion ='\(demographics2Model.choroidalEffusion!)', choroidalHemorrhage = '\(demographics2Model.choroidalHemorrhage!)', diabeticTrd  = '\(demographics2Model.diabeticTrd!)', dislocatedIntraocularLens = '\(demographics2Model.dislocatedIntraocularLens!)', endophthalmitis = '\(demographics2Model.endophthalmitis!)' , epiretinalMembrane = '\(demographics2Model.epiretinalMembrane!)', fevr = '\(demographics2Model.fevr!)', floaters = '\(demographics2Model.floaters!)', fullThicknessMacularHole = '\(demographics2Model.fullThicknessMacularHole!)', intraocularForeignBody = '\(demographics2Model.intraocularForeignBody!)', lamellarMacularHole = '\(demographics2Model.lamellarMacularHole!)', latticeDegeneration = '\(demographics2Model.latticeDegeneration!)', pdr = '\(demographics2Model.pdr!)', primaryRdWithPvr = '\(demographics2Model.primaryRdWithPvr!)', recurrentRdWithPvr = '\(demographics2Model.recurrentRdWithPvr!)', recurrentRdWithOutPvr = '\(demographics2Model.recurrentRdWithOutPvr!)', retainedLensFragments = '\(demographics2Model.retainedLensFragments!)', retinalTear = '\(demographics2Model.retinalTear!)', retinalVeinOcclusion = '\(demographics2Model.retinalVeinOcclusion!)', rhegmatogenousRdMaculaOff = '\(demographics2Model.rhegmatogenousRdMaculaOff!)', rhegmatogenousRdMaculaOn = '\(demographics2Model.rhegmatogenousRdMaculaOn!)', rop = '\(demographics2Model.rop!)', sickleCell = '\(demographics2Model.sickleCell!)', spRdRepairWithSiliconeOil = '\(demographics2Model.spRdRepairWithSiliconeOil!)', subluxedCrystallineLens = '\(demographics2Model.subluxedCrystallineLens!)', vitreousHemorrhage = '\(demographics2Model.vitreousHemorrhage!)' , otherField = '\(demographics2Model.otherField)' , otherField2 = '\(demographics2Model.otherField2)' , otherField3 = '\(demographics2Model.otherField3)' , otherField4 = '\(demographics2Model.otherField4)' where personIdFromDemo1 = \(id) and status = 1"
//                                do {
//                                    try database.executeUpdate(query, values: nil)
//                                    created = true
//                                }
//                                catch {
//                                    print(error.localizedDescription)
//                                }
//
//                                database.close()
//                            }
//             return created
//
//
//
//    }

    func UpdateSurgeryDataAfterEding(surgeryModel : SurgeryModel , id:Int) -> Bool
       {
           var created = false

                if openDatabase() {

                    let query = " update Surgery set gauge = '\(surgeryModel.gauge!)', band = '\(surgeryModel.band!)', sleeve = '\(surgeryModel.sleeve!)', tamponad1 = '\(surgeryModel.tamponad1!)', srfDrain = '\(surgeryModel.srfDrain!)', acTap = '\(surgeryModel.acTap!)', radialElement = '\(surgeryModel.radialElement!)' ,membranePeel = '\(surgeryModel.membranePeel!)', ilmPeel = '\(surgeryModel.ilmPeel!)', retinectomy = '\(surgeryModel.retinectomy!)', fluidAirExchange = '\(surgeryModel.fluidAirExchange!)', pfo = '\(surgeryModel.pfo!)', focalEndolaser = '\(surgeryModel.focalEndolaser!)', prpLaser = '\(surgeryModel.prpLaser!)', indirectLaserTear = '\(surgeryModel.indirectLaserTear!)', iolExchange = '\(surgeryModel.iolExchange!)', aciol = '\(surgeryModel.aciol!)', sulcusIol = '\(surgeryModel.sulcusIol!)', sutured = '\(surgeryModel.sutured!)', sutureless = '\(surgeryModel.sutureless!)', pplWithFrag = '\(surgeryModel.pplWithFrag!)', pplWithoutFrag = '\(surgeryModel.pplWithoutFrag!)', tamponade2 = '\(surgeryModel.tamponade1!)', comments = '\(surgeryModel.comments!)', percentageTamponade = '\(surgeryModel.percentageTamponade!)' , otherFieldTamponade = '\(surgeryModel.otherFieldTamponade!)' , otherField2Surgery = '\(surgeryModel.otherField2!)'  , virectomy = '\(surgeryModel.virectomy!)' , scleralBuckle = '\(surgeryModel.scleralBuckle!)' , iolInsertion = '\(surgeryModel.iolInsertion!)' , iolName = '\(surgeryModel.iolName!)' , IolPower = '\(surgeryModel.iolPower!)' , positioning = '\(surgeryModel.positioning!)' , siliconeOilRemoval = '\(surgeryModel.siliconeOilRemoval!)'  , siliconeOilExchange = '\(surgeryModel.siliconeOilExchange!)' , corodialDrainage = '\(surgeryModel.corodialDrainage!)' , iolReposition = '\(surgeryModel.iolReposition!)' , cptCodeDropdown = '\(surgeryModel.cptCodeDropdown!)' , cptFreeTextBox = '\(surgeryModel.cptFreeTextBox!)' , cryotherapy = '\(surgeryModel.cryotherapy!)' , ilmDropDown = '\(surgeryModel.ilmDropDown!)' WHERE personIdfromDemo1 =\(id) and status = 1"

                                   

                                   do {
                                       try database.executeUpdate(query, values: nil)
                                       created = true
                                   }
                                   catch {
                                       print(error.localizedDescription)
                                   }

                                   database.close()
                               }
                return created



       }
    
    func NumberOfCompletedCases() -> Int {
        
        var completedCases = 0
           
                if openDatabase() {
                 
                 
                 
                    // let query = "SELECT personIdDemo1 FROM Demographics1"
        //            let query = "SELECT *
        //            FROM    TABLE
        //            WHERE   ID = (SELECT MAX(ID)  FROM TABLE)"
                    let query = "select count(*) from Demographics1 WHERE status = 1 "
                  
                    do {
                        print(database)
                       let results = try database.executeQuery(query, values: nil)
                        
                       if results.next() {
                        
                        completedCases = results[0] as! Int
                     
                        }
                                 
                           
                        }
                 
                    catch {
                        print(error.localizedDescription)
                    }
             
                    database.close()
                }
             
        
        return completedCases
    }
      
       
    
    // Count the Number of REGISTERED DOCTOR
      func NumberOfRegistrations() -> Int {
             
             var numberOfRegistration = 0
                
                     if openDatabase() {
                      
                      
                      
                         // let query = "SELECT personIdDemo1 FROM Demographics1"
             //            let query = "SELECT *
             //            FROM    TABLE
             //            WHERE   ID = (SELECT MAX(ID)  FROM TABLE)"
                         let query = "select count(*) from Registration"
                        
                    
                       
                         do {
                             print(database)
                            let results = try database.executeQuery(query, values: nil)
                             
                            if results.next() {
                             
                             numberOfRegistration = results[0] as! Int
                             
                   
                            
                             }
                                      
                                
                             }
                      
                         catch {
                             print(error.localizedDescription)
                         }
                  
                         database.close()
                     }
                  
             
             return numberOfRegistration
         }
           
            
         
         
            
           
     
      
    

       
      
}

