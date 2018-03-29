//
//  RouteInfo.swift
//  FlixBus
//
//  Created by Jitendra on 29/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import ObjectMapper

struct RouteInfo: Mappable {
    
    var routeId: Int64?
    
    var name: String?
    
    var address: String?
    
    var fullAddress: String?
    
    var coordinates: Coordinates?

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        routeId         <- map["id"]
        name            <- map["name"]
        address         <- map["address"]
        fullAddress     <- map["full_address"]
        coordinates     <- map["coordinates"]
    }
}

struct Coordinates: Mappable {
    
    var latitude: Double?
    
    var longitude: Double?

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        latitude        <- map["latitude"]
        longitude       <- map["longitude"]
    }
}
