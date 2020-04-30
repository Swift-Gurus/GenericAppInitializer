//
//  GenericProjectTargetReader.swift
//  mCrew
//
//  Created by Alex Hmelevski on 2020-04-29.
//  Copyright © 2020 Aldo Group Inc. All rights reserved.
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
        guard let bundleID = currentBundle.bundleIdentifier else { fatalError("Couldn't not match enviroment") }
        return targetProvider.type(for: bundleID)
    }
}
