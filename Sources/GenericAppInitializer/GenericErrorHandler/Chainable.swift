//  GenericAppInitializer
//
//  Created by Alex Hmelevski on 2020-04-29.
//  Copyright © 2019 Swift Gurus. All rights reserved.
//

import Foundation

private var ChainableKey = "ChainableKey"

public protocol Chainable { }

extension Chainable {
    // swiftlint:disable superfluous_disable_command implicit_getter
    var next: Self? {
        get {
            return objc_getAssociatedObject(self, &ChainableKey) as? Self
        }
        set {
            objc_setAssociatedObject(self, &ChainableKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }

    }

    public static func createChain(from nodes: [Self]) -> Self {
        var lastNode: Self?
        for var current in nodes.reversed() {
            current.next = lastNode
            lastNode = current
        }
        guard let node = lastNode else { fatalError("Cannot create chain") }
        return node
    }

}
