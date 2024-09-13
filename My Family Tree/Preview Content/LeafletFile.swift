//
//  BranchFile.swift
//  My Family Tree
//
//  Created by Artak on 13.09.24.
//

import Foundation
import SwiftUI

struct LeafletPerson: Identifiable {
//    var maritalStatus: MaritalStatus
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
    var genderString: String {
        switch self {
        case .man: return "Man"
        case .woman: return "Woman"
        }
    }
}

//enum MaritalStatus {
//    case married
//    case notMarried
//    case widower
//    var genderString: String {
//        switch self {
//        case .married: return "Married"
//        case .notMarried: return "Not Married"
//        case .widower: return "Midower"
//        }
//    }
//}

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

struct DatePerson {
    var year: Int?
    var month: Month?
    var day: Int?
    
    func formattedDate() -> String {
        // Проверяем, есть ли хотя бы один компонент даты
        if year == nil && month == nil && day == nil {
            return "date of death unknown"
        }
        
        var components = [String]()
        
        if let day = day {
                    components.append("\(day)")
                }
        if let month = month {
                    components.append(month.fullMonthName())
                }
        if let year = year {
            components.append("\(year)")
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


var persons: [LeafletPerson] = [
    LeafletPerson(/*maritalStatus: .married,*/ name: "Artak", surname: "Nazaryan", patronymic: "Lyova", gender: .man, dateOfBirth: DatePerson(year: 1980, month: .october, day: 23), dateOfDeath: DatePerson(), placeOfBirth: "Aramus", placeOfResidence: "Yerevan"),
]
