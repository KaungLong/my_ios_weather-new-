//
//  CountryData.swift
//  my_ios_weather(new)
//
//  Created by 危末狂龍 on 2023/2/22.
//

import Foundation

struct CountryData:Decodable{
    var data:[Country]
}

struct Country:Decodable{
    var iso2:String
    var country:String
    var cities:[String]
}
