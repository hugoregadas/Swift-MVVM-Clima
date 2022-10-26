//
//  ServiceManagerProtocol.swift
//  Clima
//
//  Created by Hugo Regadas on 26/10/2022.
//

import Foundation


protocol ServiceManagerProtocol {
    func fetchWeather(_ country: String, completion: @escaping (Result <WeatherData, Error>) -> (Void))
    func fetchWeather(with lat: Double, long : Double, completion: @escaping (Result <WeatherData, Error>) -> (Void))
}
