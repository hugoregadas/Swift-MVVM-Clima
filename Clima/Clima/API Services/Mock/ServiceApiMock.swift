//
//  ServiceApiMock.swift
//  Clima
//
//  Created by Hugo Regadas on 26/10/2022.
//

import Foundation


class ServiceApiMock : ServiceManagerProtocol {
    //MARK: - Public Var
    static let shared = ServiceApiMock()
    
    func fetchWeather(_ country: String, completion: @escaping (Result<WeatherData, Error>) -> (Void)) {
        let weatherDataMock = WeatherData(main: WeatherMain(temp: 10, feels_like: 0, temp_min: 0, temp_max: 0, pressure: 0, humidity: 0),
                                          name: "Lousada", cod: 0, id: 0, timezone: 0, sys: WeatherSys(type: 0, id: 0, country: "", sunrise: 0, sunset: 0), dt: 0, clouds: WeatherClouds(all: 0), wind: WeatherWind(speed: 0, deg: 0), visibility: 0, base: "", weather: [WeatherArray(id: 250, main: "", description: "", icon: "")], coord: WeatherCoord(lon: 0, lat: 0))
        completion(.success(weatherDataMock))
    }
    
    func fetchWeather(with lat: Double, long: Double, completion: @escaping (Result<WeatherData, Error>) -> (Void)) {
        let error = NSError(domain: "url empty", code: 404)
        completion(.failure(error))
    }
    
    
}
