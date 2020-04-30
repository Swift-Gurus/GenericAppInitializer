//
//  ErrorHandlerNodeTemplate.swift
//  mCrew
//
//  Created by Alex Hmelevski on 2020-03-04.
//  Copyright © 2020 Aldo Group Inc. All rights reserved.
//

import Foundation

class ErrorHandlerNodeTemplate: ErrorHandlerNodeAbsctract {

    var errorTypes: [Error.Type] {
        fatalError("ABSCTRACT CLASS")
    }

    override func catchError(_ error: Error) {
        guard canProccess(error) else {
            super.catchError(error)
            return
        }

        proccessError(error)
    }

    func proccessError(_ error: Error) {
        fatalError("ABSCTRACT CLASS")
    }

    func canProccess(_ error: Error) -> Bool {
         let typeOfError  = type(of: error)
         return errorTypes.contains(where: { $0 == typeOfError })
    }
}
