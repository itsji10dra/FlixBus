//
//  ServerConfiguration.swift
//  FlixBus
//
//  Created by Jitendra on 28/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

enum Header: String {
    case apiAuthentication = "X-Api-Authentication"
}

enum ResourcePath: String {
    case timeTable = "/mobile/v1/network/station/%@/timetable/"
}

struct Configuration {
    
    static let url = "http://api.mobile.staging.mfb.io"

    static let authenticationToken = "intervIEW_TOK3n"
    
    static func getFilledResourcePath(_ path: ResourcePath, parameters: [String]) -> String {
        
        let toRemoveCharacter = "%@"
        
        var stringPath = path.rawValue
        
        let parametersRequired = path.rawValue.components(separatedBy: toRemoveCharacter).count - 1
        let parametersReceived = parameters.count
        
        guard parametersRequired == parametersReceived else {
            fatalError("Wrong number of paramters passed")
        }
        
        parameters.forEach { parameter in
            if let range = stringPath.range(of: toRemoveCharacter) {
                stringPath = stringPath.replacingCharacters(in: range, with: parameter)
            }
        }
        
        return stringPath
    }
}
