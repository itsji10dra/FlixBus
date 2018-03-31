//
//  TimeZoneService.swift
//  FlixBus
//
//  Created by Jitendra on 01/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation

struct TimeZoneService {
    
    static func timeZone(offset: String?) -> TimeZone? {
        
        guard var offset = offset else { return nil }
        
        offset.removeFirst(3)       //Removing prefix
        
        guard offset.hasPrefix("+") || offset.hasPrefix("-") else { return nil }
        
        let trimmingCharacters: (String) -> (String) = {
            let trimmingCharacterSet = CharacterSet(charactersIn: "+-")
            return $0.trimmingCharacters(in: trimmingCharacterSet)
        }
        
        let isPlus = offset.hasPrefix("+")
        let timeDifferenceInHour = trimmingCharacters(offset)
        let split = timeDifferenceInHour.split(separator: ":")
        
        guard split.count == 2,
            let hours = Int(split.first ?? ""),
            let minutes = Int(split.last ?? "") else { return nil }
        
        let timeDifferenceInSeconds = (hours * 3600) + (minutes * 60)
        let signTimeDifferenceInSeconds = (isPlus == true) ? timeDifferenceInSeconds : -timeDifferenceInSeconds
        return TimeZone(secondsFromGMT: signTimeDifferenceInSeconds)
    }
}
