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
    private var imageNamed: String?
    
    //MARK: - Initialize ViewModel
    init(serviceApi: ServiceManager) {
        self.serviceApi = serviceApi
    }
}

//MARK: - Private methods
private extension WeatherViewModel {
    func updateWeatherModel(weatherData: WeatherData){
        if let id = weatherData.weather.first?.id {
            self.weather = WeatherModel(name: weatherData.name, temp: weatherData.main.temp, conditionID:id)
        }
    }
}

//MARK: - Public methods
extension WeatherViewModel {
    // Fetch weather service
    func fecthWeather(with country: String, completion: @escaping () -> (Void)) {
        serviceApi.fetchWeather(country) { result in
            switch result {
            case .success(let weatherObjcet):
                self.updateWeatherModel(weatherData: weatherObjcet)
                break
            case .failure(_): break
            }
            completion()
        }
    }
    
    func fetchWeather(with lat: Double, long: Double, completion: @escaping()->(Void)) {
        serviceApi.fetchWeather(with: lat, long: long) { result in
            switch result {
            case .success(let weatherObjcet):
                self.updateWeatherModel(weatherData: weatherObjcet)
                break
            case .failure(_): break
            }
            completion()
        }
    }
    
    // Fetch temp
    func fetchTemp() -> String {
        return weather!.tempString
    }
    
    // Fetch Name
    func fetchName() -> String {
        return weather!.name
    }
    
    func fetchImageNamed() -> String {
        return weather!.imageName
    }
}
