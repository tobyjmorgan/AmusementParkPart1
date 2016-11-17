//
//  Pass.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/16/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

class Pass {
    
    static let thresholdForReswipe: TimeInterval = 60
    
    let permissions: [AccessPermission]
    let entrant: ApplicantDetails
    let entrantType: EntrantType
    var lastSwipeTime: Date = Date.distantPast
    
    init(permissions: [AccessPermission], entrant: ApplicantDetails, entrantType: EntrantType) {
        self.permissions = permissions
        self.entrant = entrant
        self.entrantType = entrantType
    }
    
    //////////////////////////////////////////////////////////////////////////////
    // MARK: Birthday Processing
    
    func birthdayMessage() {
        if let name = entrant.firstName {
            print("Happy Birthday \(name)!")
        } else {
            print("Happy Birthday!")
        }
    }
    
    func isEntrantsBirthday() -> Bool {
        
        if let dob = entrant.dateOfBirth {
            
            let today = Date()
            let todayDay = Calendar.current.component(.day, from: today)
            let todayMonth = Calendar.current.component(.month, from: today)
            let dobDay = Calendar.current.component(.day, from: dob)
            let dobMonth = Calendar.current.component(.month, from: dob)
            
            if dobDay == todayDay && dobMonth == todayMonth {
                return true
            }
        }
        
        return false
    }
    
    func checkBirthday() {
        
        if isEntrantsBirthday() {
            birthdayMessage()
        }
    }
    


    
    
    //////////////////////////////////////////////////////////////////////////////
    // MARK: Reswipe Processing
    
    func isTryingToReswipe() -> Bool {
        
        // capture the last time this pass was swiped for ride access
        let tempLastSwipe = lastSwipeTime
        
        // update lastSwipeTime ready for next check
        lastSwipeTime = Date()
        
        if Date().timeIntervalSince1970 - tempLastSwipe.timeIntervalSince1970 < Pass.thresholdForReswipe {
            
            print("Sorry, this pass was already recently used for this ride. Please try again later.")
            return true
        }
        
        return false
    }
    
    
    
    
    //////////////////////////////////////////////////////////////////////////////
    // MARK: Swipe Processing
    
    ////////////////////////////////////////////////////////////////////
    // N.B. overloading the swipe method with all the different ways it
    // can be used
    
    // this version of swipe will list all of the permissions associated
    // with this Pass
    func swipe() -> [AccessPermission] {
        
        checkBirthday()
        
        return permissions
    }
    
    // this version of swipe will list all the permitted areas associated
    // with this Pass
    func swipe() -> [Area] {
        
        checkBirthday()
        
        var accessibleAreas: [Area] = []
        
        for permission in permissions {
            
            switch permission {
            case .areaAccess(let area):
                accessibleAreas.append(area)
            default:
                break
            }
        }
        
        return accessibleAreas
    }
    
    // this version of swipe will return whether the Pass permits access
    // to the requested area
    func swipe(toAccess area: Area) -> Bool {
        
        checkBirthday()
        
        for permission in permissions {
            
            switch permission {
            case .areaAccess(let permittedArea):
                if area == permittedArea {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: SoundManager.notificationPlayDingSound), object: nil)
                    return true
                }
            default:
                break
            }
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SoundManager.notificationPlayBuzzSound), object: nil)
        return false
    }
    
    // this version of swipe will return whether the Pass permits the
    // AccessPermission specified
    func swipe(has access: AccessPermission) -> Bool {
        
        checkBirthday()
        
        for permission in permissions {
            
            // This is where the equatable extension gets used.
            // The definition of what is equatable for an AccessPermission
            // depends on the enum case in question.
            // See implementation of == for more clarity
            if access == permission {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: SoundManager.notificationPlayDingSound), object: nil)
                return true
            }
        }

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SoundManager.notificationPlayBuzzSound), object: nil)
        return false
    }
    
    // this version of swipe returns the ride priority associated with the Pass
    func swipe() -> RidePriority? {
        
        checkBirthday()
        
        if isTryingToReswipe() {
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: SoundManager.notificationPlayBuzzSound), object: nil)
            
        } else {
            
            for permission in permissions {
                
                switch permission {
                    
                case .rideAccess(let priority):
                    return priority
                    
                default:
                    break
                }
            }
        }
        
        return nil
    }
    
    // this version of swipe returns the discount amount for the
    // specified DiscountType
    func swipe(discount: DiscountType) -> Int {
        
        checkBirthday()
        
        for permission in permissions {
            
            switch permission {
                
            case .discountAccess(let actualDiscount, let amount):
                if discount == actualDiscount {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: SoundManager.notificationPlayDingSound), object: nil)
                    return amount
                }
            default:
                break
            }
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SoundManager.notificationPlayBuzzSound), object: nil)
        return 0
    }    
}
