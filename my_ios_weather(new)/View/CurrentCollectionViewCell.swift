//
//  CurrentCollectionViewCell.swift
//  my_ios_weather(new)
//
//  Created by 危末狂龍 on 2023/2/22.
//

import Foundation
import UIKit

class CurrentCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CurrentCollectionViewCell"
    
    //MARK: - UI
    let titleCellView :UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let WeatherImageView:UIImageView = {
        let weatherimage = UIImageView()
        weatherimage.frame.size.width = 150
        weatherimage.frame.size.height = 150
        weatherimage.backgroundColor = .systemPink
        weatherimage.image = UIImage(systemName: "network")
        weatherimage.translatesAutoresizingMaskIntoConstraints   = false
        weatherimage.contentMode = .scaleAspectFit
        print("image")
        return weatherimage
    }()
    
    lazy var labelStackView:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
          locationLabel, tempLabel, destributionLabel, temp_MaxMin
        ])
//        stackView.backgroundColor = .blue
        stackView.setCustomSpacing(4, after: destributionLabel)
        stackView.spacing = 8
        stackView.backgroundColor = .purple
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let locationLabel:UILabel = {
        let label = UILabel()
        label.text = "_"
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "_"
        label.font = UIFont.systemFont(ofSize: 50)
        return label
    }()
    
    let destributionLabel:UILabel = {
        let label = UILabel()
        label.text = "_"
        return label
    }()
    
    let temp_MaxMin: UILabel = {
        let label = UILabel()
        label.text = "_"
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cyan
        layer.cornerRadius = 20
//        delegate()
        CurrentSetupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func CurrentSetupConstraints(){
        self.addSubview(titleCellView)
        print("佈局Current")
        titleCellView.addSubview(WeatherImageView)
        titleCellView.addSubview(labelStackView)
        
        titleCellView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 6).isActive = true
        titleCellView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 6).isActive = true
        titleCellView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -6).isActive = true
        titleCellView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -6).isActive = true
        
        
        WeatherImageView.topAnchor.constraint(equalTo: titleCellView.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        WeatherImageView.leftAnchor.constraint(equalTo: titleCellView.safeAreaLayoutGuide.leftAnchor, constant: 6).isActive = true
        WeatherImageView.centerXAnchor.constraint(equalTo: titleCellView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        WeatherImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true

        labelStackView.topAnchor.constraint(equalTo: WeatherImageView.bottomAnchor, constant: 0).isActive = true
        labelStackView.leadingAnchor.constraint(equalTo: titleCellView.safeAreaLayoutGuide.leadingAnchor, constant: 6).isActive = true
        labelStackView.centerXAnchor.constraint(equalTo: titleCellView.centerXAnchor).isActive = true
        labelStackView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    
}
