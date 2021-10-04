//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Izuchukwu Dennis on 09.08.2021.
//  Copyright © 2021 Izuchukwu Dennis. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
