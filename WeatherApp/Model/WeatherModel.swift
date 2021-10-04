//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Izuchukwu Dennis on 09.08.2021.
//  Copyright © 2021 Izuchukwu Dennis. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "wind"
        case 800:
            return "cloud"
        case 800...804:
            return "cloud.fill"
        default:
            return "none"
        }
    }
    var temperatureString: String {
       return String(format: "%.1f", temperature)
    }
}



