//
//  ClimaTests.swift
//  ClimaTests
//
//  Created by Hugo Regadas on 19/10/2022.
//

import XCTest
@testable import Clima

final class ClimaTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //WeatherViewModel
    func testWeatherViewModel(){
        let viewModel = WeatherViewModel(serviceApi: ServiceApiMock.shared)
     
        viewModel.fecthWeather(with: "") {
            viewModel.serviceApiMock.fetchWeather("") { result in
                switch result {
                case .success(let weatherData):
                    viewModel.updateWeatherModel(weatherData: weatherData)
                    break
                case .failure(_): break
                }
            }
        }
        
        viewModel.fetchWeather(with: 0, long: 0) {
            viewModel.serviceApiMock.fetchWeather(with: 0, long: 0) { result in
                switch result {
                case .success(let weatherData):
                    viewModel.updateWeatherModel(weatherData: weatherData)
                    break
                case .failure(_): break
                }
            }
        }
        
        let name = viewModel.fetchName()
        let temp = viewModel.fetchTemp()
        let imagName = viewModel.fetchImageNamed()

        
        XCTAssertEqual(name,"Lousada")
        XCTAssertEqual(temp,"10.0 ºC")
        XCTAssertEqual(imagName,"cloud.fill")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
