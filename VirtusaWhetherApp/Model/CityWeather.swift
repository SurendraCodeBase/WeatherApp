//
//  CityWeather.swift
//  VirtusaWhetherApp
//
//  Created by Surendra Singh on 1/8/18.
//  Copyright © 2018 Surendra Singh. All rights reserved.
//

import Foundation
class CityWeather: Codable {
    let coord: Coordinate
    let weather:[Weather]
    let base: String?
    let main: Main
    let visibility: Double?
    let wind: Wind
    let clouds: Clouds
    let dt: Double?
    let sys: System
    let id: Double?
    let name:String?
    let cod:Int?
}

class Coordinate: Codable {
    let lon: Float?
    let lat: Float?
}

class Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon : String?
}

class Main: Codable {
    let temp: Float?
    let pressure: Int?
    let humidity: Int?
    let temp_min : Float?
    let temp_max : Float?
}

class Wind: Codable {
    let speed: Float?
    let deg: Float?
}
class Clouds: Codable {
    let all: Float?
}

class System: Codable {
    let type: Int?
    let id: Double?
    let message: Double?
    let country: String?
    let sunrise: Double?
    let sunset: Double?
}
