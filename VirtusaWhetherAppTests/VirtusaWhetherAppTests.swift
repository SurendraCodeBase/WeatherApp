//
//  VirtusaWhetherAppTests.swift
//  VirtusaWhetherAppTests
//
//  Created by Surendra Singh on 1/8/18.
//  Copyright © 2018 Surendra Singh. All rights reserved.
//

import XCTest
@testable import VirtusaWhetherApp

class VirtusaWhetherAppTests: XCTestCase {
    
    var viewModel:CityWeatherViewModel!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.viewModel = CityWeatherViewModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchRedmondWeather() {
        self.viewModel.fetchWeatherData(forCity: "Redmond") { (weather, error) in
            XCTAssertNotNil(weather)
        }
    }
    
    func testFetchSeattleWeather() {
        self.viewModel.fetchWeatherData(forCity: "Seattle") { (weather, error) in
            XCTAssertNotNil(weather)
        }
    }
    
    func testFetchSunnyvaleWeather() {
        self.viewModel.fetchWeatherData(forCity: "Sunnyvale") { (weather, error) in
            XCTAssertNotNil(weather)
        }
    }
    
    func testFetchNewYorkWeather() {
        self.viewModel.fetchWeatherData(forCity: "New York") { (weather, error) in
            XCTAssertNotNil(weather)
        }
    }
}
