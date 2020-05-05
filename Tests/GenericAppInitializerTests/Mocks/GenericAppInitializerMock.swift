//
//  GenericAppInitializerMock.swift
//  
//
//  Created by Alex Hmelevski on 2020-05-04.
//

import Foundation
#if !os(macOS)
import UIKit
#else
import Cocoa

class MyViewController: NSViewController {
  override func loadView() {
    self.view = NSView()
  }
}
#endif
@testable import GenericAppInitializer

final class GenericAppInitializerMock: GenericAppInitializer<
    TargetTypeProviderMock,
    ServiceProviderTesterMock,
    LaunchEnvironmentMock> {
    
    var _serviceMock = ServiceProviderTesterMock()
    var _errorTesterMock = ErrorHandlerTesterMock()
    var _externalServiceMock = ExternalServicesInitializerTypesMock()
    
    var _getServiceProviderCount = 0
    var _initialViewControlllerCount = 0
    var _getErrorHandlersCount = 0
    var _getExternalServicesInitializerTypesCount = 0

    
    override func getServiceProvider(config: Config, errorHandler: ErrorHandler) -> ServiceProviderTesterMock {
        _getServiceProviderCount += 1
        _serviceMock.errorHandler = errorHandler
       return _serviceMock   
    }
    
    override func initialViewControlller(using config: Config, errorHandler: ErrorHandler) -> Controller {
        _initialViewControlllerCount += 1
        
        #if !os(macOS)
        return UIViewController()
        #else
        return MyViewController()
        #endif
        
    }
    
    override func getErrorHandlers(using config: Config) -> [ErrorHandlerNodeTemplate] {
        _getErrorHandlersCount += 1
        return [_errorTesterMock]
    }
    
    override func getExternalServicesInitializerTypes(config: Config, errorHandler: ErrorHandler) -> [ExternalServicesInitializerNode] {
        _getExternalServicesInitializerTypesCount += 1
        return [_externalServiceMock]
    }
    
}
