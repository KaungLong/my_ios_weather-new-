//
//  AddCityWeatherViewController.swift
//  my_ios_weather(new)
//
//  Created by 危末狂龍 on 2023/2/22.
//

import Foundation
import UIKit

protocol SaveWeatherDelegate:AnyObject{
    func saveWeather(weatherData:CurrentWeather)
}

class AddCityWeatherViewController: UIViewController {
    
    var cityName:String = ""
    var currentWeatherData: CurrentWeather?
    var forcastWeatherData: ForecastWeather?
    var forecastRow = [ForecastWeather.List]()
    var delegate: SaveWeatherDelegate?
    
    let mainCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //sticky header!!
        layout.sectionHeadersPinToVisibleBounds = true

        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .brown
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        print("coll")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "mycell")
        collectionView.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: ForecastCollectionViewCell.identifier)
        collectionView.register(CurrentCollectionViewCell.self, forCellWithReuseIdentifier: CurrentCollectionViewCell.identifier)
        collectionView.register(MainHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainHeaderCollectionReusableView.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemGroupedBackground
        view.overrideUserInterfaceStyle = .dark
        setupNavigation()
        
        self.view.addSubview(mainCollectionView)
        setupConstraints()
        setupDelegate()
        
        Task{
            currentWeatherData = try await WeatherDataHTTPClient.CurrentWeatherData(city:cityName)
            self.mainCollectionView.reloadSections([0])
        }
        Task {
            forcastWeatherData = try await WeatherDataHTTPClient.ForecastWeatherData(city: cityName)
            forecastRow = forcastWeatherData!.list
            self.mainCollectionView.reloadSections([1])
        }
    }
    
    func setupDelegate() {
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
    }
    
    func setupNavigation(){
        navigationItem.title = "Weather"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:#selector(cancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButton))

        //設定各物件顏色
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    func setupConstraints(){
        mainCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 6).isActive = true
        mainCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 6).isActive = true
        mainCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        mainCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -6).isActive = true
    }
    
    func showCurrentWeatherInfo(cell: CurrentCollectionViewCell) {
        if let weatherIcon = self.currentWeatherData?.weather.first?.icon,
           let weatherDesc = self.currentWeatherData?.weather.first?.description,
           let cityName = self.currentWeatherData?.name,
           let date = self.currentWeatherData?.dt,
           let localTime = self.currentWeatherData?.dt,
           let temp = self.currentWeatherData?.main.temp,
           let tempFeel = self.currentWeatherData?.main.feelsLike,
           let hum = self.currentWeatherData?.main.humidity,
           let wind = self.currentWeatherData?.wind.speed,
           let temp_Min = self.currentWeatherData?.main.temp_min,
           let temp_Max = self.currentWeatherData?.main.temp_max,
           let suffix =  self.currentWeatherData?.weather.first?.icon.suffix(1)
            {
//            DispatchQueue.main.async {
                cell.locationLabel.text = cityName.capitalized
                cell.tempLabel.text = "\(WeatherDataHTTPClient.tempFormate(temp))º"
                cell.temp_MaxMin.text = "H:\(temp_Max) L:\(temp_Min)"
                cell.destributionLabel.text = weatherDesc
                cell.WeatherImageView.image = UIImage(named: weatherIcon)
                print("gg+\(weatherIcon)")
//            }

        }
    }
    
    @objc func cancelButton(){
        self.dismiss(animated: true)
    }
    @objc func saveButton(){
        delegate?.saveWeather(weatherData: currentWeatherData!)
        
        view.window?.rootViewController?.dismiss(animated: true)
        WeatherStore.shared.updateAPI()
    }
    
}

//MARK: UICollectionViewDataSource
extension AddCityWeatherViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let homeSection = HomeSection(rawValue: indexPath.section) else {return UICollectionViewCell()}
        
        switch homeSection {
        case.Current:
            guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentCollectionViewCell.identifier, for: indexPath) as? CurrentCollectionViewCell else { return UICollectionViewCell() }
            showCurrentWeatherInfo(cell: myCell)
            return myCell
        case.Forecast:
            guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCollectionViewCell.identifier, for: indexPath) as? ForecastCollectionViewCell else { return UICollectionViewCell() }
            myCell.forecastWeatherData = forcastWeatherData
            myCell.forecastRow = forecastRow
            return myCell
        case.test1:
            let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as UICollectionViewCell
            myCell.backgroundColor = .gray
            return myCell
        case .test2:
            let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as UICollectionViewCell
            myCell.backgroundColor = .orange
            return myCell
        }
    }
    //header的cell
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainHeaderCollectionReusableView.identifier, for: indexPath) as! MainHeaderCollectionReusableView
        
        guard let homeSection = HomeSection(rawValue: indexPath.section) else {return UICollectionReusableView()}
        
        switch homeSection {
            case .Current:
                header.headerLabel.text = ""
            case .Forecast:
                header.headerLabel.text = "未來天氣預報"
            case .test1:
                header.headerLabel.text = "標題1"
            case .test2:
                header.headerLabel.text = "標題2"
        }
        
        return header
    }
}

extension AddCityWeatherViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 16, right: 4)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let homeSection = HomeSection(rawValue: indexPath.section) else {return CGSize.zero}
        switch homeSection {
        case .Current:
            return CGSize(width: self.view.frame.width, height: 312)
        case.Forecast:
            return CGSize(width: self.view.frame.width, height: 200)
        case .test1:
            return CGSize(width: self.view.frame.width, height: 900)
        case .test2:
            return CGSize(width: self.view.frame.width, height: 900)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let homeSection = HomeSection(rawValue: section) else {return CGSize.zero}
        switch homeSection {
        case .Current:
            return CGSize.zero
        case .Forecast:
            return CGSize(width: self.view.frame.width, height: 26)
        case .test1:
            return CGSize(width: self.view.frame.width/2-100 , height: 26)
        case .test2:
            return CGSize(width: self.view.frame.width/2-100 , height: 26)
//        case .buttom:
//            return CGSize.zero
//        default:
//            return CGSize(width: (frame.width-50)/2, height: 20)
        }
//        return CGSize(width: frame.width, height: 20)
    }
}

//MARK: - Collection section enum
extension AddCityWeatherViewController {
    enum HomeSection:Int, CaseIterable{
        case Current = 0,Forecast, test1,test2 //descript, buttom
    }

}
