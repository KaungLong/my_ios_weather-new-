//
//  CurrentWeatherData.swift
//  my_ios_weather(new)
//
//  Created by 危末狂龍 on 2023/2/22.
//

import Foundation

struct CurrentWeather: Codable {
    let coord: Coordinate
    let main: CurrentMain
    let weather: [WeatherNow]
    let wind: Wind
    
    var dt: TimeInterval // 現在時間
    var sys: Sys
    var timezone: Int
    var id: Int // city ID
    var name: String
}

struct Coordinate: Codable {
    var lon: Double
    var lat: Double
}

struct CurrentMain: Codable {
    var temp: Double
    var temp_min: Double
    var temp_max: Double
    var feelsLike: Double
    var humidity: Int?
    
    enum CodingKeys: String,CodingKey {
        case temp
        case feelsLike = "feels_like"
        case humidity
        case temp_min
        case temp_max
    }
}

struct WeatherNow: Codable {
    var description: String
    var icon: String // 圖片編號
}

struct Wind: Codable {
    var speed: Double?
}

struct Sys: Codable{
    var sunrise: Date
    var sunset: Date
}
