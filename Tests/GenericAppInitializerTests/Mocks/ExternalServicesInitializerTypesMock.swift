//
//  ExternalServicesInitializerTypesMock.swift
//  
//
//  Created by Alex Hmelevski on 2020-05-04.
//

import Foundation
import XCTest
@testable import GenericAppInitializer

final class ExternalServicesInitializerTypesMock: ExternalServicesInitializerNode {
    var startCount = 0
    override var info: ServiceInitializerInfo { .init(serviceName: "test") }

    override func start(with handler: ExternalServicesHandler) {
        super.start(with: handler)
        startCount += 1
    }
    
    func calledExpected(numberOfTimes: Int,
                         file: StaticString = #file,
                         line: UInt = #line) {
         
         XCTAssertEqual(startCount,
                        numberOfTimes,
                        file: file,
                        line: line)
     }
    
}
