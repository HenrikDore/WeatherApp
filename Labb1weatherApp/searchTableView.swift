//
//  searchTableView.swift
//  Labb1weatherApp
//
//  Created by Henrik Doré on 2020-02-14.
//  Copyright © 2020 Henrik Doré. All rights reserved.
//

import Foundation
import UIKit

class searchTableView: UIViewController {

   
    
    @IBOutlet weak var tableView: UITableView!
    
    let cities: [String] = getCitiesFromJson()
    var filteredCities: [String] = []
    var searchedCity: String = ""
    let nocites: [String] = []
       
    var isSearching: Bool {
           if filteredCities.count > 0 {
               return true
           } else {
               return false
           }
           
       }
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")

        tableView.delegate = self
        tableView.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}


extension searchTableView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        print("Search text: \(searchText)")
        filteredCities = cities.filter( { $0.lowercased().contains(searchText.lowercased()) } )
        
        tableView.reloadData()
        
    }
    
}

extension searchTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
        return filteredCities.count
        }
        return nocites.count
 
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        
        if isSearching {
            cell.textLabel?.text = filteredCities[indexPath.row]
        } else {
            cell.textLabel?.text = cities[indexPath.row]
        }
        
        return cell
     }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        searchedCity = filteredCities[indexPath.row]
        
        self.performSegue(withIdentifier: "mysegue", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mysegue" {
           if let destinationVC = segue.destination as? UINavigationController,
            let targetController = destinationVC.topViewController as? searchCityView  {
            targetController.showSearchedCity = searchedCity.removeWhitespace()
            
        }
    }
}
}
func getCitiesFromJson() -> [String] {
    
    //let fileName: String = "cityinalist"
    
    do {
    
        if let file = Bundle.main.url(forResource: "citylist", withExtension: "json") {
        
            let data = try Data.init(contentsOf: file)
            
            let decoder = JSONDecoder()
            
            let cityList: [String] = try decoder.decode([String].self, from: data)
            
            return cityList
        }
    } catch {
        
        print("Error with reading json")
    }
    
    return [String]()
}

