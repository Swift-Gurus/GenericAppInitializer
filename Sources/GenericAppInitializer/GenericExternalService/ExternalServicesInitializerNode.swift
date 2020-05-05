//  GenericAppInitializer
//
//  Created by Alex Hmelevski on 2020-04-29.
//  Copyright © 2019 Swift Gurus. All rights reserved.
//

import Foundation
import ALResult

struct ServiceInitializerInfo {
    var serviceName: String
}

public final class ExternalServicesHandler {
    var didStart: ResultClosure<ServiceInitializerInfo>?
    var didFinish: ResultClosure<ServiceInitializerInfo>?
    var completed: ResultClosure<Bool>?
}

public protocol ExternalServicesInitializer: Chainable {
    func start(with handler: ExternalServicesHandler)
}

public class ExternalServicesInitializerNode: ExternalServicesInitializer {

    var serviceInitializerName: String { fatalError("Operation") }
    private var nextLink: ExternalServicesInitializerNode?

    public init() {}

    public func start(with handler: ExternalServicesHandler) {
        guard let next = nextLink else {
            handler.completed?(.success(true))
            return
        }
        next.start(with: handler)
    }
}
