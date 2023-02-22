//
//  StoreHTTPClient.swift
//  my_ios_weather(new)
//
//  Created by 危末狂龍 on 2023/2/22.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse
    case decodingError
}

class API {
    static let apiKey = "213583f1990c970587b2fc41efff3c42"
    static let weather = "weather"
    static let forecast = "forecast"
    static let imperial = "imperial"
}


class CountryDataHTTPClient {
    
    var countrys = [String]()
    
    func append(_ country:String){
        countrys.append(country)
    }
    
    func getCountryData() async throws {
        
        let address = "https://countriesnow.space/api/v0.1/countries"
        let (data, response) = try await URLSession.shared.data(from: URL(string: "https://countriesnow.space/api/v0.1/countries")!)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else{
            throw NetworkError.invalidServerResponse
        }
        
        guard let countryData = try? JSONDecoder().decode(CountryData.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        for country in
                countryData.data.sorted(by: {$0.country < $1.country}) {
                    self.append(country.country)
                }
    }
    
}
