//
//  GenericAppInitializer.swift
//  GenericAppInitializer
//
//  Created by Alex Hmelevski on 2020-04-29.
//  Copyright © 2019 Swift Gurus. All rights reserved.
//

import Foundation

#if !os(macOS)
import UIKit
public typealias Window = UIWindow
public typealias Controller = UIViewController
#else
import Cocoa
public typealias Window = NSWindow
public typealias Controller = NSViewController
#endif

import ALResult

open class GenericAppInitializer<TypeProvider, ServiceProvider, Environment> where
TypeProvider: TargetTypeProvider,
Environment: DictionaryInitializable & TestingValueProvidable {
    let currentTargetReader = GenericProjectTargetReader<TypeProvider>()
    let launchEnvironmentReader = GenericLaunchEnvReader<Environment>()
    
    public let window: Window
    public var serviceProvider: ServiceProvider!
    public var bundle: GenericBundle = GenericBundleImp()
    
    public var currentTarget: TypeProvider.T {
        currentTargetReader.targetType
    }
    
    public var environment: Environment {
        launchEnvironmentReader.launchEnvironment
    }
    
    public var currentConfig: Config {
        .init(environment: environment,
              bundle: bundle,
              target: currentTarget)
    }
    
    init(window: Window) {
        self.window = window
    }

    open func getServiceProvider(config: Config,
                                 errorHandler: ErrorHandler) -> ServiceProvider {
        fatalError("ABSCTRACT CLASSES ")
    }

    open func getExternalServicesInitializerTypes(config: Config,
                                                  errorHandler: ErrorHandler) -> [ExternalServicesInitializerNode] {
        fatalError("ABSCTRACT CLASSES")
    }

    open func initialViewControlller(using config: Config,
                                     errorHandler: ErrorHandler) -> Controller {
        
        
        fatalError("ABSCTRACT CLASSES")
    }
    
    open func getErrorHandlers(using config: Config) -> [ErrorHandlerNodeTemplate] {
        fatalError("ABSCTRACT CLASSES")
    }

    public func start() {
        startServices(completion: { [weak self] _ in
            self?.processServicesResponse()
        })
    }

    private func startServices(completion: @escaping Closure<Bool>) {
        let types = getExternalServicesInitializerTypes(config: currentConfig,
                                                        errorHandler: errorHandlerChain)
        let chain = getExternalInitializerChain(using: types)
        let handler = ExternalServicesHandler()
        handler.completed = { (result) in
            result.do(completion)
        }
        chain.start(with: handler)
    }

    private func processServicesResponse() {
        createServiceProvider()
        launchUI()
    }

    private func launchUI() {

        let controller = initialViewControlller(using: currentConfig, errorHandler: errorHandlerChain)
        #if !os(macOS)
        window.rootViewController = controller
        window.makeKeyAndVisible()
        #else
        window.contentViewController = controller
        #endif
    }

    private func createServiceProvider() {
        serviceProvider = getServiceProvider(config: currentConfig, errorHandler: errorHandlerChain)
    }

    private func getExternalInitializerChain(using types: [ExternalServicesInitializerNode]) -> ExternalServicesInitializer {
        return ExternalServicesInitializerNode.createChain(from: types)
    }
    
    lazy var errorHandlerChain: ErrorHandler = {
        let types = getErrorHandlers(using: self.currentConfig)
        return ErrorHandlerNodeTemplate.createChain(from: types)
    }()
}


extension GenericAppInitializer {
    open class Config {
        public let environment: Environment
        public let bundle: GenericBundle
        public let target: TypeProvider.T
    
        
        public init(environment: Environment,
                    bundle: GenericBundle,
                    target: TypeProvider.T) {
            self.environment = environment
            self.bundle = bundle
            self.target = target
        }
    }
}

