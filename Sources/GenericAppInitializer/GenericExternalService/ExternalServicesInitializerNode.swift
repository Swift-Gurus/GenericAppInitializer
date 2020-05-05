//  GenericAppInitializer
//
//  Created by Alex Hmelevski on 2020-04-29.
//  Copyright © 2019 Swift Gurus. All rights reserved.
//

import Foundation
import ALResult

public struct ServiceInitializerInfo {
    public let serviceName: String
    
    public init(serviceName: String) {
        self.serviceName = serviceName
    }
}

public final class ExternalServicesHandler {
    public var didStart: ResultClosure<ServiceInitializerInfo>?
    public var didFinish: ResultClosure<ServiceInitializerInfo>?
    public var completed: ResultClosure<Bool>?
}

public protocol ExternalServicesInitializer: Chainable {
    func start(with handler: ExternalServicesHandler)
}

open class ExternalServicesInitializerNode: ExternalServicesInitializer {

    open var info: ServiceInitializerInfo { fatalError("Operation") }
    private var nextLink: ExternalServicesInitializerNode?

    public init() {}

    open func start(with handler: ExternalServicesHandler) {
        guard let next = nextLink else {
            handler.completed?(.success(true))
            return
        }
        next.start(with: handler)
    }
}
