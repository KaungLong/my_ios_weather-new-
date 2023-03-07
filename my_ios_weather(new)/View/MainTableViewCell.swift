//
//  MainTableViewCell.swift
//  my_ios_weather(new)
//
//  Created by 危末狂龍 on 2023/2/23.
//

import Foundation
import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let identifier = "MainTableViewCell"
    
    let locationLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    let timeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    let destributionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 34)
        return label
    }()
    
    let temp_MaxMin: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        let leftStackView = UIStackView(arrangedSubviews: [
            locationLabel, timeLabel, destributionLabel
        ])
        
        
        let rightStackView = UIStackView(arrangedSubviews: [
            tempLabel, temp_MaxMin
        ])
        
        self.addSubview(leftStackView)
        self.addSubview(rightStackView)
        
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.axis = .vertical
        leftStackView.setCustomSpacing(24, after: timeLabel)
        
        rightStackView.axis = .vertical
        rightStackView.alignment = .center
        rightStackView.spacing = 26
        rightStackView.translatesAutoresizingMaskIntoConstraints = false

        leftStackView.topAnchor.constraint(equalTo: self.topAnchor,constant: 8).isActive = true
        leftStackView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 14).isActive = true
        leftStackView.rightAnchor.constraint(equalTo: self.centerXAnchor,constant: -14).isActive = true
        
        rightStackView.topAnchor.constraint(equalTo: self.topAnchor,constant: 8).isActive = true
        rightStackView.leftAnchor.constraint(equalTo: self.centerXAnchor,constant: 14).isActive = true
        rightStackView.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -16).isActive = true

    }
    
}


