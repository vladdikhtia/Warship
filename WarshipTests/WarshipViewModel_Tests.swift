//
//  UnitTestingViewModel_Tests.swift
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

@MainActor
final class WarshipViewModel_Tests: XCTestCase {
    var viewModel: WarshipViewModel!
    var mockDataService: MockDataService!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockDataService = MockDataService()
        viewModel = WarshipViewModel(networkService: mockDataService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockDataService = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchEnemyAsync_Success() async {
            // Given
        let expectedEnemy = Enemy(message: nil, data: Info(date: "2024-08-11", day: 900, stats: nil, increase: nil))
            mockDataService.enemyToReturn = expectedEnemy
            
            // When
            await viewModel.fetchEnemyAsync()
            
            // Then
            XCTAssertEqual(viewModel.enemy, expectedEnemy)
            XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchEnemyAsync_EnemyAPIError() async {
            // Given
            mockDataService.errorToThrow = EnemyAPIError.badServerResponse
            
            // When
            await viewModel.fetchEnemyAsync()
            
            // Then
            XCTAssertNil(viewModel.enemy)
            XCTAssertEqual(viewModel.errorMessage, EnemyAPIError.badServerResponse.customDescription)
    }
    
    func testFetchEnemyAsync_UnknownError() async {
            // Given
            let error = URLError(.cannotFindHost)
            mockDataService.errorToThrow = EnemyAPIError.unknownError(error: error)
            
            // When
            await viewModel.fetchEnemyAsync()
            
            // Then
            XCTAssertNil(viewModel.enemy)
            XCTAssertEqual(viewModel.errorMessage, EnemyAPIError.unknownError(error: error).customDescription)
        }
}
