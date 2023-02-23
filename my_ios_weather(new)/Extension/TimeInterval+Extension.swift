//
//  TimeInterval+Extension.swift
//  my_ios_weather(new)
//
//  Created by 危末狂龍 on 2023/2/23.
//

import Foundation

extension TimeInterval{
    
    func time(format:String) -> String{
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }

}
