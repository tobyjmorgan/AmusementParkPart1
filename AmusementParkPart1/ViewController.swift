//
//  ViewController.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/16/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        let applicant = ApplicantDetails()
        //        let entrantType = EntrantType.guest(.classic)
        
        //        let applicant = ApplicantDetails()
        //        let entrantType = EntrantType.guest(.vip)
        
        //        let birthDate = DateHelper.getDate(year: 2011, month: 11, Day: 14)
        //        print(birthDate)
        //        let applicant = ApplicantDetails(firstName: nil, lastName: nil, dateOfBirth: birthDate!, street: nil, city: nil, state: nil, zipCode: nil)
        //        let entrantType = EntrantType.guest(.freeChild)
        
        let applicant = ApplicantDetails(firstName: "Dave", lastName: "Morgan", dateOfBirth: nil, street: "9 Giammati St", city: "San Francisco", state: "CA", zipCode: 60423)
        let entrantType = EntrantType.employee(.hourlyMaintenance)
        
        do {
            
            let pass = try PassGenerator.generatePass(applicant: applicant, entrantType: entrantType)
            pass.printPermissions()
            
            
            if pass.swipe(toAccess: .kitchen) {
                print("You can enter the kitchen")
            } else {
                print("Sorry you can't access this area")
            }
            
            if pass.swipe() == RidePriority.skipLines {
                print("Go ahead and skip the line")
            } else {
                print("Wait in line please")
            }
            
            if pass.swipe().contains(.kitchen) {
                print("This person has access to the kitchen")
            }
            
            print("Food Discount: \(pass.swipe(discount: .food))")
            print("Merchandise Discount: \(pass.swipe(discount: .merchandise))")
            
        } catch PassGenerator.PassGeneratorError.missingInformation(let additionalInfo) {
            print("Missing required information: \(additionalInfo)")
        } catch PassGenerator.PassGeneratorError.doesNotQualify(let additionalInfo) {
            print("Application does not qualify: \(additionalInfo)")
        } catch {
            print("Failed to generate Pass")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

