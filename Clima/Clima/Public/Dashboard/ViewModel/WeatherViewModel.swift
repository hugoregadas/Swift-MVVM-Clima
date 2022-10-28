//
//  WeatherViewModel.swift
//  Clima
//
//  Created by Hugo Regadas on 20/10/2022.
//

import Foundation

class WeatherViewModel {
    //MARK: - Private var
    private var serviceApi: ServiceManagerProtocol
    private var weather: WeatherModel?
    private var imageNamed: String?
    
    //MARK: - Public var
    var serviceApiMock: ServiceManagerProtocol
    lazy var language = {
        let value = LanguageManager.sharedLanguage.currentCode()
        
        if(value == "pt") {
            return "EN"
        }else{
            return "PT"
        }
    }()

    //MARK: - Initialize ViewModel
    init(serviceApi: ServiceManagerProtocol) {
        self.serviceApi = serviceApi
        self.serviceApiMock = serviceApi
    }
}

//MARK: - Private methods
extension WeatherViewModel {
    public func updateWeatherModel(weatherData: WeatherData){
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
        guard let tempString = weather?.tempString else {
            return "Error"
        }
        return tempString
    }
    
    // Fetch Name
    func fetchName() -> String {
        guard let nameString = weather?.name else {
            return "Error"
        }
        
        return nameString
    }
    
    // Fetch Image
    func fetchImageNamed() -> String {
        guard let imageString = weather?.imageName else {
            return "Error"
        }
        
        return imageString
    }
}
