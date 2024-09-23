//
//  AddNewLeafletView.swift
//  My Family Tree
//
//  Created by Artak on 16.09.24.
//

//import SwiftUI
//
//struct AddNewLeafletView: View {
//    
//    @State private var lastDayOfTheMonth: Int = 31
//    @State private var name: String = ""
//    @State private var surname: String = ""
//    @State private var patronymic: String = ""
//    @State private var selectedMonth: Month = .january
//    @State private var selectedGender: Gender = .man
//    @State private var selectedDay: Int = 1
//    
//    @State private var selectedYear = Calendar.current.component(.year, from: Date())
//    @State private var years: [Int] = Array((1880...Calendar.current.component(.year, from: Date())).reversed())
//    
//    var body: some View {
//        VStack {
//            Image(systemName: "person")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 120, height: 170)
//                .padding()
//                .background(Color(uiColor: .secondarySystemBackground))
//                .cornerRadius(10)
//            
//            VStack(alignment: .leading) {
//                TextField("Անուն", text: $name)
//                    .background(Color.white)
//                Divider()
//                TextField("Ազգանուն", text: $surname)
//                    .background(Color.white)
//                Divider()
//                TextField("Հայրանուն", text: $patronymic)
//                    .background(Color.white)
//                Divider()
//                                TextField("Ծննդավայրը", text: $patronymic)
//                                    .background(Color.white)
//                                Divider()
//                                TextField("Բնակության վայրը", text: $patronymic)
//                                    .background(Color.white)
//                                Divider()
//                
//                HStack {
//                    Text("Ծնվ.")
//                    Picker("Choose year", selection: $selectedYear) {
//                        ForEach(years, id: \.self) { year in
//                            Text("\(formattedYear(year))")
//                                .tag(year)
//                        }
//                    }
//                    .pickerStyle(MenuPickerStyle())
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .onChange(of: selectedYear) {oldValue, newValue in
//                        updateLastDayOfTheMonth()
//                    }
//                    
//                    Picker(selection: $selectedMonth, label: Text("Ամիսը")) {
//                        ForEach(Month.allCases, id: \.self) { month in 
//                            Text(month.fullMonthName()).tag(month)
//                        }
//                    }
//                    .pickerStyle(MenuPickerStyle())
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .onChange(of: selectedMonth) {oldValue, newValue in
//                        updateLastDayOfTheMonth()
//                    }
//                    
//                    Picker(selection: $selectedDay, label: Text("Օրը")) {
//                        ForEach(1...lastDayOfTheMonth, id: \.self) { day in
//                            Text("\(day)")
//                        }
//                    }
//                    .background(Color.white)
//                    .cornerRadius(10)
//                }
//                Divider()
//                
//                HStack {
//                    Text("Սեռը")
//                    Picker(selection: $selectedGender, label: Text("Սեռը")) {
//                        ForEach(Gender.allCases, id: \.self) { gender in
//                            Text(gender.genderString)
//                                .tag(gender)
//                        }
//                    }
//                    .pickerStyle(MenuPickerStyle())
//                    .background(Color.white)
//                    .cornerRadius(10)
//                }
//            }
//            .padding()
//            .background(Color(uiColor: .secondarySystemBackground))
//            .cornerRadius(10)
//        }
//    }
//    
//    func updateLastDayOfTheMonth() {
//        lastDayOfTheMonth = selectedMonth.lastMonthDay(isLeapYear: isLeapYear(selectedYear))
//        if selectedDay > lastDayOfTheMonth {
//            selectedDay = lastDayOfTheMonth
//        }
//    }
//    
//    func isLeapYear(_ year: Int) -> Bool {
//        (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
//    }
//    
//    func formattedYear(_ year: Int) -> String {
//        return String(year)
//    }
//}
//
//struct AddNewLeafletView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewLeafletView()
//    }
//}

import SwiftUI

struct AddNewLeafletView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var lastDayOfTheMonth: Int = 31
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var patronymic: String = ""
    @State private var selectedMonth: Month = .january
    @State private var selectedGender: Gender = .man
    @State private var selectedDay: Int = 1
    @State private var isImagePickerPresented = false
    
    @State private var selectedYear = Calendar.current.component(.year, from: Date())
    @State private var years: [Int] = Array((1880...Calendar.current.component(.year, from: Date())).reversed())
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 170)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(10)
                Button(action: {
                    isImagePickerPresented = true
                }, label: {
                    Text("Add Foto")
                })
                .sheet(isPresented: $isImagePickerPresented) {
//                    ImagePicker(selectedImage: $leafletPerson.personImage)
                }
                
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
                        Picker("Choose year", selection: $selectedYear) {
                            ForEach(years, id: \.self) { year in
                                Text("\(formattedYear(year))")
                                    .tag(year)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .background(Color.white)
                        .cornerRadius(10)
                        .onChange(of: selectedYear) { oldValue, newValue in
                            updateLastDayOfTheMonth()
                        }
                        
                        Picker(selection: $selectedMonth, label: Text("Ամիսը")) {
                            ForEach(Month.allCases, id: \.self) { month in
                                Text(month.fullMonthName()).tag(month)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .background(Color.white)
                        .cornerRadius(10)
                        .onChange(of: selectedMonth) { oldValue, newValue in
                            updateLastDayOfTheMonth()
                        }
                        
                        Picker(selection: $selectedDay, label: Text("Օրը")) {
                            ForEach(1...lastDayOfTheMonth, id: \.self) { day in
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
            }
            .navigationBarTitle("Նոր տերև", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveLeaflet()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    // Функция сохранения данных
    func saveLeaflet() {
        // Здесь можно добавить логику сохранения нового листа
        print("Saving leaflet...")
        print("Name: \(name), Surname: \(surname), Patronymic: \(patronymic)")
        print("Birth Date: \(selectedDay).\(selectedMonth) \(selectedYear)")
        print("Gender: \(selectedGender)")
    }
    
    func updateLastDayOfTheMonth() {
        lastDayOfTheMonth = selectedMonth.lastMonthDay(isLeapYear: isLeapYear(selectedYear))
        if selectedDay > lastDayOfTheMonth {
            selectedDay = lastDayOfTheMonth
        }
    }
    
    func isLeapYear(_ year: Int) -> Bool {
        (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
    }
    
    func formattedYear(_ year: Int) -> String {
        return String(year)
    }
}

struct AddNewLeafletView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewLeafletView()
    }
}
