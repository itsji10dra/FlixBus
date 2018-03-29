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
}
