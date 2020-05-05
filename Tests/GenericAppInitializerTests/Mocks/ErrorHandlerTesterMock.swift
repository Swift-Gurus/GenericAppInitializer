//
//  ErrorHandlerTesterMock.swift
//  
//
//  Created by Alex Hmelevski on 2020-05-04.
//

import Foundation
import XCTest
@testable import GenericAppInitializer

struct MyError: LocalizedError {
    let errorDescription: String?
    
    static var `default`: Self {
        .init(errorDescription: "DEFAULT ERROR")
    }
}

final class ErrorHandlerTesterMock: ErrorHandlerNodeTemplate {
    
    var catchErrorCount = 0
    var proccessErrors: [Error] = []
    override var errorTypes: [Error.Type] {
       [MyError.self]
    }
    
    override func catchError(_ error: Error) {
        catchErrorCount += 1
        super.catchError(error)
    }
    
    override func proccessError(_ error: Error) {
        proccessErrors.append(error)
    }
    
    func checkCatchErrorCalled(expectedNumberOfTimes: Int,
                               file: StaticString = #file,
                               line: UInt = #line) {
        XCTAssertEqual(expectedNumberOfTimes,
                       catchErrorCount,
                       file: file,
                       line: line)
    }
    
    func checkErrorsAreOfType<T: Error>(_ type: T.Type,
                                        file: StaticString = #file,
                                        line: UInt = #line) {
        XCTAssertNotNil(proccessErrors as? [T],
                        file: file,
                        line: line)
    }
}
