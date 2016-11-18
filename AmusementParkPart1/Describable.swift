//
//  Describable.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/16/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

// protocol that forces anything adopting it to be able to return
// a String representing its details
protocol Describable {
    func description() -> String
}

// extending our AccessPermission enumeration to conform to
// the Describable protocol
extension AccessPermission: Describable {
    func description() -> String {
        switch self {
        case .areaAccess(let area):
            return "Area Access: \(area)"
        case .rideAccess(let access):
            switch access {
            case .noRides:
                return "Ride Access: \(access.description())"
            case .allRides(let priority):
                return "Ride Access: \(access.description()) - \(priority)"
            }
        case .discountAccess(let discount, let amount):
            return "Discount: \(discount) \(amount)%"
        }
    }
}

// extending RideAccess so that it can describe itself
extension RideAccess: Describable {
    func description() -> String {
        switch self {
        case .noRides:
            return "No Rides"
        case .allRides(_):
            return "All Rides"
        }
    }
}

// extending Pass so that it can describe itself too
extension Pass: Describable {
    func description() -> String {
        
        var returnString: String = ""
        
        for permission in permissions {
            returnString += permission.description() + "\n"
        }
        
        return returnString
    }
}
