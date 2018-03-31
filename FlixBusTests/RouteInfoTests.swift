//
//  RouteInfoTests.swift
//  FlixBusTests
//
//  Created by Jitendra on 01/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import FlixBus

class RouteInfoTests: XCTestCase {
    
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
        var routeJSONString = "{\"id\":548,\"name\":\"New Delhi\",\"address\":\"India\",\"coordinates\":{\"latitude\":12.32434,\"longitude\":43.32323}}"
        
        guard let route1 = Mapper<RouteInfo>().map(JSONString: routeJSONString) else {
            XCTAssert(true, "Nil Values Found")
            return
        }
        
        XCTAssertEqual(route1.routeId, 548)
        XCTAssertEqual(route1.name, "New Delhi")
        XCTAssertEqual(route1.address, "India")
        XCTAssertEqual(route1.coordinates?.latitude, 12.32434)
        XCTAssertEqual(route1.coordinates?.longitude, 43.32323)
        
        //--------- Case 2 ---------//
        routeJSONString = "{\"id\":986782,\"full_address\":\"India\",\"coordinates\":{\"latitude\":12.32434}}"
        
        guard let route2 = Mapper<RouteInfo>().map(JSONString: routeJSONString) else {
            XCTAssert(true, "Nil Values Found")
            return
        }
        
        XCTAssertEqual(route2.routeId, 986782)
        XCTAssertNil(route2.name)
        XCTAssertNil(route2.address)
        XCTAssertEqual(route2.fullAddress, "India")
        XCTAssertEqual(route2.coordinates?.latitude, 12.32434)
        XCTAssertNil(route2.coordinates?.longitude)
    }
}
