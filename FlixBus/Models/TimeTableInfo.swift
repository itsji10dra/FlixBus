//
//  TimeTableInfo.swift
//  FlixBus
//
//  Created by Jitendra on 29/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import ObjectMapper

struct TimeTableInfo: Mappable {
    
    var throughStations: String?
    
    var lineCode: String?
    
    var lineDirection: String?
    
    var dateTimeInfo: DateTime?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        throughStations     <- map["through_the_stations"]
        lineCode            <- map["line_code"]
        lineDirection       <- map["line_direction"]
        dateTimeInfo        <- map["datetime"]
    }
}

struct DateTime: Mappable {
    
    var timeStamp: Int64?
    
    var timeZone: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        timeStamp       <- map["timestamp"]
        timeZone        <- map["tz"]
    }
}
