//
//  ServiceManager.swift
//  Clima
//
//  Created by Hugo Regadas on 20/10/2022.
//

import Foundation

class ServiceManager {
    //MARK: - Public methods
    static let shared = ServiceManager()
    
    //MARK: - Private Methods
    private let configuration: URLSessionConfiguration
    private let session: URLSession
    private let url = "https://api.openweathermap.org/data/2.5/weather?appid=556ff11af1f50c2e5a27d6fa28bf5c75&units=metric"
    
    private init() {
        configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
}

//MARK: - Public methods
extension ServiceManager {
    func fetchWeather(_ country: String, completion: @escaping (Result <WeatherModel, Error>) -> (Void)){
        let countryUrl = URL(string: "\(url)&q=\(country)")
        
        guard let countryUrl = countryUrl else {
            let error = NSError(domain: "url empty", code: 404)
            completion(.failure(error))
            return
        }
        
        var request = URLRequest(url: countryUrl)
        request.httpMethod = "GET"
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                let error = NSError(domain: "", code: 999, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                let error = NSError(domain: "", code: response.statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: 998, userInfo:nil)
                completion(.failure(error))
                return
            }
        
            do {
                let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(.success(weather))
            }catch let error{
                completion(.failure(error))
            }
        }.resume()
        
    }
}
