//
//  ExternalServicesInitializerNode.swift
//  mCrew
//
//  Created by Badreddine EL JAMALI on 2019-08-26.
//  Copyright © 2019 Aldo Group Inc. All rights reserved.
//

import Foundation

struct ServiceInitializerInfo {
    var serviceName: String
}

public final class ExternalServicesHandler {
    var didStart: Callback<ServiceInitializerInfo>?
    var didFinish: Callback<ServiceInitializerInfo>?
    var completed: Callback<Bool>?
}

public protocol ExternalServicesInitializer: Chainable {
    func start(with handler: ExternalServicesHandler)
}

public class ExternalServicesInitializerNode: ExternalServicesInitializer {

    var serviceInitializerName: String { fatalError("Operation") }
    private var nextLink: ExternalServicesInitializerNode?

    required init() {}

    public func start(with handler: ExternalServicesHandler) {
        guard let next = nextLink else {
            handler.completed?(.right(true))
            return
        }
        next.start(with: handler)
    }
}
