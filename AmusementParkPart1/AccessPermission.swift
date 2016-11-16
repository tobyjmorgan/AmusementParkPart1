//
//  AccessPermission.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/16/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

enum Area: String {
    case amusements
    case kitchen
    case rideControl
    case maintenance
    case office
}

enum RidePriority: String {
    case standard
    case skipLines
}

enum Discount: String {
    case food
    case merchandise
}

enum AccessPermission {
    case areaAccess(Area)
    case rideAccess(RidePriority)
    case discountAccess(Discount, Int)
}
