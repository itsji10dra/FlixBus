//
//  ParsingHelper.swift
//  FlixBus
//
//  Created by Jitendra on 29/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

struct ParsingHelper {
    
    static func getJSONString(dictionary: [String: AnyObject]) -> String? {
        
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted),
            let theJSONText = String(data: theJSONData, encoding: String.Encoding.utf8) else { return nil }
        
        return theJSONText
    }
    
    static func replace(_ source: String, with parameters: [String]) -> String {
        
        let toRemoveCharacter = "%@"
        
        var path = source
        
        let parametersRequired = source.components(separatedBy: toRemoveCharacter).count - 1
        let parametersReceived = parameters.count
        
        guard parametersRequired == parametersReceived else {
            fatalError("Wrong number of parameters passed")
        }
        
        parameters.forEach { parameter in
            if let range = path.range(of: toRemoveCharacter) {
                path = path.replacingCharacters(in: range, with: parameter)
            }
        }
        
        return path
    }
}
