//
//  TimeTableInfo.swift
//  FlixBus
//
//  Created by Jitendra on 29/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import ObjectMapper

struct TimeTableInfo: Mappable {
    
    var rideId: Int64?
    
    var throughStations: String?
    
    var lineCode: String?
    
    var direction: String?
    
    var dateTimeInfo: DateTime?
    
    var routeInfo: [RouteInfo]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        rideId              <- map["ride_id"]
        throughStations     <- map["through_the_stations"]
        lineCode            <- map["line_code"]
        direction           <- map["direction"]
        dateTimeInfo        <- map["datetime"]
        routeInfo           <- map["route"]
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
