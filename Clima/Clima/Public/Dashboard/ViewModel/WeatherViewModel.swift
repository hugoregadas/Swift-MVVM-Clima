//
//  WeatherViewModel.swift
//  Clima
//
//  Created by Hugo Regadas on 20/10/2022.
//

import Foundation

class WeatherViewModel {
    //MARK: - Private var
    private var serviceApi: ServiceManager
    private var weather: WeatherModel?
    
    //MARK: - Initialize ViewModel
    init(serviceApi: ServiceManager) {
        self.serviceApi = serviceApi
    }
}

//MARK: - Public methods
extension WeatherViewModel {
    // Fetch weather service
    func fecthWeather(_ country: String, completion: @escaping () -> (Void)) {
        serviceApi.fetchWeather(country) { result in
            switch result {
            case .success(let weatherObjcet):
                self.weather = weatherObjcet
                break
            case .failure(_): break
            }
            completion()
        }
    }
    
    // Fetch temp
    func fetchTemp() -> Double? {
        if let weather = weather {
            return weather.main.temp
        }else {
            return nil
        }
    }
    
    // Fetch Name
    func fetchName() -> String? {
        if let weather = weather {
            return weather.name
        }else {
            return nil
        }
    }
}
