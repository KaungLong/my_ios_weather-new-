//
//  AddCityWeatherViewController.swift
//  my_ios_weather(new)
//
//  Created by 危末狂龍 on 2023/2/22.
//

import Foundation
import UIKit

class AddCityWeatherViewController: UIViewController {
    
    var cityName:String = ""
    
    let mainCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //sticky header!!
        layout.sectionHeadersPinToVisibleBounds = true

        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .brown
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        print("coll")
//        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
//        collectionView.register(MainHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainHeaderCollectionReusableView.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemGroupedBackground
        view.overrideUserInterfaceStyle = .dark
        setupNavigation()
        
        self.view.addSubview(mainCollectionView)
        setupConstraints()
//        delegate()
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
    
    @objc func cancelButton(){
        self.dismiss(animated: true)
    }
    @objc func saveButton(){
//        delegate?.saveWeather(weatherData: weatherInfo!)
//        print("BB")
//        //        dismiss(animated: true)
//        view.window?.rootViewController?.dismiss(animated: true)
//        WeatherStore.shared.updateAPI()
    }
    
}
