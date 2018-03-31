//
//  DateTime.swift
//  FlixBus
//
//  Created by Jitendra on 01/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import ObjectMapper

struct DateTime: Mappable {
    
    private var timeStamp: Int64?
    
    private var timeZone: String?
    
    // MARK: - Mappable
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        timeStamp       <- map["timestamp"]
        timeZone        <- map["tz"]
    }
    
    // MARK: - Internal Methods
    
    internal func getLocalTime(_ format: Date.Format) -> String? {
        
        guard let timeStamp = timeStamp else { return nil }
        
        let timeInterval = TimeInterval(timeStamp)
        
        let date = Date(timeIntervalSince1970: timeInterval)
        
        let timezone = TimeZoneService.timeZone(offset: self.timeZone) ?? .current
        
        let stringDate = Date.string(from: date, format: format, timeZone: timezone)
        
        return stringDate
    }
}
