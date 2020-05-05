//  GenericAppInitializer
//
//  Created by Alex Hmelevski on 2020-04-29.
//  Copyright © 2019 Swift Gurus. All rights reserved.
//

import Foundation

public protocol TestingValueProvidable {
    var isTesting: Bool { get }
}

public protocol DictionaryInitializable {
    init(dictionary: [String: Any])
}

final class GenericLaunchEnvReader<T: DictionaryInitializable & TestingValueProvidable> {
    
    private let decoder = JSONDecoder()
    
    private var infoDictionary: [String: Any] {
        ProcessInfo.processInfo.environment
    }
    
    var launchEnvironment: T {
        .init(dictionary: infoDictionary)
    }
}
