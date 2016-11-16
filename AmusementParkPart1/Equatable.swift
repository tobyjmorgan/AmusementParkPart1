//
//  Equatable.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/16/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

extension AccessPermission: Equatable {}
func ==(lhs: AccessPermission, rhs: AccessPermission) -> Bool {
    switch (lhs, rhs) {
    case (.areaAccess(let areaA), .areaAccess(let areaB)) :
        return areaA == areaB
    case (.rideAccess(let priorityA), .rideAccess(let priorityB)) :
        return priorityA == priorityB
    case  (.discountAccess(let discountA), .discountAccess(let discountB)) :
        return discountA == discountB
    default:
        return false
    }
}
