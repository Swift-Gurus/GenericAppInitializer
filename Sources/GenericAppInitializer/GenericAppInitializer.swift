//
//  GenericAppInitializer.swift
//  mCrew
//
//  Created by Alex Hmelevski on 2020-04-29.
//  Copyright © 2020 Aldo Group Inc. All rights reserved.
//

import Foundation

open class GenericAppInitializer<TypeProvider: TargetTypeProvider, ServiceProvider> {
    let currentTargetReader = GenericProjectTargetReader<TypeProvider>()
    let launchEnvironmentReader = LaunchEnvironmentReader()
    public let window: UIWindow
    public var serviceProvider: ServiceProvider!

    public var currentTarget: TypeProvider.T {
        currentTargetReader.targetType
    }
    init(window: UIWindow) {
        self.window = window
    }

    open func getServiceProvider(testing: Bool) -> ServiceProvider {
        fatalError("ABSCTRACT CLASSES ")
    }

    open func getExternalServicesInitializerTypes(for target: TypeProvider.T) -> [ExternalServicesInitializerNode] {
        fatalError("ABSCTRACT CLASSES")
    }

    open func initialViewControlller(forTarget target: TypeProvider.T,
                                     environment: LaunchEnvironment) -> UIViewController {
        fatalError("ABSCTRACT CLASSES")
    }

    public func start() {
        startServices(completion: { [weak self] _ in
            self?.processServicesResponse()
        })
    }

    private func startServices(completion: @escaping Closure<Bool>) {
        let types = getExternalServicesInitializerTypes(for: currentTarget)
        let chain = getExternalInitializerChain(using: types)
        let handler = ExternalServicesHandler()
        handler.completed = { (result) in
            result.do(work: completion)
        }
        chain.start(with: handler)
    }

    private func processServicesResponse() {
        createServiceProvider()
        launchUI()
    }

    private func launchUI() {

        window.rootViewController = initialViewControlller(forTarget: currentTarget,
                                                           environment: launchEnvironmentReader.launchEnvironment)
        window.makeKeyAndVisible()
    }

    private func createServiceProvider() {
        serviceProvider = getServiceProvider(testing: launchEnvironmentReader.launchEnvironment.isTesting)
    }

    private func getExternalInitializerChain(using types: [ExternalServicesInitializerNode]) -> ExternalServicesInitializer {
        return ExternalServicesInitializerNode.createChain(from: types)
    }
}

