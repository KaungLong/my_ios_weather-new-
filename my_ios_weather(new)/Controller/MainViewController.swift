//
//  ViewController.swift
//  my_ios_weather(new)
//
//  Created by 危末狂龍 on 2023/2/22.
//

import UIKit

class MainViewController: UIViewController {
    
    
    var countryDataClient = CountryDataHTTPClient()
    var searchTableViewController = SearchTableViewController()
    
    //MARK: - UI
    let mainTableView:UITableView = {
        let mainTableView = UITableView(frame: .zero, style: .insetGrouped)
        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        return mainTableView
    }()
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.translatesAutoresizingMaskIntoConstraints = true
        refreshControl.tintColor = .gray
        refreshControl.backgroundColor = .white
        return refreshControl
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        delegate()
        setupNavigation()
   
        Task{
            try await countryDataClient.getCountryData()
            print(countryDataClient.countrys[0])
        }
        
    }
    
    func delegate(){
        mainTableView.dataSource = self
        mainTableView.delegate = self
        searchTableViewController.delegate = self
    }
    
    private func setupUI(){
        view.addSubview(mainTableView)
        mainTableView.addSubview(refreshControl)
        mainTableView.frame = view.bounds
        mainTableView.backgroundColor = .systemBackground
    }
    
    private func setupNavigation(){
        let systemMenu = UIMenu(title: "",options: .displayInline, children: [
            UIAction(title: "編輯列表", image: UIImage(systemName: "pencil"), handler: { (_) in
                
            }),
            UIAction(title: "通知", image: UIImage(systemName: "bell.badge"), handler: { (_) in
            }),
        ])
        
        let tempMenu = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "攝氏", image: UIImage(systemName: ""), handler: { (_) in
            }),
            UIAction(title: "華氏", image: UIImage(systemName: ""), handler: { (_) in
            }),
        ])
        let reportMenu = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "問題回報", image: UIImage(systemName: "") ,handler:{ [self] (_) in
                //                self.APItest()
            }),
        ])
        
        let subMenu = UIMenu(title: "", options: .displayInline, children: [systemMenu, tempMenu,reportMenu])//
        
        navigationItem.title = "Weather"
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "ellipsis.circle"), primaryAction: nil, menu: subMenu)//
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        //搜尋欄
        let searchController = UISearchController(searchResultsController: searchTableViewController )
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "開始搜尋城市或機場"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("touch")
        if let searchText = searchController.searchBar.text, searchText.isEmpty == false{
            searchTableViewController.countries = countryDataClient.countrys.filter({ country in
                country.localizedStandardContains(searchText)
            })
            print("re")
        }else{
            searchTableViewController.countries = []
        }
        searchTableViewController.tableView.reloadData()
        print("over")
    }

}

extension MainViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {return UITableViewCell()}
        let currentWeather = WeatherStore.shared.weathers[indexPath.section]
        cell.locationLabel.text = currentWeather.name
        cell.timeLabel.text = currentWeather.dt.time(format: "HH:mm")
        cell.destributionLabel.text = currentWeather.weather[indexPath.row].description
        cell.tempLabel.text = "\(WeatherDataHTTPClient.tempFormate(currentWeather.main.temp))"
        cell.temp_MaxMin.text = "H: \(WeatherDataHTTPClient.tempFormate(currentWeather.main.temp_max))   L: \(WeatherDataHTTPClient.tempFormate(currentWeather.main.temp_min))"
        cell.layer.borderWidth = 1

        return cell
    }
    
}

extension MainViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return WeatherStore.shared.weathers.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MainPageViewController()
        vc.initialPage = indexPath.section
        let mainPageNav = UINavigationController(rootViewController: vc)
        mainPageNav.navigationBar.isHidden = true
        mainPageNav.modalPresentationStyle = .fullScreen
        present(mainPageNav, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (indexPath.section+1) != 0{
            if editingStyle == .delete {
                WeatherStore.shared.remove(indexPath.section)
                print("\(indexPath.section)+所刪除行數")
                mainTableView.reloadData()
            }
        }
    }
}

//MARK: - SaveWeatherDelegate
extension MainViewController:SaveWeatherDelegate{
    func saveWeather(weatherData: CurrentWeather) {

        WeatherStore.shared.append(weatherData)
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
}
