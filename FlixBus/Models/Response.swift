//
//  Response.swift
//  FlixBus
//
//  Created by Jitendra on 20/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

struct Response: Decodable {

    let timetable: TimeTable
    
    let station: Station
}
