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

    static private func getFilledResourcePath(_ path: ResourcePath, parameters: [String]) -> String {

        let toRemoveCharacter = "%@"
        
        var stringPath = path.rawValue
        
        let parametersRequired = path.rawValue.components(separatedBy: toRemoveCharacter).count - 1
        let parametersReceived = parameters.count

        guard parametersRequired == parametersReceived else {
            fatalError("Wrong number of parameters passed")
        }
        
        parameters.forEach { parameter in
            if let range = stringPath.range(of: toRemoveCharacter) {
                stringPath = stringPath.replacingCharacters(in: range, with: parameter)
            }
        }
        
        return stringPath
    }
    
    // MARK: - Public
    
    static public func getURL(forResource path: ResourcePath, parameters: [String]) -> String {
        return url + getFilledResourcePath(.timeTable, parameters: parameters)
    }
    
    static public func getHeaders() -> [String: String] {
        return [Header.apiAuthentication.rawValue: Configuration.authenticationToken]
    }
}
