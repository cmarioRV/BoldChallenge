import XCTest
import Swinject
@testable import Networking
@testable import Domain

final class NetworkingTests: XCTestCase {
    func testGetSearchWithValidQueryReturnDomainModels() {
        let subject = NetworkingModule(assembly: FakeNetworkingAssembly())
        
        let assemblies = [subject.moduleAssembly]
        let _ = Assembler(assemblies, container: Container())
    
        var searchResult: [Search]?
        let expectation = expectation(description: "Return values successfully")
        subject.getSearch(query: "Med", completion: { result, error in
            searchResult = result
            expectation.fulfill()
        })

        waitForExpectations(timeout: 0.5) { error in
            XCTAssertNotNil(searchResult)
            XCTAssertEqual(searchResult?.count, 2)
        }
    }
    
    func testGetForecastWithValidQueryReturnDomainModels() {
        let subject = NetworkingModule(assembly: FakeNetworkingAssembly())
        
        let assemblies = [subject.moduleAssembly]
        let _ = Assembler(assemblies, container: Container())
    
        var forecastResult: [Domain.Forecast]?
        let expectation = expectation(description: "Return values successfully")
        subject.getForecast(query: "Med", days: 3) {  result, error in
            forecastResult = result
            expectation.fulfill()
        }

        waitForExpectations(timeout: 0.5) { error in
            XCTAssertNotNil(forecastResult)
            XCTAssertEqual(forecastResult?.count, 1)
            XCTAssertEqual(forecastResult?.first?.days.count, 3)
        }
    }
}
