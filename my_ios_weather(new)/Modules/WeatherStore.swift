//
//  WeatherStore.swift
//  my_ios_weather(new)
//
//  Created by 危末狂龍 on 2023/2/23.
//

import Foundation

class WeatherStore {
    
    //signleton
    static let shared = WeatherStore()
    var callBackReloadData:((Int) -> (Void))?
    private let userDefault = UserDefaults.standard
    
    private(set) var weathers: [CurrentWeather] = [] {
        didSet{
            saveData()
        }
    }
    
    func updateAPI(){
        print("\(weathers.count)")
        for index in 0...weathers.count-1 {
            print("test+\(weathers[index].name)")
            Task {
                let  cityCurrentDataNow = try await WeatherDataHTTPClient.CurrentWeatherData(city: weathers[index].name)
                print(cityCurrentDataNow.dt.time(format: "HH:mm"))
                if self.weathers[index].dt != cityCurrentDataNow.dt {
                    self.weathers[index] = cityCurrentDataNow
                    self.callBackReloadData?(index)
                    print("\(self.weathers[index].name)+update!!")
                }
            }
        }
    }
    
    func remove(_ index:Int){
        weathers.remove(at: index)
    }
    func removeLast(){
        weathers.removeLast()
    }
    
    func append(_ weather:CurrentWeather){
        weathers.append(weather)
        print("VV")
    }
    func changeLocation(data:CurrentWeather){
        if weathers.isEmpty{
            weathers.insert(data, at: 0)
        }else{
            weathers[0] = data
        }
        
    }
    
    private func saveData(){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(weathers){
            let defaults = userDefault
            defaults.set(encoded, forKey: "data")
        }
    }
    
    private func loadData(){
        if let saveData = userDefault.object(forKey: "data") as? Data{
            let decoder = JSONDecoder()
            if let loadedData = try? decoder.decode(Array<CurrentWeather>.self, from: saveData) {
                weathers = loadedData
            }
        }
    }
    
    private init(){
        loadData()
    }
    
}
