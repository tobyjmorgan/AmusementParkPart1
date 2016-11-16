//
//  Describable.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/16/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

protocol Describable {
    func description() -> String
}

extension AccessPermission: Describable {
    func description() -> String {
        switch self {
        case .areaAccess(let area):
            return "Area Access: \(area)"
        case .rideAccess(let priority):
            return "Ride Access: \(priority)"
        case .discountAccess(let discount, let amount):
            return "Discount: \(discount) \(amount)%"
        }
    }
}
