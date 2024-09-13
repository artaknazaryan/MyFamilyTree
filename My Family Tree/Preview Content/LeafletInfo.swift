//
//  LeafletInfo.swift
//  My Family Tree
//
//  Created by Artak on 13.09.24.
//

import SwiftUI

struct LeafletInfo: View {
    @State private var isDied = false
    var leafletPerson: Leaflet
    
        // Переменные для хранения данных
        let name = "Monte"
        let surname = "Melqonyan"
        let patronymic = ""
        let gender = ""
        let dateOfBirth = ""
        let placeOfBirth = ""
        let dateOfDeath = ""
    
        var body: some View {
            VStack {
                HStack() {
                    VStack {
                        Image("monte")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .background(Color.white)
                            .cornerRadius(5)
                        Text("Monte")
                    }
                    Spacer()
                    VStack {
                        Image("artak")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .background(Color.white)
                            .cornerRadius(5)
                        Text("\(leafletPerson.name)")
                    }
                }
                VStack() {
                    infoRow(title: "Name", value: leafletPerson.name)
                    infoRow(title: "Surname", value: leafletPerson.surname)
                    infoRow(title: "Patronymic", value: leafletPerson.patronymic)
                    infoRow(title: "Gender", value: gender)
                    infoRow(title: "Date Of Birth", value: "\(leafletPerson.dateOfBirth.year)")
                    infoRow(title: "Place Of Birth", value: leafletPerson.placeOfBirth)
    
                    if isDied {
                        infoRow(title: "Date Of Death", value: "\(leafletPerson.dateOfDeath)")
                    }
                }
                .padding()
            }
        }
    
        // Общая функция для создания строк информации
        @ViewBuilder
        private func infoRow(title: String, value: String) -> some View {
            HStack(alignment: .center) {
                Text(title)
                Spacer()
                Text(value)
                    .background(Color(uiColor: .systemGroupedBackground))
                    .cornerRadius(5)
                    .multilineTextAlignment(.leading)
            }
        }
}

#Preview {
    LeafletInfo(leafletPerson: Leaflet(name: "Artak", surname: "Nazaryan", patronymic: "Lyova", gender: .man, dateOfBirth: DatePerson(year: 1980, month: .october, day: 23), dateOfDeath: DatePerson(), placeOfBirth: "Aramus", placeOfResidence: "Yerevan"))
}
