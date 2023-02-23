//
//  MainHeaderCollectionReusableView.swift
//  my_ios_weather(new)
//
//  Created by 危末狂龍 on 2023/2/22.
//

import Foundation
import UIKit

class MainHeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "mainHeaderCollectionReusableView"
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "header"
        label.tintColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func configure(){
        backgroundColor = .systemGreen
        addSubview(headerLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        headerLabel.frame = bounds
    }
}
