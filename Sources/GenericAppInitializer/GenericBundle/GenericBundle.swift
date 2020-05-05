//  GenericAppInitializer
//
//  Created by Alex Hmelevski on 2020-04-29.
//  Copyright © 2019 Swift Gurus. All rights reserved.
//

import Foundation


public protocol GenericBundle {
    /// Returns Path for the resource where:
    /// - Parameters:
    ///   - name: Name of the resource to be strong typed instead of a string
    ///   - type: Type of the resource to be strong typed instead of a string
    /// - Returns: Optional<String>
    func getPath<Name, Type>(forResourceName name: Name, ofType type: Type) -> String? where
           Name: RawRepresentable, Name.RawValue: StringProtocol,
           Type: RawRepresentable, Type.RawValue: StringProtocol
    
    /// Returns value from a bundle.
    /// - Parameter key: Key as a strong type instead of a string
    /// - Returns: String or an empty string
    func getInfoValue<Key>(forKey key: Key) -> String where Key: RawRepresentable, Key.RawValue: StringProtocol
}



/// Class that provides High-level API working with bundle
final class GenericBundleImp: GenericBundle {
    let bundle: Bundle

    init() {
        self.bundle = Bundle(for: Self.self)
    }

    /// Returns Path for the resource where:
    /// - Parameters:
    ///   - name: Name of the resource to be strong typed instead of a string
    ///   - type: Type of the resource to be strong typed instead of a string
    /// - Returns: Optional<String>
    func getPath<Name, Type>(forResourceName name: Name, ofType type: Type) -> String?  where
        Name: RawRepresentable, Name.RawValue: StringProtocol,
        Type: RawRepresentable, Type.RawValue: StringProtocol {
        bundle.path(forResource: String(name.rawValue), ofType: String(type.rawValue))
    }

    
    /// Returns value from a bundle.
    /// - Parameter key: Key as a strong type instead of a string
    /// - Returns: String or an empty string if not found
    func getInfoValue<Key>(forKey key: Key) -> String where Key: RawRepresentable, Key.RawValue: StringProtocol {
        return bundle.infoDictionary?[String(key.rawValue)] as? String ?? ""
    }

}
