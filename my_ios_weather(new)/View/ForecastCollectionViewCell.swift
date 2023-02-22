//
//  ForecastCollectionViewCell.swift
//  my_ios_weather(new)
//
//  Created by 危末狂龍 on 2023/2/22.
//

import Foundation
import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ForecastCollectionViewCell"
    
    var forecastWeatherData: ForecastWeather?
    var forecastRow = [ForecastWeather.List]()
    
    let forecastCellView :UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let HourlyForecastCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 100)
        let hourlyForecastCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        hourlyForecastCollectionView.backgroundColor = .brown
        hourlyForecastCollectionView.showsHorizontalScrollIndicator = false
        hourlyForecastCollectionView.register(HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.identifier)
        hourlyForecastCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return hourlyForecastCollectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cyan
        layer.cornerRadius = 20
        delegate()
        ForecastSetupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func delegate(){
        HourlyForecastCollectionView.dataSource = self
        HourlyForecastCollectionView.delegate = self
    }
    
    func ForecastSetupConstraints(){
        self.addSubview(forecastCellView)
        print("佈局forecast")
        forecastCellView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 6).isActive = true
        forecastCellView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 6).isActive = true
        forecastCellView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -6).isActive = true
        forecastCellView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -6).isActive = true
        
        forecastCellView.backgroundColor = .red
        forecastCellView.addSubview(HourlyForecastCollectionView)
        
        HourlyForecastCollectionView.topAnchor.constraint(equalTo: forecastCellView.safeAreaLayoutGuide.topAnchor, constant: 6).isActive = true
        HourlyForecastCollectionView.leftAnchor.constraint(equalTo: forecastCellView.safeAreaLayoutGuide.leftAnchor, constant: 6).isActive = true
        HourlyForecastCollectionView.rightAnchor.constraint(equalTo: forecastCellView.safeAreaLayoutGuide.rightAnchor, constant: -6).isActive = true
        HourlyForecastCollectionView.bottomAnchor.constraint(equalTo: forecastCellView.safeAreaLayoutGuide.bottomAnchor, constant: -6).isActive = true
    }
}

extension ForecastCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return forecastRow.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCollectionViewCell.identifier, for: indexPath) as? HourlyForecastCollectionViewCell else { return UICollectionViewCell() }
        if forecastRow.count > 0 {
            let forecastMain = forecastRow[indexPath.row].main
            let forecastWeather = forecastRow[indexPath.row].weather
            let forecastTime = forecastRow[indexPath.row].dt
 
            myCell.WeatherImageView.image = UIImage(named: forecastWeather[0].icon)
            myCell.tempLabel.text = "🌡 \(WeatherDataHTTPClient.tempFormate(forecastMain.temp))℃"
            myCell.humidityLabel.text = "💧 " + String(forecastMain.humidity) + "%"
            myCell.timeLabel.text = timeFormate(forecastTime)

            let suffix = forecastWeather[0].icon.suffix(1)
            if suffix == "n" {
                myCell.backgroundColor = .black
                myCell.tempLabel.textColor = .white
                myCell.humidityLabel.textColor = .white
                myCell.timeLabel.textColor = .white
            }
            if suffix == "d" {
                myCell.backgroundColor = .white
                myCell.tempLabel.textColor = .black
                myCell.humidityLabel.textColor = .black
                myCell.timeLabel.textColor = .black
            }
        }
        myCell.backgroundColor = UIColor.blue
        
        return myCell
    }

    func timeFormate(_ date: Date?) -> String {
        guard let inputDate = date else { return "" }
        let formatter = DateFormatter()
        let timezone = forecastWeatherData?.city.timezone
        formatter.timeZone = TimeZone(secondsFromGMT: timezone!)
        formatter.dateFormat = "MM/dd E h:mm a"
        return formatter.string(from: inputDate)
    }
}

extension ForecastCollectionViewCell: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
    

}

extension ForecastCollectionViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 16, right: 4)
    }
    //cell的寬高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 200 , height: frame.height)
    }
}
