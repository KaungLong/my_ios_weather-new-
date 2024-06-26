//
//  ForecastWeatherData.swift
//  my_ios_weather(new)
//
//  Created by 危末狂龍 on 2023/2/22.
//

import Foundation

struct ForecastWeather: Codable {
    var list: [List]
    let city: City
    struct List: Codable {
        let dt : Date
        var main: ForecastMain
        var weather: [WeatherForecast]
//        enum CodingKeys: String,CodingKey {
//            case dt
//            case main
//            case weather
//        }
        struct ForecastMain: Codable {
            let temp: Double
            let tempMin: Double
            let tempMax: Double
            let humidity: Int

            enum CodingKeys: String,CodingKey {
                case temp
                case tempMin = "temp_min"
                case tempMax = "temp_max"
                case humidity
            }
        }
        struct WeatherForecast: Codable {
            let main: String
            let description: String
            let icon: String
        }
    }

    struct City: Codable {
        let id: Int
        let name: String
        let population: Int
        let timezone: Int
        let sunrise: Date
        let sunset: Date
    }


}
