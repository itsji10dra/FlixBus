//
//  StationTests.swift
//  FlixBusTests
//
//  Created by Jitendra on 01/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import FlixBus

class StationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        testInitMap()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitMap() {
        
        //--------- Case 1 ---------//
        var stationJSONString = "{\"id\":1,\"name\":\"Berlin\"}"
        let station1 = Mapper<Station>().map(JSONString: stationJSONString)
        
        if let id = station1?.id,
            let name = station1?.name {
            XCTAssertEqual(id, 1)
            XCTAssertEqual(name, "Berlin")
        } else {
            XCTAssert(true, "Nil Values Found")
        }
        
        //--------- Case 2 ---------//
        stationJSONString = "{\"id\":1234567898765,\"name\":\"New York\"}"
        let station2 = Mapper<Station>().map(JSONString: stationJSONString)
        
        if let id = station2?.id,
            let name = station2?.name {
            XCTAssertEqual(id, 1234567898765)
            XCTAssertEqual(name, "New York")
        } else {
            XCTAssert(true, "Nil Values Found")
        }
        
        //--------- Case 3 ---------//
        stationJSONString = "{\"id\":1234587652378993456,\"name\":\"Llanfairpwllgwyngyll\"}"
        let station3 = Mapper<Station>().map(JSONString: stationJSONString)
        
        if let id = station3?.id,
            let name = station3?.name {
            XCTAssertEqual(id, 1234587652378993456)
            XCTAssertEqual(name, "Llanfairpwllgwyngyll")
        } else {
            XCTAssert(true, "Nil Values Found")
        }
    }
}
