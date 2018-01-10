//
//  ViewController.swift
//  VirtusaWhetherApp
//
//  Created by Surendra Singh on 1/8/18.
//  Copyright © 2018 Surendra Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    //IBOUtlets
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherTitleLabel: UILabel!
    @IBOutlet weak var weatherDescLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempRangeLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    //Search controller
    var searchController : UISearchController!
    //viewModel
    let viewModel = CityWeatherViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup Search bar UI
        self.setupSearchBar()
        //UI Reset
        self.resetUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Loading last searched city data
        if let lastSearchedText = UserDefaults.standard.object(forKey: LAST_SEARCHED_TEXT) as? String{
            self.fetchWeatherData(lastSearchedText)
        }
    }
    
    //Fetch city weather data
    fileprivate func fetchWeatherData(_ lastSearchedText: String) {
        self.activityView.startAnimating()
        self.viewModel.fetchWeatherData(forCity: lastSearchedText) {[unowned self] (weather, error) in
            if let error = error {
                //Show Error
                DispatchQueue.main.async {
                    self.showError(message: error.localizedDescription)
                }
            }else{
                //Update UI
                self.updateUI(weather: weather!)
            }
        }
    }
    private func setupSearchBar(){
        //Setting up search bar for city, activity position
        self.activityView.center = self.view.center
        self.searchController = UISearchController(searchResultsController:  nil)
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.navigationItem.titleView = self.searchController.searchBar
        self.searchController.searchBar.placeholder = "Enter city name"
        self.definesPresentationContext = true
    }
    
    func updateUI(weather:CityWeather){
        DispatchQueue.main.async {
            //Handle welcome info
            if !self.welcomeLabel.isHidden{
                self.welcomeLabel.isHidden = true
            }
            
            self.activityView.stopAnimating()
            if weather.cod == 200 { /*if cod is 200 then update ui otherwise show error alert*/
                self.cityNameLabel.text = weather.name! + ", " + weather.sys.country!
                let data = Date(timeIntervalSince1970: weather.dt!)
                self.timeLabel.text = "Last updated at : " + data.currentTimeZoneDate()
                self.weatherImageView.image = UIImage(data: try! Data(contentsOf: URL(string: IMAGE_DOWNLOAD + (weather.weather.last?.icon!)! + ".png")!))
                self.weatherTitleLabel.text = weather.weather.last?.main
                self.weatherDescLabel.text = weather.weather.last?.description
                self.tempLabel.text = "\(weather.main.temp!)K"
                self.tempRangeLabel.text = "Min:\(weather.main.temp_min!)K\tMax:\(weather.main.temp_max!)K"
                self.pressureLabel.text = "Pressure:\(weather.main.pressure!) hPa"
                self.humidityLabel.text = "Humidity:\(weather.main.humidity!) %"
                self.windSpeedLabel.text = "Wind Speed:\( weather.wind.speed!) meter/sec"
                if let deg = weather.wind.deg {
                    self.windDirectionLabel.text = "Wind Direction:\(deg) degree"
                }else{
                    self.windDirectionLabel.text = "Wind Direction: N/A"
                }
                self.cloudLabel.text = "Clouds: \(weather.clouds.all!) %"
                self.latLabel.text = "Lat: \(weather.coord.lat!)"
                self.longLabel.text = "Lon: \(weather.coord.lon!)"
                let sunriseDate = Date(timeIntervalSince1970: (weather.sys.sunrise!))
                self.sunriseLabel.text = "Sunrise :\(sunriseDate.currentTimeZoneDate())"
                let sunsetDate = Date(timeIntervalSince1970: (weather.sys.sunset!))
                self.sunsetLabel.text = "Sunrise :\(sunsetDate.currentTimeZoneDate())"
            }else{
                self.showError(message: HTTPURLResponse.localizedString(forStatusCode: weather.cod!))
            }
        }
    }
    
    //Show Error
    private func showError(message:String){
        let alertController = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default) { (action:UIAlertAction) in}
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Reset UI
    private func resetUI(){
        self.cityNameLabel.text = ""
        self.timeLabel.text = ""
        self.weatherImageView.image = nil
        self.weatherTitleLabel.text = ""
        self.weatherDescLabel.text = ""
        self.tempLabel.text = ""
        self.tempRangeLabel.text = ""
        self.pressureLabel.text = ""
        self.humidityLabel.text = ""
        self.windSpeedLabel.text = ""
        self.windDirectionLabel.text = ""
        self.cloudLabel.text = ""
        self.latLabel.text = ""
        self.longLabel.text = ""
        self.sunriseLabel.text = ""
        self.sunsetLabel.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: - UISearchBarDelegate
extension ViewController:UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        let searchText = searchBar.text!
        if searchText.count > 0 {
            UserDefaults.standard.set(searchText, forKey: LAST_SEARCHED_TEXT)
            self.fetchWeatherData(searchText)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.resetUI()
    }
}

