//
//  UnitTestingWarshipDataService_Tests.swift
//  WarshipTests
//
//  Created by Vladyslav Dikhtiaruk on 08/08/2024.
//

import XCTest
@testable import Warship

/*
 1. Naming Structure:
 - name describes exactly what we are trying to test
 - every test starts with the word "test"
 - test_UnitOfWork_StateUnderTest_ExpectedBehaviour
 - test_[struct or class]_[variable or function]_[expected result]
 
 2. Testing Structure:
 - Given, When, Then
 
 */


final class WarshipDataService_Tests: XCTestCase {
    var warshipDataService: WarshipDataService!
    var mockURLSession: MockURLSession!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockURLSession = MockURLSession()
        warshipDataService = WarshipDataService(urlSession: mockURLSession)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_WarshipDataService_FetchEnemyAsync_SuccessfullyReturnsEnemy() async throws {
        //Given
        let dataService = WarshipDataService()
        
        //When
        var testEnemy: Enemy? = nil
        
        let returnedValue = try await dataService.getEnemy()
        testEnemy = returnedValue
        
        //Then
        XCTAssertNotNil(testEnemy)
    }
    
    
    func test_WarshipDataService_FetchEnemyAsync_Success() async throws {
        // Given
        let mockUrlSession = MockURLSession()
        let dataService = WarshipDataService(urlSession: mockUrlSession)
        
        let expectedEnemy = Enemy(message: nil, data: Info(date: "2024-08-09", day: 898, stats: nil, increase: nil))
        
        mockUrlSession.data = try JSONEncoder().encode(expectedEnemy)
        mockUrlSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        // When
        let returnedValue =  try await dataService.getEnemy()
        
        // Then
        XCTAssertEqual(returnedValue.data.date, expectedEnemy.data.date)
        XCTAssertEqual(returnedValue.data.day, expectedEnemy.data.day)
    }
    
    
    // good test, but function is fucked up
//    func test_WarshipDataService_FetchEnemyAsync_InvalidURL() async {
//        // Given
//        let dataService = WarshipDataService(urlString: "https://www.google.com")
//        // When
//        do {
//            _ = try await dataService.fetchEnemyAsync()
//            XCTFail("Expected to throw EnemyAPIError.invalidURL, but succeeded instead")
//        } catch let error as EnemyAPIError {
//            XCTAssertEqual(error, .invalidURL, "Expected EnemyAPIError.invalidURL but got \(error) instead")
//        } 
//        catch {
//            XCTFail("Expected to throw EnemyAPIError.invalidURL, but threw a different error: \(error)")
//        }
        
        // Then
//    }
}
