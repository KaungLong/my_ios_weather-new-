//
//  SearchTableViewController.swift
//  my_ios_weather(new)
//
//  Created by 危末狂龍 on 2023/2/22.
//

import Foundation
import UIKit



class SearchTableViewController: UITableViewController {

    var countries = [String]()
    var delegate:SaveWeatherDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = view.bounds
            
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(countries.count)")
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = countries[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries[indexPath.row]
        print(country)
        let vc = AddCityWeatherViewController()
        vc.cityName = country
        Task{
            vc.currentWeatherData = try await WeatherDataHTTPClient.CurrentWeatherData(city:country)
            vc.forcastWeatherData = try await WeatherDataHTTPClient.ForecastWeatherData(city: country)
            vc.forecastRow = vc.forcastWeatherData!.list
            vc.mainCollectionView.reloadData()
            
            let addWeatherNC = UINavigationController(rootViewController: vc)
            present(addWeatherNC, animated: true, completion: nil)
        }
        vc.delegate = self.delegate
        
    }
}
