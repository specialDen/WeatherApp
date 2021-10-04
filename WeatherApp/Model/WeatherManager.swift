//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Izuchukwu Dennis on 31.07.2021.
//  Copyright © 2021 Izuchukwu Dennis. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWIthError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=APP-ID&units=metric"
//    replace APP-ID with your app-id from the api provider
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName.trimmingCharacters(in: .whitespaces))"
        let safeUrlString = urlString.replacingOccurrences(of: " ", with: "%20")
        performRequest(with: safeUrlString)
        
    }
    func performRequest(with urlString: String) {
        //        1. Create an URL
        //        2. Create an URLSession
        //        3. Give the session a break
        //        4. Start the task
        
        //        1. Create an URL
        if let url = URL(string: urlString){
            //        2. Create an URLSession
            let session = URLSession(configuration: .default)
            //        3. Give the session a break
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWIthError(error: error!)
                    return
                }
                if let safeData = data {
//                    _ = String(data: safeData, encoding: .utf8)
                    if let weather =  parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //        4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            _ = decodedData.weather.first?.description ?? "nil"
            let id = decodedData.weather.first?.id ?? 0
            let name = decodedData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            print(weather.conditionName)
            print(weather.temperatureString)
            return weather
        } catch {
            delegate?.didFailWIthError(error: error)
            return nil
        }
    }
    
}

extension WeatherManager {
    func fetchWeather(longitude: Double, latitude: Double) {
        let urlString = "\(weatherURL)&lon=\(longitude)&lat=\(latitude)"
        performRequest(with: urlString)
        
    }
}
