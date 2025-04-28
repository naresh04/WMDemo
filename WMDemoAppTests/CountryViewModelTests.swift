//
//  CountryViewModelTests.swift
//  WMDemoAppTests
//
//  Created by naresh chouhan on 4/28/25.
//

import Foundation
import XCTest
@testable import WMDemoApp

final class CountryViewModelTests: XCTestCase {
    
    func testFetchCountriesSuccess() async {
        let mockService = MockNetworkServices()
        let viewModel = await CountryViewModel(service: mockService)
            
            let expectation = expectation(description: "Data updated")
        await MainActor.run {
            viewModel.onDataUpdate = {
                expectation.fulfill()
            }
        }
                
                await viewModel.fetchCountries()
                await fulfillment(of: [expectation], timeout: 1.0)
                let count = await viewModel.numberOfCountries()
                XCTAssertEqual(count, 1)
        }
    
    func testFetchCountriesFailure() async {
        let mockService = MockNetworkServices()
            mockService.shouldReturnError = true
            let viewModel = await   CountryViewModel(service: mockService)
            
            let expectation = expectation(description: "Error occurred")
            await MainActor.run {
            viewModel.onError = { error in
                expectation.fulfill()
            }
        }
            
            await viewModel.fetchCountries()
            
            await fulfillment(of: [expectation], timeout: 1.0)
        }
}
