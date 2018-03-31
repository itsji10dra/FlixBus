//
//  Coordinates.swift
//  FlixBus
//
//  Created by Jitendra on 01/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import ObjectMapper

struct Coordinates: Mappable {
    
    var latitude: Double?
    
    var longitude: Double?
    
    // MARK: - Mappable
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        latitude        <- map["latitude"]
        longitude       <- map["longitude"]
    }
}

