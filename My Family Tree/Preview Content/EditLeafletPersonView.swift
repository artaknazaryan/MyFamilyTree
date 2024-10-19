//
//  EditLeafletPersonView.swift
//  My Family Tree
//
//  Created by Artak on 27.09.24.
//

import SwiftUI

struct EditLeafletPersonView: View {
    @Binding var leafletPerson: LeafletPerson
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showActionSheet = false
    @State private var isImagePickerPresented = false
    @State private var selectedGender: Gender = .man
    @State private var selectedIsAlive: IsAlive = .isAlive
    @State private var selectedBirthDay: Int = 1
    @State private var selectedBirthMonth: Month = .january
    @State private var selectedBirthYear = Calendar.current.component(.year, from: Date())
    @State private var selectedDeathDay: Int = 1
    @State private var selectedDeathMonth: Month = .january
    @State private var selectedDeathYear = Calendar.current.component(.year, from: Date())
    @State private var lastDayOfTheMonth: Int = 31
    @State private var years: [Int] = Array((1880...Calendar.current.component(.year, from: Date())).reversed())
    
    @State private var biographyText: String = ""
    @State private var textHeight: CGFloat = 38
    
    @State private var name: String
    @State private var surname: String
    @State private var patronymic: String
    @State private var placeOfBirth: String
    @State private var personImage: UIImage?
    @State private var gender: Gender
    @State private var dateOfBirth: DatePerson?
    @State private var dateOfDeath: DatePerson?
    @State private var biography: String
    @State private var isAlive: IsAlive
    @State private var descendants: [LeafletPerson]
    
