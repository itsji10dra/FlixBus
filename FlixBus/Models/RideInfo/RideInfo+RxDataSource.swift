//
//  RideInfo+RxDataSource.swift
//  FlixBus
//
//  Created by Jitendra on 29/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import RxDataSources

extension RideInfo: IdentifiableType, Equatable {
    
    // Identify is uniquely define an object
    typealias Identity = String
    
    var identity: String {
        return id
    }
    
    static func ==(lhs: RideInfo, rhs: RideInfo) -> Bool {
        return lhs.id == rhs.id
    }
}
