//
//  CountryViewModel.swift
//  WMDemoApp
//
//  Created by naresh chouhan on 4/28/25.
//

import Foundation

@MainActor
final class CountryViewModel{
    private let service:NetworkServicesProtocol
    private let store = CountryStore()
    
    private(set) var countries: [Country] = []
    
    var onDataUpdate: (()->Void)?
    var onError: ((Error) -> Void)?
    
    init(service: NetworkServicesProtocol){
        self.service = service
    }
    
    func fetchCountries() async {
           do {
               let fetchedCountries = try await service.fetchServiceData()
               await store.setCountries(fetchedCountries)
               countries = await store.allCountries
               onDataUpdate?()
           } catch {
               onError?(error)
           }
       }
       
       func numberOfCountries() -> Int {
           countries.count
       }
       
       func country(at index: Int) -> Country? {
           guard index < countries.count else { return nil }
           return countries[index]
       }
       
       func search(with text: String) async {
           await store.filterCountries(with: text)
           countries = await store.filteredCountries
           onDataUpdate?()
       }
   }
       

