//
//  WeatherModel.swift
//  Clima
//
//  Created by Hugo Regadas on 25/10/2022.
//

import Foundation

struct WeatherModel {
    //Constants 
    let name : String
    let temp : Double
    let conditionID : Int
    
    //Computed Propertys
    var imageName : String {
        switch conditionID {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "tornado.circle.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "cloud.fill"
        }
    }
    var tempString: String {
        return String(format: "%.1f ºC", temp)
    }
}
