import XCTest
@testable import GenericAppInitializer

final class GenericAppInitializerTests: XCTestCase {
 
    var sut = GenericAppInitializerMock(window: UIWindow(frame: .zero))
    
    override func setUpWithError() throws {
        sut = GenericAppInitializerMock(window: UIWindow(frame: .zero))
    }
    
    func test_start_calls_services() {
        sut.start()
        sut._externalServiceMock.calledExpected(numberOfTimes: 1)
    }
    
    func test_start_calls_get_serviceProvider() {
        sut.start()
        XCTAssertEqual(sut._getServiceProviderCount, 1)
    }
    
    func test_start_calls_get_error_handlers() {
        sut.start()
        XCTAssertEqual(sut._getErrorHandlersCount, 1)
    }
    
    func test_start_calls_get_initial_view_controller() {
        sut.start()
        XCTAssertEqual(sut._initialViewControlllerCount, 1)
    }
    
    func test_checks_error_handler_is_passed() {
        sut.start()
        sut._serviceMock.errorHandler.catchError(MyError.default)
        sut._errorTesterMock.checkCatchErrorCalled(expectedNumberOfTimes: 1)
    }
    
    func test_error_handler_proccessError_called() {
        sut.start()
        sut._serviceMock.errorHandler.catchError(MyError.default)
        sut._errorTesterMock.checkErrorsAreOfType(MyError.self)
    }

}
