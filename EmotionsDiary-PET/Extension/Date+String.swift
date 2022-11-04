//
//  Date+String.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 29.10.2022.
//

import Foundation

// MARK: - Date extension

extension Date {
    public func convertToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy, HH:mm"
        return formatter.string(from: self)
    }
    
    public func timeString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}

// MARK: - String extension

extension String {
    public func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd.MM, HH:mm"
        return dateFormatter.date(from: self)
    }
}
