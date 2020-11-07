//
//  Date+Extension.swift
//  APOD
//
//  Created by Gil Rodarte on 06/11/20.
//

import Foundation

extension Date {
    
    func toString(dateFormat: String = "MMM d, yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
}
