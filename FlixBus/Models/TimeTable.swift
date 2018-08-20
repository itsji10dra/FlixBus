//
//  TimeTable.swift
//  FlixBus
//
//  Created by Jitendra on 20/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

struct TimeTable: Decodable {

    let message: String
    
    let arrivals: [RideInfo]
    
    let departures: [RideInfo]
}
