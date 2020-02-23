//
//  WeatherInCity.swift
//  Labb1weatherApp
//
//  Created by Henrik Doré on 2020-02-06.
//  Copyright © 2020 Henrik Doré. All rights reserved.
//

import Foundation

struct weatherInCity: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
   // let coord: coord
    
}
struct coord: Decodable{
    let lon: String
    let lat: String
}
 

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
    
}
struct Weather: Decodable {
    let description: String
    let id: Int 
}
struct Wind: Decodable{
    let speed: Double
    let deg: Int
}
extension Double {
    func toString() -> String {
        return String(format: "%.1f",self)
    }
}
extension String {
  func replace(string:String, replacement:String) -> String {
      return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
  }

  func removeWhitespace() -> String {
      return self.replace(string: " ", replacement: "%20")
  }
}
