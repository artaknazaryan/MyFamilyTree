//
//  AddNewLeafletView.swift
//  My Family Tree
//
//  Created by Artak on 16.09.24.
//

import SwiftUI

struct AddNewLeafletView: View {
    
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var patronymic: String = ""
    @State private var selectedMonth: Month = .january
    @State private var selectedGender: Gender = .man
    @State private var selectedDay: Int = 1
    @State private var days: [Int] = Array(1...30)
    
    @State private var selectedYear = Calendar.current.component(.year, from: Date())
    @State private var years: [Int] = Array((1880...Calendar.current.component(.year, from: Date())).reversed())
    
    var body: some View {
        VStack {
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 170)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
            VStack(alignment: .leading) {
                TextField("Անուն", text: $name)
                    .background(Color.white)
                Divider()
                TextField("Ազգանուն", text: $surname)
                    .background(Color.white)
                Divider()
                TextField("Հայրանուն", text: $patronymic)
                    .background(Color.white)
                Divider()
                TextField("Ծննդավայրը", text: $patronymic)
                    .background(Color.white)
                Divider()
                TextField("Բնակության վայրը", text: $patronymic)
                    .background(Color.white)
                Divider()
                
                HStack {
                    Text("Ծնվ.")
                    Picker("Выберите год", selection: $selectedYear) {
                        ForEach(years, id: \.self) { year in
                            Text("\(formattedYear(year))")
                                .tag(year)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    Picker(selection: $selectedMonth, label: Text("Ամիսը")) {
                        ForEach(Month.allCases, id: \.self) { month in
                            Text(month.fullMonthName()).tag(month)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    Picker(selection: $selectedDay, label: Text("Օրը")) {
                        ForEach(days, id: \.self) { day in
                            Text("\(day)")
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                }
                Divider()
                HStack {
                    Text("Սեռը")
                    Picker(selection: $selectedGender, label: Text("Սեռը")) {
                    ForEach(Gender.allCases, id: \.self) { gender in
                        Text(gender.genderString)
                            .tag(gender)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .background(Color.white)
                .cornerRadius(10)
                }
            }
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(10)
            Spacer()
        }
        .padding()
    }
    func formattedYear(_ year: Int) -> String {
        return String(year)
    }
}

#Preview {
    AddNewLeafletView()
}
