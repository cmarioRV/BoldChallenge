//
//  ViewModelTests.swift
//  BoldChallengeTests
//
//  Created by Mario Rúa on 25/02/23.
//

import XCTest
import Swinject
@testable import Networking
@testable import Domain
@testable import BoldChallenge

final class ViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetSearchReturnSuccess() {
        let fakeNetworkingDependency = NetworkingModule(assembly: FakeNetworkingAssembly())
        let fakeAssemblies = [fakeNetworkingDependency.moduleAssembly]
        let _ = Assembler(fakeAssemblies, container: Container())
        
        let expectation = expectation(description: "Return search successfully")
        var postsResult: [SearchTableViewCell.ViewModel]?
        var errorResult: Error?
        
        let subject = SearchViewModel(networkingProvider: fakeNetworkingDependency)
        
        subject.outputs.cellViewModels.bind { posts in
            postsResult = posts
            expectation.fulfill()
        }
        
        subject.outputs.error.bind { error in
            errorResult = error
            expectation.fulfill()
        }
        
        subject.inputs.getWeather(inLocation: "Medellin")
        
        waitForExpectations(timeout: 2) { error in
            XCTAssertNotNil(postsResult)
            XCTAssertEqual(postsResult?.count, 2)
            XCTAssertNil(errorResult)
        }
    }
    
    func testGetForecastReturnSuccess() {
        let fakeNetworkingDependency = NetworkingModule(assembly: FakeNetworkingAssembly())
        let fakeAssemblies = [fakeNetworkingDependency.moduleAssembly]
        let _ = Assembler(fakeAssemblies, container: Container())
        
        let expectation = expectation(description: "Return forecast successfully")
        var forecastResult: Domain.Forecast?
        var errorResult: Error?
        
        let subject = ForecastViewModel(networkingProvider: fakeNetworkingDependency)
        
        subject.outputs.forecast.bind { forecast in
            forecastResult = forecast
            expectation.fulfill()
        }
        
        subject.outputs.error.bind { error in
            errorResult = error
            expectation.fulfill()
        }
        
        subject.inputs.getForecast(location: "Medellin")
        
        waitForExpectations(timeout: 2) { error in
            XCTAssertNotNil(forecastResult)
            XCTAssertEqual(forecastResult?.days.count, 3)
            XCTAssertNil(errorResult)
        }
    }
}
