//
//  Swipeable.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/17/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

protocol SwipeResult {
    var permitted: Bool { get }
}

protocol Swipeable {
    func swipe(pass: Pass) -> SwipeResult
}

extension Area: Swipeable, DingsOrBuzzes {
    
    struct AreaSwipeResult: SwipeResult {
        var permitted: Bool
    }
    
    func swipe(pass: Pass) -> SwipeResult {
        
        pass.entrant.checkBirthday()
        
        guard !pass.isTryingToReswipe() else {
            playBuzzSound()
            print("Sorry - this pass has already been used recently. Please try again later.")
            return AreaSwipeResult(permitted: false)
        }
        
        for permission in pass.permissions {
            switch permission {
            case .areaAccess(let area):
                if area == self {
                    playDingSound()
                    return AreaSwipeResult(permitted: true)
                }
            default:
                break
            }
        }
        
        playBuzzSound()
        return AreaSwipeResult(permitted: false)
    }
}

extension RideAccess: Swipeable, DingsOrBuzzes {
    
    struct RideAccessSwipeResult: SwipeResult {
        let permitted: Bool
        let priority: RidePriority?
    }
    
    func swipe(pass: Pass) -> SwipeResult {
        
        pass.entrant.checkBirthday()
        
        guard !pass.isTryingToReswipe() else {
            playBuzzSound()
            print("Sorry - this pass has already been used recently. Please try again later.")
            return RideAccessSwipeResult(permitted: false, priority: nil)
        }

        for permission in pass.permissions {
            switch permission {
            case .rideAccess(let priority):
                switch priority {
                case .noRides:
                    playBuzzSound()
                    return RideAccessSwipeResult(permitted: false, priority: nil)
                case .allRides(let priority):
                    playDingSound()
                    return RideAccessSwipeResult(permitted: true, priority: priority)
                }
            default:
                break
            }
        }
        
        playBuzzSound()
        return RideAccessSwipeResult(permitted: false, priority: nil)
    }
}

extension DiscountType: Swipeable, DingsOrBuzzes {
    
    struct DiscountTypeSwipeResult: SwipeResult {
        let permitted: Bool
        let amount: Int?
    }
    
    func swipe(pass: Pass) -> SwipeResult {
        
        pass.entrant.checkBirthday()
        
        guard !pass.isTryingToReswipe() else {
            playBuzzSound()
            print("Sorry - this pass has already been used recently. Please try again later.")
            return DiscountTypeSwipeResult(permitted: false, amount: nil)
        }
        
        for permission in pass.permissions {
            switch permission {
            case .discountAccess(let discount, let amount):
                if discount == self {
                    return DiscountTypeSwipeResult(permitted: true, amount: amount)
                }
            default:
                break
            }
        }
        
        playBuzzSound()
        return DiscountTypeSwipeResult(permitted: false, amount: nil)
    }
}

