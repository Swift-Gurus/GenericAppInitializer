//  GenericAppInitializer
//
//  Created by Alex Hmelevski on 2020-04-29.
//  Copyright © 2019 Swift Gurus. All rights reserved.
//

import Foundation

public protocol TargetTypeProvider {
    associatedtype T: Equatable
    init()
    func type(for bundleID: String) -> T
}

public protocol TargetReader {
    associatedtype TargetType
    var targetType: TargetType { get }
}

final class GenericProjectTargetReader<TypeProvider: TargetTypeProvider>: TargetReader {
    typealias TargetType = TypeProvider.T

    var currentBundle = Bundle(for: GenericProjectTargetReader<TypeProvider>.self)
    let targetProvider = TypeProvider()

    public init() {}
    var targetType: TargetType {
        let bundleID = currentBundle.bundleIdentifier ?? ""
        return targetProvider.type(for: bundleID)
    }
}
