//
//  LaunchEnvironmentMock.swift
//  
//
//  Created by Alex Hmelevski on 2020-05-04.
//

import Foundation
@testable import GenericAppInitializer

class LaunchEnvironmentMock: DictionaryInitializable, TestingValueProvidable {
    required init(dictionary: [String : Any]) {}
    var isTestingCount = 0
    
    var isTesting: Bool  {
        self.isTestingCount += 1
        return false
    }
}
