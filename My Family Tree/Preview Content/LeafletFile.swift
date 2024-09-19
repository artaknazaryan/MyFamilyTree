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
    var personImage: UIImage?
    var id = UUID()
    var name: String
    var surname: String
    var patronymic: String
    let gender: Gender
    var dateOfBirth: DatePerson?
    var dateOfDeath: DatePerson?
    var placeOfBirth: String
    var placeOfResidence: String
    var biography: String
    var isDied: Bool
    var descendants: [LeafletPerson]
}

enum Gender {
    case man
    case woman
    var genderString: String {
        switch self {
        case .man: return "Mr."
        case .woman: return "Ms."
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


enum Month: String {
    case january
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

extension Month {
    func fullMonthName() -> String {
        // Месяцы в Swift Enum являются перечислениями, и они не должны напрямую взаимодействовать с DateFormatter
        switch self {
        case .january: return "Հունվար"
        case .february: return "Փետրվար"
        case .march: return "Մարտ"
        case .april: return "Ապրիլ"
        case .may: return "Մայիս"
        case .june: return "Հունիս"
        case .july: return "Հուլիս"
        case .august: return "Օգոստոս"
        case .september: return "Սեպտեմբեր"
        case .october: return "Հոկտեմբեր"
        case .november: return "Նոյեմբեր"
        case .december: return "Դեկտեմբեր"
        }
    }
}


struct DatePerson {
    var year: Int?
    var month: Month?
    var day: Int?
    
    func formattedDate() -> String {
        if year == nil && month == nil && day == nil {
            return "Անհայտ"
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

var persons: [LeafletPerson] = [
    LeafletPerson(personImage: UIImage(named: "lyova"), id: UUID(), name: "Լյովա", surname: "Նազարյան", patronymic: "Բարեղամի", gender: .man, dateOfBirth: DatePerson(year: 1952, month: .november, day: 23), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", placeOfResidence: "Արամուս", biography: "as", isDied: false, descendants: [
        LeafletPerson(personImage: UIImage(named: "artak"), id: UUID(), name: "Արտակ", surname: "Նազարյան", patronymic: "Լյովայի", gender: .man, dateOfBirth: DatePerson(year: 1980, month: .october, day: 23), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", placeOfResidence: "Երևան", biography: "as", isDied: false, descendants: []),
        LeafletPerson(personImage: UIImage(named: "artak"), id: UUID(), name: "Սպարտակ", surname: "Նազարյան", patronymic: "Լյովայի", gender: .man, dateOfBirth: DatePerson(year: 1982, month: .january, day: 09), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", placeOfResidence: "Երևան", biography: "as", isDied: false, descendants: []),
        LeafletPerson(personImage: UIImage(named: "artak"), id: UUID(), name: "Արա", surname: "Նազարյան", patronymic: "Լյովայի", gender: .man, dateOfBirth: DatePerson(year: 1983, month: .november, day: 20), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", placeOfResidence: "Արամուս", biography: "as", isDied: false, descendants: [])])
]
