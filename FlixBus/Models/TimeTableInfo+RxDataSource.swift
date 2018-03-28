//
//  TimeTableInfo+RxDataSource.swift
//  FlixBus
//
//  Created by Jitendra on 29/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import RxDataSources

extension TimeTableInfo: IdentifiableType, Equatable {
    
    // Identify is uniquely define an object
    typealias Identity = Int64
    var identity: Int64 {
        return rideId ?? 0
    }
    
    static func ==(lhs: TimeTableInfo, rhs: TimeTableInfo) -> Bool {
        return lhs.rideId == rhs.rideId
    }
}
