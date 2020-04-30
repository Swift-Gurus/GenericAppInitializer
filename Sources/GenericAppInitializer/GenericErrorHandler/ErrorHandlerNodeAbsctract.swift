//
//  ErrorHandlerNodeAbsctract.swift
//  mCrew
//
//  Created by Alex Hmelevski on 2020-03-04.
//  Copyright © 2020 Aldo Group Inc. All rights reserved.
//

import Foundation

public protocol ErrorHandler {
    func catchError(_ error: Error)
}

class ErrorHandlerNodeAbsctract: ErrorHandler {

    func catchError(_ error: Error) {
        guard let node = next else {
            assertionFailure("Unhandled error \(error.localizedDescription)")
            return
        }
        node.catchError(error)
    }
}

extension ErrorHandlerNodeAbsctract: Chainable {}
