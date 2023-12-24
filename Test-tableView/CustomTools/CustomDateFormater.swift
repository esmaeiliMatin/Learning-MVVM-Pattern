//
//  DateFormater.swift
//  Test-tableView
//
//  Created by Matin on 2023-12-24.
//

import Foundation

class CustomDateFormater {
    
    static func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM d, yyyy"
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
