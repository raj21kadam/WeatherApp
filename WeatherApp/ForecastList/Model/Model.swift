//
//  Model.swift
//  WeatherApp
//
//  Created by Raj Kadam on 18/03/22.
//

import Foundation

struct WeatherListModel: Decodable {
    let cod: String
    let cnt: Int
    let list: [HourlyForecastModel]?
}

struct HourlyForecastModel: Decodable {
    let dt: Int64
    let main: MainData?
    let weather: [WeatherData]?
}

struct MainData: Decodable {
    let temp: Double
    let feels_like: Double
}

struct WeatherData: Decodable {
    let id: Int
    let main: String
    let description: String
    
}
