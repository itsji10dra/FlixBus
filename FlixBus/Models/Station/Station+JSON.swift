//
//  Station+JSON.swift
//  FlixBus
//
//  Created by Jitendra on 29/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit
import ObjectMapper

extension Station {
    
    static func loadAllStations() -> [Station] {
        
        var format =  PropertyListSerialization.PropertyListFormat.xml

        guard let path = Bundle.main.path(forResource: "Station", ofType: "plist"),
            let data = FileManager.default.contents(atPath: path),
            let dictionary = try? PropertyListSerialization.propertyList(from: data,
                                                                         options: .mutableContainersAndLeaves,
                                                                         format: &format) else { return [] }
        
        guard let jsonArray = dictionary as? [[String: AnyObject]] else { return [] }
        
        var stations: [Station] = []
        
        jsonArray.forEach { jsonObject in
            if let jsonText = ParsingHelper.getJSONString(dictionary: jsonObject),
                let infoObj = Mapper<Station>().map(JSONString: jsonText) {
                stations.append(infoObj)
            }
        }
        
        return stations
    }
}
