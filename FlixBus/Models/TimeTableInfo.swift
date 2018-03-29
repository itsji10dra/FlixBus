//
//  TimeTableInfo.swift
//  FlixBus
//
//  Created by Jitendra on 29/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import ObjectMapper

struct TimeTableInfo: Mappable {
    
    private(set) var rideId: Int64?
    
    var throughStations: String?
    
    var lineCode: String?
    
    var direction: String?
    
    var dateTimeInfo: DateTime?
    
    var routeInfo: [RouteInfo]?
    
    // MARK: - Mappable

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

    internal func getLocalTime() -> String? {
        
        guard let timeStamp = timeStamp else { return nil }
        
        let timeInterval = TimeInterval(timeStamp)
        
        let date = Date(timeIntervalSince1970: timeInterval)
        
        let stringDate = Date.string(from: date, format: .HH_colon_mm)
        
        return stringDate
    }
}
