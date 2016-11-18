//
//  Pass.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/16/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

class Pass: ReswipeCheckable {

    let permissions: [AccessPermission]
    let entrant: ApplicantDetails
    let entrantType: EntrantType
    
    init(permissions: [AccessPermission], entrant: ApplicantDetails, entrantType: EntrantType) {
        self.permissions = permissions
        self.entrant = entrant
        self.entrantType = entrantType
    }

    
    
    
    ////////////////////////////////////
    // Mark: for protocol CanDoReswipeCheck
    
    // if the pass is swiped again within 60 seconds, it is considered a reswipe
    let thresholdForReswipe: TimeInterval = 60
    
    // setting the last swipe to distant past initially
    var lastSwipeTime: Date = Date.distantPast

    func isTryingToReswipe() -> Bool {
        
        // make a temporary copy of the last time this pass was swiped for ride access
        let tempLastSwipe = lastSwipeTime
        
        // update lastSwipeTime to now, ready for any future checks
        lastSwipeTime = Date()
        
        // return true if the interval between this swipe and the last swipe is less than our threshold
        if Date().timeIntervalSince1970 - tempLastSwipe.timeIntervalSince1970 < thresholdForReswipe {
            
            return true
        }
        
        return false
    }
}
