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
        warshipDataService = nil
        mockURLSession = nil
    }
    
    func test_WarshipDataService_GetEnemy_SuccessfullyReturnsEnemy() async throws {
        // Given
        let expectedEnemy = Enemy(message: nil, data: Info(date: "2024-08-09", day: 898, stats: nil, increase: nil))
        
        mockURLSession.data = try JSONEncoder().encode(expectedEnemy)
        mockURLSession.response = HTTPURLResponse(
            url: URL(
                string: "https://russianwarship.rip/api/v2/statistics/latest"
            )!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        // When
        let returnedEnemy =  try await warshipDataService.getEnemy()
        
        // Then
        XCTAssertNotNil(returnedEnemy)
        XCTAssertEqual(returnedEnemy.data.date, expectedEnemy.data.date)
        XCTAssertEqual(returnedEnemy.data.day, expectedEnemy.data.day)
        XCTAssertEqual(returnedEnemy, expectedEnemy)
    }
    
    
    func test_WarshipDataService_GetEnemy_BadServerResponseError() async {
        // Given
        let dataService = WarshipDataService(urlString: "https://www.google.com", urlSession: MockURLSession())
        // When
        do {
            _ = try await dataService.getEnemy()
            XCTFail("Expected to throw EnemyAPIError.badServerResponse, but succeeded instead")
        } catch let error as EnemyAPIError {
            XCTAssertEqual(error, .badServerResponse, "Expected EnemyAPIError.invalidURL but got \(error) instead")
        }
        catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_WarshipDataService_GetEnemy_InvalidStatusCode() async {
        // Given
        mockURLSession.response = HTTPURLResponse(
            url: URL(string: "https://russianwarship.rip/api/v2/statistics/latest")!,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )
        //When
        do {
            _ = try await warshipDataService.getEnemy()
            XCTFail("Expected to throw EnemyAPIError.invalidStatusCode, but succeeded instead")
        } catch let error as EnemyAPIError {
            XCTAssertEqual(error, .invalidStatusCode(statusCode: 404))
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
        
    }
    
    func test_WarshipDataService_GetEnemy_InvalidDataError() async {
        //Given
        mockURLSession.data = Data() // empty Data
        mockURLSession.response = HTTPURLResponse(
            url: URL(string: "https://russianwarship.rip/api/v2/statistics/latest")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        //When
        do {
            _ = try await warshipDataService.getEnemy()
            XCTFail("Expected to throw EnemyAPIError.invalidData, but succeeded instead")
        } catch let error as EnemyAPIError {
            XCTAssertEqual(error, .invalidData)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_WarshipDataService_GetEnemy_DecodingError() async {
        // Given
        let invalidJSON = "{ \"invalid\": \"json\" }".data(using: .utf8)!
        mockURLSession.data = invalidJSON
        mockURLSession.response = HTTPURLResponse(
            url: URL(string: "https://russianwarship.rip/api/v2/statistics/latest")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        // When
        do {
            _ = try await warshipDataService.getEnemy()
            XCTFail("Expected decodingError, but succeeded")
        } catch let error as EnemyAPIError {
            // Then
            if case .decodingError(let decodingError) = error {
                XCTAssertTrue(true)
            } else {
                XCTFail("Unexpected error: \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_WarshipDataService_GetEnemy_NetworkError() async {
        // Given
        mockURLSession.error = URLError(.notConnectedToInternet)
        // When
        do {
            _ = try await warshipDataService.getEnemy()
            XCTFail("Expected networkError, but succeeded")
        } catch let error as EnemyAPIError {
            // Then
            if case .networkError(let uRLError) = error {
                XCTAssertTrue(true)
            } else {
                XCTFail("Unexpected error: \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    
}
