//
//  readCode.swift
//  Ghala
//
//  Created by mroot on 17/05/2022.
//

import Foundation

class ReadCountryCode: ObservableObject  {
    @Published var codeCountry = [CountryData]()
           
    init(){
        loadData()
    }
           
    //MARK: Loading Country JSON FIle
    /**
            @countryCodeData - Data from JsonFile (countryCode.json)
            @CountryData - Data Model
     */
    func loadData()  {
        guard let countryCodeData = Bundle.main.url(forResource: "countryCode", withExtension: "json") else {
            print("countryCode.json file not found")
            return
            
        }
        
        let data = try? Data(contentsOf: countryCodeData)
        let code = try? JSONDecoder().decode([CountryData].self, from: data!)
        self.codeCountry = code!
        
    }
}
