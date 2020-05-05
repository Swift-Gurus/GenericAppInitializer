//  GenericAppInitializer
//
//  Created by Alex Hmelevski on 2020-04-29.
//  Copyright © 2019 Swift Gurus. All rights reserved.
//
import Foundation

open class ErrorHandlerNodeTemplate: ErrorHandlerNodeAbsctract {

    open var errorTypes: [Error.Type] {
        fatalError("ABSCTRACT CLASS")
    }

    open override func catchError(_ error: Error) {
        guard canProccess(error) else {
            super.catchError(error)
            return
        }

        proccessError(error)
    }

    open func proccessError(_ error: Error) {
        fatalError("ABSCTRACT CLASS")
    }

    open func canProccess(_ error: Error) -> Bool {
         let typeOfError  = type(of: error)
         return errorTypes.contains(where: { $0 == typeOfError })
    }
}