    init(leafletPerson: Binding<LeafletPerson>) {
        self._leafletPerson = leafletPerson
        _name = State(initialValue: leafletPerson.wrappedValue.name)
        _surname = State(initialValue: leafletPerson.wrappedValue.surname)
        _patronymic = State(initialValue: leafletPerson.wrappedValue.patronymic)
        _placeOfBirth = State(initialValue: leafletPerson.wrappedValue.placeOfBirth)
        _personImage = State(initialValue: leafletPerson.wrappedValue.personImage)
        _gender = State(initialValue: leafletPerson.wrappedValue.gender)
        _dateOfBirth = State(initialValue: leafletPerson.wrappedValue.dateOfBirth)
        _dateOfDeath = State(initialValue: leafletPerson.wrappedValue.dateOfDeath)
        _biography = State(initialValue: leafletPerson.wrappedValue.biography)
        _isAlive = State(initialValue: leafletPerson.wrappedValue.isAlive)
        _descendants = State(initialValue: leafletPerson.wrappedValue.descendants)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Image(uiImage: leafletPerson.personImage ?? UIImage(named: "pesrosnImage")!)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .frame(width: 120, height: 170)
                    
                    Button(action: {
                        showActionSheet = true // Открыть ActionSheet
                    }, label: {
                        leafletPerson.personImage == nil ? Text("Ավելացնել Նկար") : Text("Փոխել Նկարը")
                    })
                    .actionSheet(isPresented: $showActionSheet) {
                        leafletPerson.personImage != nil ?
                        ActionSheet(title: Text("Ընտրել"), buttons: [
                            .default(Text("Փոխել Նկարը")) {
                                isImagePickerPresented = true // Открыть галерею
                            },
                            .destructive(Text("Ջնջել Նկարը")) {
                                leafletPerson.personImage = nil // Удалить фото
                            },
                            .cancel()
                        ]) :
                        ActionSheet(title: Text("Ավելացնել Նկար"), buttons: [
                            .default(Text("Ավելացնել Նկար")) {
                                isImagePickerPresented = true // Открыть галерею
                            },
                            .cancel()
                        ])
                    }
                    .sheet(isPresented: $isImagePickerPresented) {
                        ImagePicker(selectedImage: $leafletPerson.personImage)
                    }
                    
                    VStack(alignment: .leading) {
                        TextField("Անուն", text: $name)
                        Divider()
                        
                        TextField("Ազգանուն", text: $surname)
                        Divider()
                        
                        TextField("Հայրանուն", text: $patronymic)
                        Divider()
                        
                        TextField("Ծննդավայրը", text: $placeOfBirth)
                        Divider()
                        
                        // Выбор пола
                        HStack {
                            Text("Սեռը")
                            Spacer()
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
                        Divider()
                        
                        // Дата рождения
                        HStack {
                            Text("Ծնվ.")
                            Spacer()
                            Picker("Choose year", selection: $selectedBirthYear) {
                                ForEach(years, id: \.self) { year in
                                    Text("\(formattedYear(year))")
                                        .tag(year)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .onChange(of: selectedBirthYear) { oldValue, newValue in
                                updateLastDayOfTheMonth()
                            }
                            
                            Picker(selection: $selectedBirthMonth, label: Text("Ամիսը")) {
                                ForEach(Month.allCases, id: \.self) { month in
                                    Text(month.fullMonthName()).tag(month)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .background(Color.white)
                            .cornerRadius(10)
                            .onChange(of: selectedBirthMonth) { oldValue, newValue in
                                updateLastDayOfTheMonth()
                            }
                            
                            Picker(selection: $selectedBirthDay, label: Text("Օրը")) {
                                ForEach(1...lastDayOfTheMonth, id: \.self) { day in
                                    Text("\(day)")
                                }
                            }
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                        Divider()
                        
                        // Проверка статуса жизни
                        HStack {
                            Text("Շարունակում է ապրել")
                            Spacer()
                            Picker(selection: $selectedIsAlive, label: Text("Հավերժացել է")) {
                                ForEach(IsAlive.allCases, id: \.self) { isAlive in
                                    Text(isAlive.isAliveStrinng)
                                        .tag(isAlive)
                                }
                            }
                            .background(Color.white)
                            .cornerRadius(10)
                            .onChange(of: selectedIsAlive) { oldValue, newValue in
                                leafletPerson.isAlive = selectedIsAlive
                            }
                        }
                        Divider()
                        
                        // Ввод даты смерти, если человек умер
                        if leafletPerson.isAlive == .isDied {
                            HStack {
                                Text("Մհց.")
                                Spacer()
                                Picker("Choose year", selection: $selectedDeathYear) {
                                    ForEach(years, id: \.self) { year in
                                        Text("\(formattedYear(year))")
                                            .tag(year)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .background(Color.white)
                                .cornerRadius(10)
                                .onChange(of: selectedDeathYear) { oldValue, newValue in
                                    updateLastDayOfTheMonth()
                                }
                                
                                Picker(selection: $selectedDeathMonth, label: Text("Ամիսը")) {
                                    ForEach(Month.allCases, id: \.self) { month in
                                        Text(month.fullMonthName()).tag(month)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .background(Color.white)
                                .cornerRadius(10)
                                .onChange(of: selectedDeathMonth) {oldValue, newvalue in
                                    updateLastDayOfTheMonth()
                                }
                                
                                Picker(selection: $selectedDeathDay, label: Text("Օրը")) {
                                    ForEach(1...lastDayOfTheMonth, id: \.self) { day in
                                        Text("\(day)")
                                    }
                                }
                                .background(Color.white)
                                .cornerRadius(10)
                            }
                            Divider()
                            
                            // Ввод биографии
                            VStack {
                                Text("Կենսագրությունը")
                                ZStack(alignment: .topLeading) {
                                    ResizableTextView(text: $biography, dynamicHeight: $textHeight)
                                        .frame(minHeight: textHeight, maxHeight: textHeight)
                                }
                            }
                        }
                    }
                    .padding()
                    .cornerRadius(10)
                    .background(Color(uiColor: .secondarySystemBackground))
                    Spacer()
                }
            }
            .onAppear {
                // Инициализация данных
                if let birthYear = leafletPerson.dateOfBirth?.year {
                    selectedBirthYear = birthYear
                }
                if let birthMonth = leafletPerson.dateOfBirth?.month {
                    selectedBirthMonth = birthMonth
                }
                if let birthDay = leafletPerson.dateOfBirth?.day {
                    selectedBirthDay = birthDay
                }
                selectedGender = leafletPerson.gender
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Վերադառնալ") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Պահպանել") {
                        savePerson()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
        // Обновление последнего дня месяца в зависимости от выбранного года и месяца
        func updateLastDayOfTheMonth() {
            lastDayOfTheMonth = selectedBirthMonth.lastMonthDay(isLeapYear: isLeapYear(selectedBirthYear))
            if selectedBirthDay > lastDayOfTheMonth {
                selectedBirthDay = lastDayOfTheMonth
            }
        }
    
    // Проверка високосного года
    func isLeapYear(_ year: Int) -> Bool {
        (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
    }
    
    // Форматирование года
    func formattedYear(_ year: Int) -> String {
        return String(year)
    }
    
    // Сохранение данных
    func savePerson() {
        leafletPerson.name = name
        leafletPerson.surname = surname
        leafletPerson.patronymic = patronymic
        leafletPerson.placeOfBirth = placeOfBirth
        leafletPerson.gender = selectedGender
        leafletPerson.dateOfBirth = DatePerson(year: selectedBirthYear, month: selectedBirthMonth, day: selectedBirthDay)
        if selectedIsAlive == .isDied {
            leafletPerson.dateOfDeath = DatePerson(year: selectedDeathYear, month: selectedDeathMonth, day: selectedDeathDay)
        } else {
            leafletPerson.dateOfDeath = nil
        }
        leafletPerson.biography = biography
    }
}


#Preview {
    @State var testPerson = LeafletPerson(maritalStatus: .married, personImage: UIImage(named: "artak"), name: "Արտակ", surname: "Նազարյան", patronymic: "Լյովայի", gender: .man, dateOfBirth: DatePerson(year: 1980, month: .october, day: 23), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", biography: "", isAlive: .isDied, descendants: [
        LeafletPerson(maritalStatus: .notMarried, personImage: UIImage(named: "gayane"), name: "Գայանե", surname: "Նազարյան", patronymic: "Արտակի", gender: .woman, dateOfBirth: DatePerson(year: 2020, month: .june, day: 05), dateOfDeath: DatePerson(), placeOfBirth: "Երևան", biography: "", isAlive: .isAlive, descendants: []),
        LeafletPerson(maritalStatus: .notMarried, personImage: UIImage(named: "davit"), name: "Դավիթ", surname: "Նազարյան", patronymic: "Արտակի", gender: .man, dateOfBirth: DatePerson(year: 2023, month: .october, day: 23), dateOfDeath: DatePerson(), placeOfBirth: "Երևան", biography: "", isAlive: .isAlive, descendants: [])
    ])
    
    return EditLeafletPersonView(leafletPerson: $testPerson)
}
