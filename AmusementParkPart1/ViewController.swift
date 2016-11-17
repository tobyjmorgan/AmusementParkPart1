//
//  ViewController.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/16/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // N.B. I encapsulated the sounds stuff in a separate SoundManager class and am keeping
    // an insance of it as a property to this view controller
    let sounds = SoundManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perform(#selector(ViewController.passProcessing), with: nil, afterDelay: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func passProcessing() {
        
//        let applicant = ApplicantDetails()
//        let entrantType = EntrantType.guest(.classic)
        
//        let applicant = ApplicantDetails()
//        let entrantType = EntrantType.guest(.vip)
//        
//        let birthDate = DateHelper.getDate(year: 2011, month: 11, Day: 14)
//        print(birthDate)
//        let applicant = ApplicantDetails(firstName: nil, lastName: nil, dateOfBirth: birthDate!, street: nil, city: nil, state: nil, zipCode: nil)
//        let entrantType = EntrantType.guest(.freeChild)
//        
//        let applicant = ApplicantDetails(firstName: "Dave", lastName: "Morgan", dateOfBirth: nil, street: "9 Giammati St", city: "San Francisco", state: "CA", zipCode: 60423)
//        let entrantType = EntrantType.employee(.hourlyFoodServices)
//        
//        let applicant = ApplicantDetails(firstName: "Jim", lastName: "Smith", dateOfBirth: nil, street: "1 Cupertino St", city: "Los Angeles", state: "CA", zipCode: 90210)
//        let entrantType = EntrantType.employee(.hourlyMaintenance)
        
        let bossDOB = DateHelper.getDate(year: 1978, month: 11, Day: 15)
        let applicant = ApplicantDetails(firstName: "Boss", lastName: "Man", dateOfBirth: bossDOB!, street: "100 42nd St", city: "New York", state: "NY", zipCode: 10101)
        let entrantType = EntrantType.manager
        
        do {
            
            let pass = try PassGenerator.generatePass(applicant: applicant, entrantType: entrantType)
            print(pass.description())
            
            if let priority: RidePriority = pass.swipe() {
                if priority == .skipLines {
                    print("Go ahead and skip the line")
                } else {
                    print("Wait in line please")
                }
            }
            
            if let priority: RidePriority = pass.swipe() {
                if priority == .skipLines {
                    print("Go ahead and skip the line")
                } else {
                    print("Wait in line please")
                }
            }
            
            
//            let (result, amount) = pass.swipe(discount: .food)
//            if result {
//                print("Food Discount: \(amount)")
//            }
//
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

}

