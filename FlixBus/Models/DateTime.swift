//
//  DateTime.swift
//  FlixBus
//
//  Created by Jitendra on 01/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation

struct DateTime: Decodable {
    
    let timeStamp: Int64
    
    let timeZone: String
    
    enum CodingKeys: String, CodingKey {
        case timeStamp = "timestamp"
        case timeZone = "tz"
    }

    internal func getLocalTime(_ format: Date.Format) -> String? {
                
        let timeInterval = TimeInterval(timeStamp)
        
        let date = Date(timeIntervalSince1970: timeInterval)
        
        let timezone = TimeZoneService.timeZone(offset: self.timeZone) ?? .current
        
        let stringDate = Date.string(from: date, format: format, timeZone: timezone)
        
        return stringDate
    }
}
