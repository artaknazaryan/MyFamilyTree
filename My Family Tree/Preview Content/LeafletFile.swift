//
//  BranchFile.swift
//  My Family Tree
//
//  Created by Artak on 13.09.24.
//

import Foundation
import SwiftUI

struct Leaflet: Identifiable {
    var id = UUID()
    var name: String
    var surname: String
    var patronymic: String
    let gender: Gender
    var dateOfBirth: DatePerson
    var dateOfDeath: DatePerson
    var placeOfBirth: String
    var placeOfResidence: String
}

enum Gender {
    case man
    case woman
}

enum Month: Int {
    case january = 1
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case december
}

//enum Month {
//    case january
//    case february
//    case march
//    case april
//    case may
//    case june
//    case july
//    case august
//    case september
//    case october
//    case november
//    case december
//
//    var name: String {
//        switch self {
//        case .january: return "January"
//        case .february: return "February"
//        case .march: return "March"
//        case .april: return "April"
//        case .may: return "May"
//        case .june: return "June"
//        case .july: return "July"
//        case .august: return "August"
//        case .september: return "September"
//        case .october: return "October"
//        case .november: return "November"
//        case .december: return "December"
//        }
//    }
//}


struct DatePerson {
    var year: Int?
    var month: Month?
    var day: Int?
    
    func formattedDate() -> String {
        // Проверяем, есть ли хотя бы один компонент даты
        if year == nil && month == nil && day == nil {
            return "неизвестно"
        }
        
        var components = [String]()
        
        if let year = year {
            components.append("\(year)")
        }
        if let month = month {
            components.append(month.fullMonthName())
        }
        if let day = day {
            components.append("\(day)")
        }
        
        return components.joined(separator: " ")
    }
}

extension Month {
    func fullMonthName() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM" // Полное название месяца
        let dateComponents = DateComponents(month: self.rawValue)
        let date = Calendar.current.date(from: dateComponents)
        return formatter.string(from: date!)
    }
}


var leafletPerson: [Leaflet] = [
    Leaflet(name: "Artak", surname: "Nazaryan", patronymic: "Lyova", gender: .man, dateOfBirth: DatePerson(year: 1980, month: .october, day: 23), dateOfDeath: DatePerson(), placeOfBirth: "Aramus", placeOfResidence: "Yerevan"),
]
