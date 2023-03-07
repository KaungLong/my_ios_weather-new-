//
//  HourlyForecastCollectionViewCell.swift
//  my_ios_weather(new)
//
//  Created by 危末狂龍 on 2023/2/22.
//

import Foundation
import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HourlyForecastCollectionViewCell"
    
    let cellView :UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timeLabel:UILabel = {
        let label = UILabel()
        label.text = "_"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let tempLabel:UILabel = {
        let label = UILabel()
        label.text = "_"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let humidityLabel:UILabel = {
        let label = UILabel()
        label.text = "_"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let WeatherImageView:UIImageView = {
        let weatherimage = UIImageView()
        weatherimage.image = UIImage(systemName: "network")
        weatherimage.translatesAutoresizingMaskIntoConstraints   = false
        weatherimage.contentMode = .scaleAspectFit
        print("image")
        return weatherimage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
        let TopStackView = UIStackView(arrangedSubviews: [
            timeLabel
        ])
        let BottomStackView = UIStackView(arrangedSubviews: [
            WeatherImageView, tempLabel,humidityLabel
        ])
        
        WeatherImageView.topAnchor.constraint(equalTo: BottomStackView.topAnchor, constant: 2).isActive = true
        WeatherImageView.bottomAnchor.constraint(equalTo: BottomStackView.bottomAnchor, constant: -2).isActive = true
        WeatherImageView.leftAnchor.constraint(equalTo: BottomStackView.leftAnchor, constant: 2).isActive = true
        WeatherImageView.rightAnchor.constraint(equalTo: BottomStackView.leftAnchor, constant: 72).isActive = true
        
        tempLabel.leftAnchor.constraint(equalTo: WeatherImageView.rightAnchor, constant:0).isActive = true
        tempLabel.rightAnchor.constraint(equalTo: BottomStackView.rightAnchor, constant: -2).isActive = true
        tempLabel.topAnchor.constraint(equalTo: BottomStackView.topAnchor, constant: 2).isActive = true
        tempLabel.bottomAnchor.constraint(equalTo: BottomStackView.centerYAnchor, constant: 0).isActive = true
        
        humidityLabel.leftAnchor.constraint(equalTo: WeatherImageView.rightAnchor, constant:0).isActive = true
        humidityLabel.rightAnchor.constraint(equalTo: BottomStackView.rightAnchor, constant: -2).isActive = true
        humidityLabel.topAnchor.constraint(equalTo: BottomStackView.centerYAnchor, constant: 2).isActive = true
        humidityLabel.bottomAnchor.constraint(equalTo: BottomStackView.bottomAnchor, constant: -2).isActive = true
        
        self.addSubview(cellView)
        cellView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 6).isActive = true
        cellView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 6).isActive = true
        cellView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -6).isActive = true
        cellView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -6).isActive = true
        
        cellView.addSubview(TopStackView)
        cellView.addSubview(BottomStackView)

        TopStackView.translatesAutoresizingMaskIntoConstraints = false
        TopStackView.axis = .horizontal
        TopStackView.setCustomSpacing(2, after: timeLabel)
        BottomStackView.axis = .horizontal
        BottomStackView.alignment = .center
        BottomStackView.spacing = 2
        BottomStackView.translatesAutoresizingMaskIntoConstraints = false

        TopStackView.topAnchor.constraint(equalTo: self.topAnchor,constant: 2).isActive = true
        TopStackView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 2).isActive = true
        TopStackView.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -2).isActive = true
        TopStackView.bottomAnchor.constraint(equalTo: self.centerYAnchor,constant: -2).isActive = true
        BottomStackView.topAnchor.constraint(equalTo: TopStackView.bottomAnchor,constant: 2).isActive = true
        BottomStackView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 2).isActive = true
        BottomStackView.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -2).isActive = true
        BottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -2).isActive = true
        
    }
}
