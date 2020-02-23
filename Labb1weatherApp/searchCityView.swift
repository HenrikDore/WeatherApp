//
//  searchCityView.swift
//  Labb1weatherApp
//
//  Created by Henrik Doré on 2020-02-21.
//  Copyright © 2020 Henrik Doré. All rights reserved.
//

import UIKit
import Foundation


class searchCityView: UIViewController{
    
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var feelsLikeLbl: UILabel!
    @IBOutlet weak var recClothesImg2: UIImageView!
    @IBOutlet weak var recClothesImg: UIImageView!
    @IBOutlet weak var searchedCityLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var descriptLbl: UILabel!
    @IBOutlet weak var recommendLbl: UILabel!
    
    
    var showSearchedCity = ""
    
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        getSearchedWeather()
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [recClothesImg,recClothesImg2])
        animator.addBehavior(gravity)
        collision = UICollisionBehavior(items: [recClothesImg,recClothesImg2])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
            
    }

    func getSearchedWeather(){
       let APIforWeather = weatherAPI()
       
       APIforWeather.getWeatherInCity(searchedCity: showSearchedCity) { (result) in
               
               switch result {
               case .success(let weatherUI):
                   DispatchQueue.main.async {
                    self.searchedCityLbl.text = weatherUI.name
                    self.descriptLbl.text = weatherUI.weather[0].description
                    self.tempLbl.text = weatherUI.main.temp.toString() + "°c"
                    self.setDisciptionImage()
                    self.setRecommendedClothes(temp: weatherUI.main.temp, weatherID: weatherUI.weather[0].id)
                    self.setSuggestedImg(temp: weatherUI.main.temp, weatherID: weatherUI.weather[0].id)
                    self.feelsLikeLbl.text = "Temp feels like: \(weatherUI.main.feels_like.toString())°c"
                    self.windLbl.text = "Windspeed: \(weatherUI.wind.speed.toString()) m/s"


                    
                    
                       
                   }
               case .failure(let error): print("Error \(error)")
           }
       }
       
}
        func setDisciptionImage(){
        switch self.descriptLbl.description {
            case let str where str.contains("clear sky"):
                self.weatherImg.image = UIImage(named: "sun")
            case let str where str.contains("rain"):
                self.weatherImg.image = UIImage(named: "rain")
            case let str where str.contains("drizzle"):
            self.weatherImg.image = UIImage(named: "rain")
            case let str where str.contains("light intensity shower rain"):
                self.weatherImg.image = UIImage(named: "rain")
            case let str where str.contains("broken clouds"):
                self.weatherImg.image = UIImage(named: "brokenClouds")
            case let str where str.contains("overcast clouds"):
                self.weatherImg.image = UIImage(named: "brokenClouds")
        case let str where str.contains("few clouds"):
            self.weatherImg.image = UIImage(named: "sunWithCloud")
        case let str where str.contains("scattered clouds"):
            self.weatherImg.image = UIImage(named: "sunWithCloud")
        case let str where str.contains("light snow"):
            self.weatherImg.image = UIImage(named: "snow")
            
        default:
            break
            }
            
    }
    func setRecommendedClothes(temp: Double, weatherID: Int){
            
        if (temp <= 0){
                  switch weatherID {
                  case 200...232:
                      self.recommendLbl.text = "Stanna inne.."
                  case 300...321:
                      self.recommendLbl.text = "varma regnkläder"
                  case 500...531:
                      self.recommendLbl.text = "varma regnkläder"
                  case 600...622:
                      self.recommendLbl.text = "Varma kläder"
                  case 701:
                      self.recommendLbl.text = "Varma kläder"
                  case 711:
                      self.recommendLbl.text = "Stanna inne"
                  case 721:
                      self.recommendLbl.text = "Vanliga kläder"
                  case 731:
                      self.recommendLbl.text = "Stanna inne"
                  case 741:
                      self.recommendLbl.text = "Vanliga kläder"
                  case 800:
                      self.recommendLbl.text = "Varma kläder"
                  case 801...804:
                      self.recommendLbl.text = "Varma kläder, mössa och vantar"
                  default:
                      break
                  }
        }
        if (temp <= 10){
            switch weatherID {
            case 200...232:
                self.recommendLbl.text = "Stanna inne.."
            case 300...321:
                self.recommendLbl.text = "Paraply & varma kläder"
            case 500...531:
                self.recommendLbl.text = "Paraply & varma kläder"
            case 600...622:
                self.recommendLbl.text = "Varma kläder"
            case 701:
                self.recommendLbl.text = "Varma kläder"
            case 711:
                self.recommendLbl.text = "Stanna inne"
            case 721:
                self.recommendLbl.text = "Vanliga kläder"
            case 731:
                self.recommendLbl.text = "Stanna inne"
            case 741:
                self.recommendLbl.text = "Vanliga kläder"
            case 800:
                self.recommendLbl.text = "Varma kläder"
            case 801...804:
                self.recommendLbl.text = "Varma kläder, kanske värt att ta med ett paraply"
            default:
                break
            }
        }
        if (temp >= 11 && temp <= 20){
            switch weatherID {
                       case 200...232:
                           self.recommendLbl.text = "Stanna inne.."
                       case 300...321:
                           self.recommendLbl.text = "Du kommer behöva ett paraply"
                       case 500...531:
                           self.recommendLbl.text = "Du kommer behöva ett paraply"
                       case 600...622:
                           self.recommendLbl.text = "Varma kläder"
                       case 701:
                           self.recommendLbl.text = "Vanliga kläder"
                       case 711:
                           self.recommendLbl.text = "Stanna inne.."
                       case 721:
                           self.recommendLbl.text = "Vanliga kläder"
                       case 731:
                           self.recommendLbl.text = "Stanna inne"
                       case 741:
                           self.recommendLbl.text = "Vanliga kläder"
                       case 800:
                           self.recommendLbl.text = "Kanske en tunnare jacka"
                       case 801...804:
                           self.recommendLbl.text = "Vanliga kläder"
                       default:
                           break
            }
        }
        if (temp >= 21){
        switch weatherID {
                   case 200...232:
                       self.recommendLbl.text = "Stanna inne.."
                   case 300...321:
                       self.recommendLbl.text = "Du behöver kanske ett paraply"
                   case 500...531:
                       self.recommendLbl.text = "Du behöver kanske ett paraply"
                   case 600...622:
                       self.recommendLbl.text = "Sjukt att det snöar, men kanske en tröja"
                   case 701:
                       self.recommendLbl.text = "Vanliga kläder"
                   case 711:
                       self.recommendLbl.text = "Stanna inne.."
                   case 721:
                       self.recommendLbl.text = "Vanliga kläder"
                   case 731:
                       self.recommendLbl.text = "Stanna inne"
                   case 741:
                       self.recommendLbl.text = "Vanliga kläder"
                   case 800:
                       self.recommendLbl.text = "Ha på dig vad du vill"
                   case 801...804:
                       self.recommendLbl.text = "Vanliga kläder"
                   default:
                       break
                   }
        
}
}
    func setSuggestedImg(temp: Double, weatherID: Int){
    if (temp <= 10){
        switch weatherID {
        case 200...232:
            self.recClothesImg.image = UIImage(named: "umbrella")
        case 300...321:
            self.recClothesImg.image = UIImage(named: "umbrella")
            self.recClothesImg2.image = UIImage(named: "winterjacket")
        case 500...531:
            self.recClothesImg.image = UIImage(named: "umbrella")
            self.recClothesImg2.image = UIImage(named: "winterjacket")
        case 600...622:
            self.recClothesImg.image = UIImage(named: "winterjacket")
            self.recClothesImg2.image = UIImage(named: "mitten")
        case 701...721:
            self.recClothesImg.image = UIImage(named:"winterhat")
            self.recClothesImg2.image = UIImage(named: "winterjacket")
        case 800...804:
            self.recClothesImg.image = UIImage(named: "winterjacket")
            self.recClothesImg2.image = UIImage(named: "winterhat")
        default:
            break
        };
        }
        if (temp >= 10 && temp <= 20){
        switch weatherID {
        case 200...232:
            self.recClothesImg.image = UIImage(named: "umbrella")
        case 300...321:
            self.recClothesImg.image = UIImage(named: "umbrella")
        case 500...531:
            self.recClothesImg.image = UIImage(named: "umbrella")
        case 600...622:
            self.recClothesImg2.image = UIImage(named: "mitten")
            self.recClothesImg.image = UIImage(named: "winterhat")
        case 701...721:
            self.recClothesImg.image = UIImage(named:"winterhat")
            self.recClothesImg2.image = UIImage(named: "sweatshirt")
        case 800...804:
            self.recClothesImg.image = UIImage(named: "sweatshirt")
            self.recClothesImg2.image = UIImage(named: "cap")
        default:
            break
            }
        }
        if (temp >= 20){
        switch weatherID {
        case 200...232:
            self.recClothesImg.image = UIImage(named: "umbrella")
        case 300...321:
            self.recClothesImg.image = UIImage(named: "umbrella")
        case 500...531:
            self.recClothesImg.image = UIImage(named: "umbrella")
        case 600...622:
            self.recClothesImg2.image = UIImage(named: "winterhat")
        case 701...721:
            self.recClothesImg.image = UIImage(named:"shirt")
        case 800...804:
            self.recClothesImg.image = UIImage(named: "shirt")
            self.recClothesImg2.image = UIImage(named: "cap")
        default:
            break
            }
}


}
}



