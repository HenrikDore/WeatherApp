//
//  WeatherAPI.swift
//  Labb1weatherApp
//
//  Created by Henrik Doré on 2020-02-05.
//  Copyright © 2020 Henrik Doré. All rights reserved.
//

import Foundation
import CoreLocation

struct weatherAPI {
    let APIkey: String = "31f8d73de6e893d2411c1a8b626497f4&units=metric"
    let baseUrl: String = "http://api.openweathermap.org/data/2.5/weather?q="
    let locationUrl: String = "http://api.openweathermap.org/data/2.5/weather?lat="
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=31f8d73de6e893d2411c1a8b626497f4&units=metric"
    
    
    
    func getWeatherInCity(searchedCity: String, completion: @escaping(Result<weatherInCity, Error>)-> Void){
        let completeURL: String = baseUrl + searchedCity + "&appid=" + APIkey
        guard let url: URL = URL(string: completeURL) else {return}
        print("Creating Request")
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let unwrappedError = error {
                print("Error: \(unwrappedError)")
                completion(.failure(unwrappedError))
                return
            }
            if let unwrappedData = data {
            do {

                let decoder = JSONDecoder()
                let cityWeather: weatherInCity = try decoder.decode(weatherInCity.self, from: unwrappedData)
                print("Stad:  \(cityWeather.name)")
                print("Temperatur: \(cityWeather.main.temp)°c")
                print(cityWeather.weather[0].description)
                print(cityWeather.weather[0].id)
                completion(.success(cityWeather))
            }catch{
                print("Couldn't prase JSON..")
            }
            }
        }
        task.resume()
        print("Task Started")
    }
    func getLocationWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping(Result<weatherInCity, Error>)-> Void){
    let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
    guard let url: URL = URL(string: urlString) else {return}
    print("Creating Request")
    let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
        if let unwrappedError = error {
            print("Error: \(unwrappedError)")
            completion(.failure(unwrappedError))
            return
        }
        if let unwrappedData = data {
        do {

            let decoder = JSONDecoder()
            let cityWeather: weatherInCity = try decoder.decode(weatherInCity.self, from: unwrappedData)
            completion(.success(cityWeather))
        }catch{
            print("Couldn't prase JSON..")
        }
        }
    }
    task.resume()
    print("Task Started")
}
}
/*
 func getLocationWeather(latitude: CLLocationDegrees , longitude: CLLocationDegrees){
 let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
 
 */
    


