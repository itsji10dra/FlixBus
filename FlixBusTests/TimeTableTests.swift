//
//  TimeTableTests.swift
//  FlixBusTests
//
//  Created by Jitendra on 01/04/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import FlixBus

class TimeTableTests: XCTestCase {
    
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
        var timeTableJSONString = "{\"trip_uid\":\"548\",\"through_the_stations\":\"ABC->XYZ\",\"line_code\":\"L647\",\"direction\":\"South\",\"datetime\":{\"timestamp\":12345321,\"tz\":\"GMT +02:00\"}}"
        
        guard let timeTable1 = Mapper<TimeTableInfo>().map(JSONString: timeTableJSONString) else {
            XCTAssert(true, "Nil Values Found")
            return
        }
        
        XCTAssertEqual(timeTable1.tripId, "548")
        XCTAssertEqual(timeTable1.throughStations, "ABC->XYZ")
        XCTAssertEqual(timeTable1.lineCode, "L647")
        XCTAssertEqual(timeTable1.direction, "South")
        XCTAssertNotNil(timeTable1.dateTimeInfo)
        
        //--------- Case 2 ---------//
        let expectedDate = Date(timeIntervalSince1970: 12345321)
        let expectedDateString = Date.string(from: expectedDate, format: .dd_space_MMM_comma_space_yy_space_I_space_EE)
        let receivedDateString = timeTable1.dateTimeInfo?.getLocalTime(.dd_space_MMM_comma_space_yy_space_I_space_EE)
        XCTAssertEqual(expectedDateString, receivedDateString)
        
        timeTableJSONString = "{\"trip_uid\":\"8644362892\",\"line_code\":\"L667\",\"direction\":\"North\",\"route\":[]}"
        
        guard let timeTable2 = Mapper<TimeTableInfo>().map(JSONString: timeTableJSONString) else {
            XCTAssert(true, "Nil Values Found")
            return
        }
        
        XCTAssertEqual(timeTable2.tripId, "8644362892")
        XCTAssertNil(timeTable2.throughStations)
        XCTAssertEqual(timeTable2.lineCode, "L667")
        XCTAssertEqual(timeTable2.direction, "North")
        XCTAssertNotNil(timeTable2.routeInfo)
        XCTAssertTrue(timeTable2.routeInfo!.isEmpty)
    }
}
