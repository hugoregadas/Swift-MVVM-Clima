//
//  WeatherModel.swift
//  Clima
//
//  Created by Hugo Regadas on 20/10/2022.
//

import Foundation


class WeatherModel : Decodable {
    let main: WeatherMain
    let name: String
    let cod: Int
    let id: Int
    let timezone : Int
    let sys: WeatherSys
    let dt: Int
    let clouds: WeatherClouds
    let wind: WeatherWind
    let visibility: Int
    let base: String
    let weather: [WeatherArray]
    let coord: WeatherCoord
}

struct WeatherMain: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
}

struct WeatherWind : Decodable {
    let speed: Double
    let deg: Double
}

struct WeatherClouds : Decodable {
    let all: Int
}

struct WeatherSys : Decodable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}

struct WeatherArray : Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherCoord: Decodable {
    let lon : Double
    let lat : Double
}
