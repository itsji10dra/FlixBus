//
//  Preference.swift
//  FlixBus
//
//  Created by Jitendra on 29/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation

enum PreferenceOptions: Int {
    
    case showArrivalsFirst = 1
    case showDepartureFirst = 2
    
    var stringValue: String {
        switch self {
        case .showArrivalsFirst:
            return "Show Arrivals on top"
        case .showDepartureFirst:
            return "Show Departure on top"
        }
    }
    
    var linkedJourneyType: JourneyType {
        switch self {
        case .showArrivalsFirst:
            return .arrival
        case .showDepartureFirst:
            return .departure
        }
    }
}

struct Preference {
    
    static var defaultPreference: PreferenceOptions {
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "PreferenceOptions")
        }
        get {
            let rawValue = UserDefaults.standard.integer(forKey: "PreferenceOptions")
            return PreferenceOptions(rawValue: rawValue) ?? .showDepartureFirst
        }
    }
    
    static func getPreferenceList() -> [PreferenceOptions] {
        return [.showArrivalsFirst, .showDepartureFirst]
    }
}
