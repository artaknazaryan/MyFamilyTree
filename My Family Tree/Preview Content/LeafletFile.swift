//
//  BranchFile.swift
//  My Family Tree
//
//  Created by Artak on 13.09.24.
//

import Foundation
import SwiftUI

struct LeafletPerson: Identifiable {
    var maritalStatus: MaritalStatus
    var personImage: UIImage?
    var id = UUID()
    var name: String
    var surname: String
    var patronymic: String
    var gender: Gender
    var dateOfBirth: DatePerson?
    var dateOfDeath: DatePerson?
    var placeOfBirth: String
    var biography: String
    var isAlive: IsAlive
    var spouse: Spouse? // Опциональное свойство для супруга, которое будет иметь значение только если статус брака — "женат/замужем"
    var descendants: [LeafletPerson]

    // Инициализация данных
    init(maritalStatus: MaritalStatus, personImage: UIImage? = nil, name: String, surname: String, patronymic: String, gender: Gender, dateOfBirth: DatePerson?, dateOfDeath: DatePerson?, placeOfBirth: String, biography: String, isAlive: IsAlive, spouse: Spouse? = nil, descendants: [LeafletPerson] = []) {
        self.maritalStatus = maritalStatus
        self.personImage = personImage
        self.name = name
        self.surname = surname
        self.patronymic = patronymic
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.dateOfDeath = dateOfDeath
        self.placeOfBirth = placeOfBirth
        self.biography = biography
        self.isAlive = isAlive
        self.spouse = maritalStatus == .married ? spouse : nil // Проверяем статус брака
        self.descendants = descendants
    }
}


//struct LeafletPerson: Identifiable {
//    var maritalStatus: MaritalStatus
//    var personImage: UIImage?
//    var id = UUID()
//    var name: String
//    var surname: String
//    var patronymic: String
//    var gender: Gender
//    var dateOfBirth: DatePerson?
//    var dateOfDeath: DatePerson?
//    var placeOfBirth: String
//    var biography: String
//    var isAlive: IsAlive
//    if maritalStatus == .married {
//        var spouse: Spouse
//    }
//    var descendants: [LeafletPerson]
//}

struct Spouse {
    var spouseName: String
    var spouseSurname: String
    var spouseImage: UIImage?
    var dateOfBirth: DatePerson?
    var dateOfDeath: DatePerson?
    var isAlive: IsAlive
}

enum IsAlive: String, CaseIterable {
    case isAlive
    case isDied
    var isAliveStrinng: String {
        switch self {
        case .isAlive: return "Այո, իհարկե"
        case .isDied:  return "Ցավոք ոչ"
        }
    }
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

enum MaritalStatus {
    case married
    case notMarried
    case widower
    var genderString: String {
        switch self {
        case .married: return "Married"
        case .notMarried: return "Not Married"
        case .widower: return "Midower"
        }
    }
}


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

extension Month {
    func lastMonthDay(isLeapYear: Bool) -> Int {
        switch self {
        case .january: return 31
        case .february: return isLeapYear ? 29 : 28
        case .march: return 31
        case .april: return 30
        case .may: return 31
        case .june: return 30
        case .july: return 31
        case .august: return 31
        case .september: return 30
        case .october: return 31
        case .november: return 30
        case .december: return 31
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
    LeafletPerson(maritalStatus: .married, personImage: UIImage(named: "lyova"), name: "Լյովա", surname: "Նազարյան", patronymic: "Բարեղամի", gender: .man, dateOfBirth: DatePerson(year: 1952, month: .november, day: 23), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", biography: "", isAlive: .isAlive, spouse: Spouse(spouseName: "Գայանե", spouseSurname: "Դավթյան", dateOfBirth: DatePerson(year: 1960, month: .january, day: 22) ,isAlive: .isAlive),descendants: [
        LeafletPerson(maritalStatus: .married, personImage: UIImage(named: "artak"), name: "Արտակ", surname: "Նազարյան", patronymic: "Լյովայի", gender: .man, dateOfBirth: DatePerson(year: 1980, month: .october, day: 23), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", biography: "", isAlive: .isAlive, spouse: Spouse(spouseName: "Արփինե", spouseSurname: "Մաթևոսյան", spouseImage: UIImage(named: "arpine"), dateOfBirth: DatePerson(year: 1980, month: .september, day: 30), isAlive: .isAlive), descendants: [
            LeafletPerson(maritalStatus: .notMarried, personImage: UIImage(named: "gayane"), name: "Գայանե", surname: "Նազարյան", patronymic: "Արտակի", gender: .woman, dateOfBirth: DatePerson(year: 2020, month: .june, day: 05), dateOfDeath: DatePerson(), placeOfBirth: "Երևան", biography: "", isAlive: .isAlive, descendants: []),
            LeafletPerson(maritalStatus: .married, personImage: UIImage(named: "davit"),  name: "Դավիթ", surname: "Նազարյան", patronymic: "Արտակի", gender: .man, dateOfBirth: DatePerson(year: 2023, month: .october, day: 23), dateOfDeath: DatePerson(), placeOfBirth: "Երևան", biography: "", isAlive: .isAlive, descendants: [])
        ]),
        LeafletPerson(maritalStatus: .married, personImage: UIImage(named: "spartak"), name: "Սպարտակ", surname: "Նազարյան", patronymic: "Լյովայի", gender: .man, dateOfBirth: DatePerson(year: 1982, month: .january, day: 09), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", biography: "", isAlive: .isAlive, spouse: Spouse(spouseName: "Սինամի", spouseSurname: "Գևորգյան", dateOfBirth: DatePerson(year: 1985, month: .april, day: 11) , isAlive: .isAlive), descendants: [
            LeafletPerson(maritalStatus: .notMarried, personImage: UIImage(named: "levon"), name: "Լևոն", surname: "Նազարյան", patronymic: "Սպարտակի", gender: .man, dateOfBirth: DatePerson(year: 2011, month: .october, day: 10), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", biography: "", isAlive: .isAlive, descendants: []),
            LeafletPerson(maritalStatus: .notMarried, personImage: UIImage(named: "alen"), name: "Ալեն", surname: "Նազարյան", patronymic: "Սպարտակի", gender: .man, dateOfBirth: DatePerson(year: 2017, month: .january, day: 09), dateOfDeath: DatePerson(), placeOfBirth: "Երևան", biography: "", isAlive: .isAlive, descendants: [])
        ]),
        
        LeafletPerson(maritalStatus: .married, personImage: UIImage(named: "aro"), name: "Արա", surname: "Նազարյան", patronymic: "Լյովայի", gender: .man, dateOfBirth: DatePerson(year: 1983, month: .november, day: 20), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", biography: "", isAlive: .isAlive, spouse: Spouse(spouseName: "Աննա", spouseSurname: "Սաֆարյան", dateOfBirth: DatePerson(year: 1986, month: .march, day: 22) , isAlive: .isAlive), descendants: [
            LeafletPerson(maritalStatus: .notMarried, personImage: UIImage(named: "areg"), name: "Արեգ", surname: "Նազարյան", patronymic: "Արայի", gender: .man, dateOfBirth: DatePerson(year: 2018, month: .january, day: 27), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", biography: "", isAlive: .isAlive, descendants: []),
            LeafletPerson(maritalStatus: .notMarried, personImage: UIImage(named: "shant"), name: "Շանթ", surname: "Նազարյան", patronymic: "Արայի", gender: .man, dateOfBirth: DatePerson(year: 2023, month: .october, day: 02), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", biography: "", isAlive: .isAlive, descendants: [])
        ])])
]
