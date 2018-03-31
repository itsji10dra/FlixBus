//
//  TimeTableInfo.swift
//  FlixBus
//
//  Created by Jitendra on 29/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import ObjectMapper

struct TimeTableInfo: Mappable {
    
    private(set) var tripId: String?
    
    var throughStations: String?
    
    var lineCode: String?
    
    var direction: String?
    
    var dateTimeInfo: DateTime?
    
    var routeInfo: [RouteInfo]?
    
    // MARK: - Mappable

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        tripId              <- map["trip_uid"]
        throughStations     <- map["through_the_stations"]
        lineCode            <- map["line_code"]
        direction           <- map["direction"]
        dateTimeInfo        <- map["datetime"]
        routeInfo           <- map["route"]
    }
}
