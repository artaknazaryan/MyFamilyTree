//
//  LeafletInfo.swift
//  My Family Tree
//
//  Created by Artak on 13.09.24.
//

//import SwiftUI
//
//struct LeafletInfo: View {
//    @State private var isDied = false
//    var leafletPerson: LeafletPerson
//    
//    var body: some View {
//            VStack(alignment: .leading) {
//                HStack {
//                    Text("\(leafletPerson.gender.genderString)")
//                    Text("\(leafletPerson.surname)")
//                    Text("\(leafletPerson.name)")
//                    Text("\(leafletPerson.patronymic)")
//                    Spacer()
//                }
//                HStack {
//                    Text("\(leafletPerson.dateOfBirth.formattedDate())")
//                    if isDied {
//                        Text("\(leafletPerson.dateOfDeath.formattedDate())")
//                    }
//                }
//                Text("place of birth - \(leafletPerson.placeOfBirth)")
//                Text("place of residence  - \(leafletPerson.placeOfResidence)")
//            }
//            .padding()
//        .frame(width: UIScreen.main.bounds.width - 30)
//        .foregroundColor(.black)
//        .background(Color.white)
//        .cornerRadius(10)
//    }
//}
//
//
//#Preview {
//    LeafletInfo(leafletPerson: LeafletPerson(/*maritalStatus: .married,*/ name: "Artak", surname: "Nazaryan", patronymic: "Lyova", gender: .man, dateOfBirth: DatePerson(year: 1980, month: .october, day: 23), dateOfDeath: DatePerson(), placeOfBirth: "Aramus", placeOfResidence: "Yerevan"))
//}
