//
//  DateListViewModel.swift
//  APOD
//
//  Created by Gil Rodarte on 06/11/20.
//

import Foundation

class DateListViewModel {
    
    // MARK: Properties
    
    var reloadTableView: (() -> ())?
    
    var dates: [Date] = [] {
        didSet {
            reloadTableView?()
        }
    }
    
    var numberOfDates: Int {
        dates.count
    }
    
    // MARK: Methods
    
    func fetchDates() {
        var dates: [Date] = []
        let today = Date()
        
        for i in 0...99 {
            if let previousDate = Calendar.current.date(byAdding: .day, value: -i, to: today) {
                dates.append(previousDate)
            }
        }
        
        self.dates = dates
    }
    
    func getDate(at indexPath: IndexPath) -> Date {
        dates[indexPath.row]
    }
    
    func getDateString(at indexPath: IndexPath) -> String {
        dates[indexPath.row].toString()
    }
    
}
