//  GenericAppInitializer
//
//  Created by Alex Hmelevski on 2020-04-29.
//  Copyright © 2019 Swift Gurus. All rights reserved.
//

import Foundation

public protocol ErrorHandler: Chainable {
    func catchError(_ error: Error)
}

open class ErrorHandlerNodeAbsctract: ErrorHandler {

    public func catchError(_ error: Error) {
        guard let node = next else {
            assertionFailure("Unhandled error \(error.localizedDescription)")
            return
        }
        node.catchError(error)
    }
}


