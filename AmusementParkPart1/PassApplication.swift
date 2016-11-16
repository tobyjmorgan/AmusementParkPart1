//
//  PassApplication.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/16/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

struct ApplicantDetails {
    var firstName: String?
    var lastName: String?
    var dateOfBirth: Date?
    var street: String?
    var city: String?
    var state: String?
    var zipCode: Int?
}

enum GuestType {
    case classic
    case vip
    case freeChild
}

enum EmployeeType {
    case hourlyFoodServices
    case hourlyRideServices
    case hourlyMaintenance
}

enum EntrantType {
    case guest(GuestType)
    case employee(EmployeeType)
    case manager
}
