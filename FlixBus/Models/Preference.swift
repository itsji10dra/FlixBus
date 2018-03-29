//
//  Preference.swift
//  FlixBus
//
//  Created by Jitendra on 29/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation

enum PreferenceOptions: Int {
    case showArrivalsFirst = 0
    case showDepartureFirst = 1
    
    var stringValue: String {
        switch self {
        case .showArrivalsFirst:
            return "Show Arrivals at top."
        case .showDepartureFirst:
            return "Show Departure at top."
        }
    }
}

struct Preference {
    
    static var defaultPreference: PreferenceOptions {
        set {
            UserDefaults.standard.set(defaultPreference.rawValue, forKey: "PreferenceOptions")
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
