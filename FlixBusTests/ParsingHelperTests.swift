//
//  ParsingHelperTests.swift
//  FlixBusTests
//
//  Created by Jitendra on 30/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import XCTest
@testable import FlixBus

class ParsingHelperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        testGetJSONString()
        testReplaceParameters()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetJSONString() {
        
        let bundle = Bundle(for: type(of: self))
        
        XCTAssertNotNil(bundle)
        
        guard let path = bundle.path(forResource: "test", ofType: "json"),
            let data = FileManager.default.contents(atPath: path),
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else { return }
        
        XCTAssertTrue(JSONSerialization.isValidJSONObject(json))
        
        let expectedJsonString = """
{
  "glossary" : {
    "title" : "example glossary",
    "GlossDiv" : {
      "title" : "S",
      "GlossList" : {
        "GlossEntry" : {
          "SortAs" : "SGML",
          "Abbrev" : "ISO 8879:1986",
          "GlossTerm" : "Standard Generalized Markup Language",
          "GlossDef" : {
            "GlossSeeAlso" : [
              "GML",
              "XML"
            ],
            "para" : "A meta-markup language, used to create markup languages such as DocBook."
          },
          "GlossSee" : "markup",
          "ID" : "SGML",
          "Acronym" : "SGML"
        }
      }
    }
  }
}
"""

        guard let jsonDictionary = json as? [String: AnyObject],
            let jsonString = ParsingHelper.getJSONString(dictionary: jsonDictionary) else { return }
        
        XCTAssertEqual(jsonString, expectedJsonString)
    }
    
    func testReplaceParameters() {

        //--------- Case 1 ---------//
        var source = "Hello %@ name if John Doe"
        var parameters = ["is"]
        var expectedOutput = "Hello is name if John Doe"
        var output = ParsingHelper.replace(source, with: parameters)
        XCTAssertEqual(output, expectedOutput)
        
        //--------- Case 2 ---------//
        source = "/mobile/v1/network/station/%@/timetable"
        parameters = ["12"]
        expectedOutput = "/mobile/v1/network/station/12/timetable"
        output = ParsingHelper.replace(source, with: parameters)
        XCTAssertEqual(output, expectedOutput)

        //--------- Case 3 ---------//
        source = "/mobile/%@/network/station/%@/timetable"
        parameters = ["v1", "12"]
        expectedOutput = "/mobile/v1/network/station/12/timetable"
        output = ParsingHelper.replace(source, with: parameters)
        XCTAssertEqual(output, expectedOutput)
        
        //--------- Case 4 ---------//
        source = "%@-12-$-&-%@"
        parameters = ["ABC", "XYZ"]
        expectedOutput = "ABC-12-$-&-XYZ"
        output = ParsingHelper.replace(source, with: parameters)
        XCTAssertEqual(output, expectedOutput)
        
        //--------- Case 5 ---------//
        source = "%@"
        parameters = ["5"]
        expectedOutput = "5"
        output = ParsingHelper.replace(source, with: parameters)
        XCTAssertEqual(output, expectedOutput)
        
        //--------- Case 6 ---------//
        source = "/mobile/%@/network/station/%@/timetable/%@"
        parameters = ["5", "6", "7"]
        expectedOutput = "/mobile/5/network/station/6/timetable/7"
        output = ParsingHelper.replace(source, with: parameters)
        XCTAssertEqual(output, expectedOutput)
    }
}
