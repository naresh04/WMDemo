//
//  NetworkServices.swift
//  WMDemoApp
//
//  Created by naresh chouhan on 4/28/25.
//

import Foundation


final class NetworkServices: NetworkServicesProtocol{
    
    private let urlString = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"
    func fetchServiceData() async throws -> [Country] {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
                     200..<300 ~= httpResponse.statusCode else {
                   throw URLError(.badServerResponse)
               }
               
               return try JSONDecoder().decode([Country].self, from: data)
    }
}
