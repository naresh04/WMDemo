//
//  CountryStore.swift
//  WMDemoApp
//
//  Created by naresh chouhan on 4/28/25.
//

import Foundation

actor CountryStore {
    private(set) var allCountries: [Country] = []
    private(set) var filteredCountries: [Country] = []
    
    func setCountries(_ countries: [Country]) {
        self.allCountries = countries
        self.filteredCountries = countries
    }
    
    func filterCountries(with searchText: String) {
        guard !searchText.isEmpty else {
            filteredCountries = allCountries
            return
        }
        
        filteredCountries = allCountries.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.capital.localizedCaseInsensitiveContains(searchText)
        }
    }
    
}
