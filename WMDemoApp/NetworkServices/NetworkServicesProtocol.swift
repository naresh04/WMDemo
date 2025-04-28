//
//  NetworkServicesProtocol.swift
//  WMDemoApp
//
//  Created by naresh chouhan on 4/28/25.
//

import Foundation

protocol NetworkServicesProtocol{
    func fetchServiceData() async throws -> [Country]
}
