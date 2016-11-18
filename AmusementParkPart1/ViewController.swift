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
        
        passProcessing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func passProcessing() {
        
        // Classic Guest
        let applicant = ApplicantDetails()
        let entrantType = EntrantType.guest(.classic)
        
        // VIP Guest
//        let applicant = ApplicantDetails()
//        let entrantType = EntrantType.guest(.vip)

        // Child Guest - change birthdate to test age calculation
//        let birthDate = DateHelper.getDate(year: 2011, month: 11, Day: 14)
//        print(birthDate)
//        let applicant = ApplicantDetails(firstName: "Little", lastName: "Jimmy", dateOfBirth: birthDate!, street: nil, city: nil, state: nil, zipCode: nil)
//        let entrantType = EntrantType.guest(.freeChild)
        
        // Food Service Employee
//        let applicant = ApplicantDetails(firstName: "Dave", lastName: "Morgan", dateOfBirth: nil, street: "9 Giammati St", city: "San Francisco", state: "CA", zipCode: 60423)
//        let entrantType = EntrantType.employee(.hourlyFoodServices)

        // Ride Control Employee
//        let applicant = ApplicantDetails(firstName: "Pete", lastName: "Moss", dateOfBirth: nil, street: "6 Fowler St", city: "Bristol", state: "CT", zipCode: 06106)
//        let entrantType = EntrantType.employee(.hourlyRideServices)

        // Maintenance Employee
//        let applicant = ApplicantDetails(firstName: "Jim", lastName: "Smith", dateOfBirth: nil, street: "1 Cupertino St", city: "Los Angeles", state: "CA", zipCode: 90210)
//        let entrantType = EntrantType.employee(.hourlyMaintenance)
        
        // Manager - good data - put today's date in to test birthday
//        let bossDOB = DateHelper.getDate(year: 1978, month: 11, Day: 18)
//        let applicant = ApplicantDetails(firstName: "Boss", lastName: "Man", dateOfBirth: bossDOB!, street: "100 42nd St", city: "New York", state: "NY", zipCode: 10101)
//        let entrantType = EntrantType.manager

        // Manager - bad data (missing zip code)
//        let applicant = ApplicantDetails(firstName: "Boss", lastName: "Man", dateOfBirth: nil, street: "100 42nd St", city: "New York", state: "NY", zipCode: nil)
//        let entrantType = EntrantType.manager

        do {
            
            let pass = try PassGenerator.generatePass(applicant: applicant, entrantType: entrantType)
            
            // print all permissions to console
            print(pass.description())
            
            //////////////////////////////////////////////////////////////////
            // Test: try to access amusements
            let amusementsResult = Area.amusements.swipe(pass: pass)
            print(amusementsResult.message)
            
            if amusementsResult.permitted {
                // can use the boolean as needed in the system
            }

            //////////////////////////////////////////////////////////////////
            // Test: try to access kitchen
            let kitchenResult = Area.kitchen.swipe(pass: pass)
            print(kitchenResult.message)
            
            if kitchenResult.permitted {
                // can use the boolean as needed in the system
            }

            //////////////////////////////////////////////////////////////////
            // Test: try to access maintenance
            let maintenanceResult = Area.maintenance.swipe(pass: pass)
            print(maintenanceResult.message)
            
            if maintenanceResult.permitted {
                // can use the boolean as needed in the system
            }

            //////////////////////////////////////////////////////////////////
            // Test: try to access office
            let officeResult = Area.office.swipe(pass: pass)
            print(officeResult.message)
            
            if officeResult.permitted {
                // can use the boolean as needed in the system
            }

            //////////////////////////////////////////////////////////////////
            // Test: try to get on ride
            let rideResult = RideAccess.allRides.swipe(pass: pass)
            print(rideResult.message)
            
            if rideResult.permitted {
                // can use the boolean as needed in the system
                
                // can also unwrap the ride priority here too
                if let result = rideResult as? RideAccess.RideAccessSwipeResult,
                    let priority = result.priority {
                    
                    print(priority)
                }
            }
            
            //////////////////////////////////////////////////////////////////
            // Test: double swipe to access ride - should deny access
//            let secondRideResult = RideAccess.allRides.swipe(pass: pass)
//            print(secondRideResult.message)
//            
//            if secondRideResult.permitted {
//                // can use the boolean as needed in the system
//            }
            
            //////////////////////////////////////////////////////////////////
            // Test: try to get discount on food
            let foodDiscountResult = DiscountType.food.swipe(pass: pass)
            print(foodDiscountResult.message)
            
            if foodDiscountResult.permitted {
                
                if let result = foodDiscountResult as? DiscountType.DiscountTypeSwipeResult,
                    let amount = result.amount {
                    
                    // here we can access the actual amount to apply the discount
                    // in the system
                    print(amount)
                }
            }

            //////////////////////////////////////////////////////////////////
            // Test: try to get discount on merchandise
            let merchandiseDiscountResult = DiscountType.merchandise.swipe(pass: pass)
            print(merchandiseDiscountResult.message)
            
            if merchandiseDiscountResult.permitted {
                
                if let result = merchandiseDiscountResult as? DiscountType.DiscountTypeSwipeResult,
                    let amount = result.amount {
                    
                    // here we can access the actual amount to apply the discount
                    // in the system
                    print(amount)
                }
            }

        } catch PassGenerator.PassGeneratorError.missingInformation(let additionalInfo) {
            print("Missing required information: \(additionalInfo)")
        } catch PassGenerator.PassGeneratorError.doesNotQualify(let additionalInfo) {
            print("Application does not qualify: \(additionalInfo)")
        } catch {
            print("Failed to generate Pass")
        }
    }

}

