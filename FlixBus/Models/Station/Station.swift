//
//  Station.swift
//  FlixBus
//
//  Created by Jitendra on 28/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import ObjectMapper

struct Station: Mappable {
    
    private(set) var id: Int?
    
    var name: String?
    
    // MARK: - Mappable
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id       <- map["id"]
        name     <- map["name"]
    }
}

