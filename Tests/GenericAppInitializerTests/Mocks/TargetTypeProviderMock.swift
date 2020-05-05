//
//  TargetTypeProviderMock.swift
//  
//
//  Created by Alex Hmelevski on 2020-05-04.
//

import Foundation
@testable import GenericAppInitializer
enum Target {
    case dev
    case prod
}

struct TargetTypeProviderMock: TargetTypeProvider {
    typealias T = Target
    
    func type(for bundleID: String) -> Target {
         .dev
    }
}
