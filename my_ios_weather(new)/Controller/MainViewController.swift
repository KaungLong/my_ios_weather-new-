//
//  ViewController.swift
//  my_ios_weather(new)
//
//  Created by 危末狂龍 on 2023/2/22.
//

import UIKit

class MainViewController: UIViewController {
    
    var countryDataClient = CountryDataHTTPClient()
//    var countries: [Country] = []
//    var countrys = [String]()
    var searchTableViewController = SearchTableViewController()
    
    //MARK: - UI
    let mainTableView:UITableView = {
        let mainTableView = UITableView(frame: .zero, style: .insetGrouped)
        //        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: "cell")
        return mainTableView
    }()
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.translatesAutoresizingMaskIntoConstraints = true
        refreshControl.tintColor = .gray
        refreshControl.backgroundColor = .black
        return refreshControl
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        
        Task{
            try await countryDataClient.getCountryData()
            print(countryDataClient.countrys[0])
        }
        
        
        
        //        setupLoaction()
        //        view.backgroundColor = .white
        //        delegate()
        ////        location()
        setupNavigation()
        //        setupUI()
        //        allCountry.getCountry()
        
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
