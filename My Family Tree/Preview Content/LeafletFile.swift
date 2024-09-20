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
    var gender: Gender
    var dateOfBirth: DatePerson?
    var dateOfDeath: DatePerson?
    var placeOfBirth: String
    var placeOfResidence: String
    var biography: String
    var isDied: Bool
    var descendants: [LeafletPerson]
}

enum Gender: String, CaseIterable {
    case man
    case woman
    var genderString: String {
        switch self {
        case .man: return "Արական"
        case .woman: return "Իգական"
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


enum Month: String, CaseIterable {
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
    LeafletPerson(personImage: UIImage(named: "lyova"), id: UUID(), name: "Լյովա", surname: "Նազարյան", patronymic: "Բարեղամի", gender: .man, dateOfBirth: DatePerson(year: 1952, month: .november, day: 23), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", placeOfResidence: "Արամուս", biography: "", isDied: false, descendants: [
        LeafletPerson(personImage: UIImage(named: "artak"), id: UUID(), name: "Արտակ", surname: "Նազարյան", patronymic: "Լյովայի", gender: .man, dateOfBirth: DatePerson(year: 1980, month: .october, day: 23), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", placeOfResidence: "Երևան", biography: "", isDied: false, descendants: [
            LeafletPerson(personImage: UIImage(named: "gayane"), id: UUID(), name: "Գայանե", surname: "Նազարյան", patronymic: "Արտակի", gender: .woman, dateOfBirth: DatePerson(year: 2020, month: .june, day: 05), dateOfDeath: DatePerson(), placeOfBirth: "Երևան", placeOfResidence: "Երևան", biography: "", isDied: false, descendants: []),
            LeafletPerson(personImage: UIImage(named: "davit"), id: UUID(), name: "Դավիթ", surname: "Նազարյան", patronymic: "Արտակի", gender: .man, dateOfBirth: DatePerson(year: 2023, month: .october, day: 23), dateOfDeath: DatePerson(), placeOfBirth: "Երևան", placeOfResidence: "Երևան", biography: "", isDied: false, descendants: [])
        ]),
        LeafletPerson(personImage: UIImage(named: "spartak"), id: UUID(), name: "Սպարտակ", surname: "Նազարյան", patronymic: "Լյովայի", gender: .man, dateOfBirth: DatePerson(year: 1982, month: .january, day: 09), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", placeOfResidence: "Երևան", biography: "", isDied: false, descendants: [
            LeafletPerson(personImage: UIImage(named: "levon"), id: UUID(), name: "Լևոն", surname: "Նազարյան", patronymic: "Սպարտակի", gender: .man, dateOfBirth: DatePerson(year: 2011, month: .october, day: 10), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", placeOfResidence: "Երևան", biography: "", isDied: false, descendants: []),
            LeafletPerson(personImage: UIImage(named: "alen"), id: UUID(), name: "Ալեն", surname: "Նազարյան", patronymic: "Սպարտակի", gender: .man, dateOfBirth: DatePerson(year: 2017, month: .january, day: 09), dateOfDeath: DatePerson(), placeOfBirth: "Երևան", placeOfResidence: "Երևան", biography: "", isDied: false, descendants: [])
        ]),
        LeafletPerson(personImage: UIImage(named: "artak"), id: UUID(), name: "Արա", surname: "Նազարյան", patronymic: "Լյովայի", gender: .man, dateOfBirth: DatePerson(year: 1983, month: .november, day: 20), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", placeOfResidence: "Արամուս", biography: "", isDied: false, descendants: [
            LeafletPerson(personImage: UIImage(named: "areg"), id: UUID(), name: "Արեգ", surname: "Նազարյան", patronymic: "Արայի", gender: .man, dateOfBirth: DatePerson(year: 2018, month: .january, day: 27), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", placeOfResidence: "Արամուս", biography: "", isDied: false, descendants: []),
            LeafletPerson(personImage: UIImage(named: "shant"), id: UUID(), name: "Շանթ", surname: "Նազարյան", patronymic: "Արայի", gender: .man, dateOfBirth: DatePerson(year: 2023, month: .october, day: 02), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", placeOfResidence: "Արամուս", biography: "", isDied: false, descendants: [])
        ])])
]
