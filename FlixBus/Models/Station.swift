//
//  Station.swift
//  FlixBus
//
//  Created by Jitendra on 28/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

struct Station: Decodable {
    
    let id: Int64
    
    let name: String
    
    let address: String?
    
    let fullAddress: String?
    
    let coordinates: Coordinates?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case coordinates
        case fullAddress = "full_address"
    }
}

extension Station {
    
    static func loadAllStations() -> [Station] {
        
        guard let path = Bundle.main.path(forResource: "Station", ofType: "plist"),
            let data = FileManager.default.contents(atPath: path) else { return [] }
        
        let decoder = PropertyListDecoder()
        
        let stations = try? decoder.decode([Station].self, from: data)
        
        return stations ?? []
    }
}
