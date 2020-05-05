//
//  GenericSceneConfiguration.swift
//  
//
//  Created by Alex Hmelevski on 2020-05-04.
//

import Foundation

#if !os(macOS)
import SwiftUI



@available(iOS 13.0, *)
open class GenericSceneConfiguration: UISceneConfiguration {
    public let launcher: UILaunching
    public  init(name: String?,
               sessionRole: UISceneSession.Role,
               launcher: UILaunching) {
        self.launcher = launcher
        super.init(name: name, sessionRole: sessionRole)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





#endif
