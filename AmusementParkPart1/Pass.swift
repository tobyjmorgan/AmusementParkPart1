//
//  Pass.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/16/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

struct Pass {
    
    var permissions: [AccessPermission]
    var entrant: ApplicantDetails
    var entrantType: EntrantType
    
    ////////////////////////////////////////////////////////////////////
    // N.B. overloading the swipe method with all the different ways it 
    // can be used
    
    // this version of swipe will just print all of the Pass's permissions
    // to the console
    func swipe() {
        for permission in permissions {
            print(permission.description())
        }
    }
    
    // this version of swipe will return all of the permissions associated
    // with the Pass
    func swipe() -> [AccessPermission] {
        return permissions
    }
    
    // this version of swipe will return all the areas permitted by
    // the Pass
    func swipe() -> [Area] {
        
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
        
        for permission in permissions {
            
            switch permission {
            case .areaAccess(let permittedArea):
                if area == permittedArea {
                    return true
                }
            default:
                break
            }
        }
        
        return false
    }
    
    // this version of swipe will return whether the Pass permits the
    // AccessPermission specified
    func swipe(has access: AccessPermission) -> Bool {
        
        for permission in permissions {
            
            // This is where the equatable extension gets used.
            // The definition of what is equatable for an AccessPermission
            // depends on the enum case in question.
            // See implementation of == for more clarity
            if access == permission {
                return true
            }
        }
        
        return false
    }
    
    // this version of swipe returns the ride priority associated with the Pass
    func swipe() -> RidePriority? {
        
        for permission in permissions {
            
            switch permission {
                
            case .rideAccess(let priority):
                return priority
                
            default:
                break
            }
        }
        
        return nil
    }
    
    // this version of swipe returns the discount amount for the
    // specified DiscountType
    func swipe(discount: DiscountType) -> Int {
        
        for permission in permissions {
            
            switch permission {
                
            case .discountAccess(let actualDiscount, let amount):
                if discount == actualDiscount {
                    return amount
                }
            default:
                break
            }
        }
        
        return 0
    }    
}
