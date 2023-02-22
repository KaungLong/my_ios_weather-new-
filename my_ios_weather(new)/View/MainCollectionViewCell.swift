//
//  MainCollectionViewCell.swift
//  my_ios_weather(new)
//
//  Created by 危末狂龍 on 2023/2/22.
//

import Foundation
import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "mainCollectionView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cyan
        layer.cornerRadius = 20
//        delegate()
//        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
