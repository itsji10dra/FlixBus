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
    typealias Identity = String
    var identity: String {
        return tripId ?? ""
    }
    
    static func ==(lhs: TimeTableInfo, rhs: TimeTableInfo) -> Bool {
        return lhs.tripId == rhs.tripId
    }
}
