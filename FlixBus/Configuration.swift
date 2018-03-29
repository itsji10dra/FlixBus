//
//  Configuration.swift
//  FlixBus
//
//  Created by Jitendra on 28/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

enum Header: String {
    case apiAuthentication = "X-API-Authentication"
}

enum ResourcePath: String {
    case timeTable = "/mobile/v1/network/station/%@/timetable"
}

struct Configuration {

    // MARK: - Private

    static private let url = "http://api.mobile.staging.mfb.io"

    static private let authenticationToken = "intervIEW_TOK3n"
    
    // MARK: - Public
    
    static public func getURL(forResource path: ResourcePath, parameters: [String]) -> String {
        return url + ParsingHelper.replace(path.rawValue, with: parameters)
    }
    
    static public func getHeaders() -> [String: String] {
        return [Header.apiAuthentication.rawValue: authenticationToken]
    }
}
