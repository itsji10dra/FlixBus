//
//  TimeTableInfo+Data.swift
//  FlixBus
//
//  Created by Jitendra on 29/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import ObjectMapper

extension TimeTableInfo {
    
    static func parse(_ json: Any) -> [JourneyType: [TimeTableInfo]] {
        
        var journeyInfo: [JourneyType: [TimeTableInfo]] = [:]
        
        if let jsonDictionary = json as? [String: AnyObject] {
            if let timeTableInfo = jsonDictionary["timetable"] {
                if let arrivals = timeTableInfo["arrivals"] as? [[String: AnyObject]] {
                    let arrivalTimeTableInfo = getTimeTableInfo(from: arrivals)
                    journeyInfo[.arrival] = arrivalTimeTableInfo
                }
                if let departures = timeTableInfo["departures"] as? [[String: AnyObject]] {
                    let departureTimeTableInfo = getTimeTableInfo(from: departures)
                    journeyInfo[.departure] = departureTimeTableInfo
                }
            }
        }
        
        return journeyInfo
    }
    
    static private func getTimeTableInfo(from infoArray: [[String: AnyObject]]) -> [TimeTableInfo] {
        
        var timeTableInfo: [TimeTableInfo] = []
        
        infoArray.forEach { info in
            if let jsonText = getJSONString(dictionary: info),
                let infoObj = Mapper<TimeTableInfo>().map(JSONString: jsonText) {
                timeTableInfo.append(infoObj)
            }
        }
        
        return timeTableInfo
    }
    
    static private func getJSONString(dictionary: [String: AnyObject]) -> String? {
        
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted),
            let theJSONText = String(data: theJSONData, encoding: String.Encoding.utf8) else { return nil }
        
        return theJSONText
    }
}
