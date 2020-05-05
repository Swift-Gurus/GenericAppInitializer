import XCTest
@testable import GenericAppInitializer

#if !os(macOS)
import UIKit
#else
import Cocoa




#endif



final class GenericAppInitializerTests: XCTestCase {
    lazy var _window: Window = {
        #if !os(macOS)
        return UIWindow(frame: .zero)
        #else
        return NSWindow(contentRect: .zero,
                        styleMask: .borderless,
                        backing: .buffered,
                        defer: false)
        #endif
    }()
    var sut: GenericAppInitializerMock!
    
    override func setUpWithError() throws {
        sut = GenericAppInitializerMock()
    }
    
    func test_start_calls_services() {
        sut.start()
        sut._externalServiceMock.calledExpected(numberOfTimes: 1)
    }
    
    func test_start_calls_get_serviceProvider() {
        sut.launchUI(in: _window)
        XCTAssertEqual(sut._getServiceProviderCount, 1)
    }
    
    func test_start_calls_get_error_handlers() {
        sut.start()
        XCTAssertEqual(sut._getErrorHandlersCount, 1)
    }
    
    func test_start_calls_get_initial_view_controller() {
        sut.launchUI(in: _window)
        XCTAssertEqual(sut._initialViewControlllerCount, 1)
    }
    
    func test_checks_error_handler_is_passed() {
        sut.launchUI(in: _window)
        sut._serviceMock.errorHandler.catchError(MyError.default)
        sut._errorTesterMock.checkCatchErrorCalled(expectedNumberOfTimes: 1)
    }
    
    func test_error_handler_proccessError_called() {
        sut.launchUI(in: _window)
        sut._serviceMock.errorHandler.catchError(MyError.default)
        sut._errorTesterMock.checkErrorsAreOfType(MyError.self)
    }

}
