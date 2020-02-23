//
//  ViewController.swift
//  Labb1weatherApp
//
//  Created by Henrik Doré on 2020-02-04.
//  Copyright © 2020 Henrik Doré. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var feelsLikeLbl: UILabel!
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
 
    let cities: [String] = getCitiesFromJson()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        */
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.cityLabel.transform = CGAffineTransform(translationX: 1, y: 90)
            self.weatherDescription.transform = CGAffineTransform(translationX: 1, y: 90)
            self.temperatureLabel.transform = CGAffineTransform(translationX: 1, y: 90)
            self.windLbl.transform = CGAffineTransform(translationX: 1, y: 90)
            self.feelsLikeLbl.transform = CGAffineTransform(translationX: 1, y: 90)


            
            
        }) { (_) in
            self.cityLabel.transform = CGAffineTransform(translationX: 130, y: 90)
            self.weatherDescription.transform = CGAffineTransform(translationX: 175, y: 90)
            self.temperatureLabel.transform = CGAffineTransform(translationX: 170, y: 90)
            self.windLbl.transform = CGAffineTransform(translationX: 100, y: 90)
            self.feelsLikeLbl.transform = CGAffineTransform(translationX: 100, y: 90)




        }
        
        
            
            let APIforWeather = weatherAPI()
            
        APIforWeather.getWeatherInCity(searchedCity: "Goeteborg") { (result) in
                
                switch result {
                case .success(let weatherUI):
                    DispatchQueue.main.async {
                        
                        self.cityLabel.text = weatherUI.name
                        self.weatherDescription.text = weatherUI.weather[0].description
                        self.temperatureLabel.text = weatherUI.main.temp.toString() + "°c"
                        self.setDisciptionImage()
                        self.windLbl.text = "Wind speed is: \(weatherUI.wind.speed.toString()) m/s"
                        self.feelsLikeLbl.text = "Temp feels like: \(weatherUI.main.feels_like.toString())°c"
                        
                        
                        
                        
                    }
                case .failure(let error): print("Error \(error)")
            }
        }
        
    }
    
    
    
    func setDisciptionImage(){
        switch self.weatherDescription.description {
            case let str where str.contains("clear sky"):
                self.weatherImageView.image = UIImage(named: "sun")
            case let str where str.contains("rain"):
                self.weatherImageView.image = UIImage(named: "rain")
            case let str where str.contains("drizzle"):
            self.weatherImageView.image = UIImage(named: "rain")
            case let str where str.contains("light intensity shower rain"):
                self.weatherImageView.image = UIImage(named: "rain")
            case let str where str.contains("broken clouds"):
                self.weatherImageView.image = UIImage(named: "brokenClouds")
            case let str where str.contains("overcast clouds"):
                self.weatherImageView.image = UIImage(named: "brokenClouds")
            case let str where str.contains("few clouds"):
                self.weatherImageView.image = UIImage(named: "sunWithCloud")
            case let str where str.contains("scattered clouds"):
                self.weatherImageView.image = UIImage(named: "sunWithCloud")
            case let str where str.contains("light snow"):
                self.weatherImageView.image = UIImage(named: "snow")

                    default:
                     break
                          }
                          
    }
}

/*extension ViewController: CLLocationManagerDelegate {
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last{
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        print(lat)
        print (lon)
        
        }
       
    }

func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
}
 
}
 */
