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
    
    func printPermissions() {
        for permission in permissions {
            print(permission.description())
        }
    }
    
    func swipeToGetAllPermissions() -> [AccessPermission] {
        return permissions
    }
    
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
    
    func swipe(has access: AccessPermission) -> Bool {
        
        for permission in permissions {
            
            if access == permission {
                return true
            }
        }
        
        return false
    }
    
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
    
    func swipe(discount: Discount) -> Int {
        
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
