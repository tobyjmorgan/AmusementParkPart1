//
//  AccessPermission.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/16/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

enum Area {
    case amusements
    case kitchen
    case rideControl
    case maintenance
    case office
}

enum RidePriority {
    case standard
    case skipLines
}

enum Discount {
    case food
    case merchandise
}

enum AccessPermission {
    case areaAccess(Area)
    case rideAccess(RidePriority)
    case discountAccess(Discount, Int)
}
