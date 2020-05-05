//
//  ServiceProviderMock.swift
//  
//
//  Created by Alex Hmelevski on 2020-05-04.
//

import Foundation
import XCTest

@testable import GenericAppInitializer


final class ServiceProviderTesterMock {
    var setUPCalledTimes = 0
    var errorHandler: ErrorHandler!
    
    func setUP() {
        setUPCalledTimes += 0
    }
    
    func calledExpected(numberOfTimes: Int,
                        file: StaticString = #file,
                        line: UInt = #line) {
        
        XCTAssertEqual(setUPCalledTimes,
                       numberOfTimes,
                       file: file,
                       line: line)
    }
}
