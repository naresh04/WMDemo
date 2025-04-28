//
//  MockNetworkServices.swift
//  WMDemoAppTests
//
//  Created by naresh chouhan on 4/28/25.
//

import Foundation
@testable import WMDemoApp

final class MockNetworkServices : NetworkServicesProtocol {
    var shouldReturnError = false
    func fetchServiceData() async throws -> [WMDemoApp.Country] {
        if shouldReturnError {
                   throw URLError(.badServerResponse)
               }
               return [
                   Country(name: "Mock Country", region: "MC", code: "MC", capital: "Mock Capital")
               ]
           }
    }
    
    

