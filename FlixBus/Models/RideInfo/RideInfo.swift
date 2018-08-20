//
//  RideInfo.swift
//  FlixBus
//
//  Created by Jitendra on 29/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

struct RideInfo: Decodable {
    
    let id: String
    
    let throughStations: String
    
    let lineCode: String
    
    let direction: String
    
    let dateTime: DateTime
    
    let route: [Station]
    
    enum CodingKeys: String, CodingKey {
        case id = "trip_uid"
        case throughStations = "through_the_stations"
        case lineCode = "line_code"
        case direction = "direction"
        case dateTime = "datetime"
        case route = "route"
    }
}
