//
//  DingsOrBuzzes.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/17/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

protocol DingsOrBuzzes {
    func playDingSound()
    func playBuzzSound()
}

extension DingsOrBuzzes {
    func playDingSound() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SoundManager.notificationPlayDingSound), object: nil)
    }
    
    func playBuzzSound() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SoundManager.notificationPlayBuzzSound), object: nil)
    }
}

