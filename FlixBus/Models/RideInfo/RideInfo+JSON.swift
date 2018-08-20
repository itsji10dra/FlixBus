//
//  RideInfo+Data.swift
//  FlixBus
//
//  Created by Jitendra on 29/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation

extension RideInfo {
    
    static func parse(_ data: Data) -> [JourneyType: [RideInfo]] {
        
        let decoder = JSONDecoder()
        
        let decodedResponse = try? decoder.decode(Response.self, from: data)

        guard let response = decodedResponse else { return [:] }
        
        return [.arrival: response.timetable.arrivals,
                .departure: response.timetable.departures]
    }
}
