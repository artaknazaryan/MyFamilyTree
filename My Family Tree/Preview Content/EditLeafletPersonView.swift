//
//  EditLeafletPersonView.swift
//  My Family Tree
//
//  Created by Artak on 27.09.24.
//

//import SwiftUI
//
//struct EditLeafletPersonView: View {
//    @Binding var leafletPerson: LeafletPerson
//    
//    
//    @State private var showActionSheet = false
//    @State private var isImagePickerPresented = false
//    @State private var selectedGender: Gender = .man
//    @State private var selectedIsAlive: IsAlive = .isAlive
//    @State private var selectedBirthDay: Int = 1
//    @State private var selectedBirthMonth: Month = .january
//    @State private var selectedBirthYear = Calendar.current.component(.year, from: Date())
//    @State private var selectedDeathDay: Int = 1
//    @State private var selectedDeathMonth: Month = .january
//    @State private var selectedDeathYear = Calendar.current.component(.year, from: Date())
//    @State private var lastDayOfTheMonth: Int = 31
//    @State private var years: [Int] = Array((1880...Calendar.current.component(.year, from: Date())).reversed())
//    
//    @State private var biographyText: String = ""
//    @State private var textHeight: CGFloat = 38
//    
//    @State private var name: String
//    @State private var surname: String
//    @State private var patronymic: String
//    @State private var placeOfBirth: String
//    @State private var placeOfResidence: String
//    @State private var personImage: UIImage?
//    @State private var gender: Gender
//    @State private var dateOfBirth: DatePerson?
//    @State private var dateOfDeath: DatePerson?
//    @State private var biography: String
//    @State private var isAlive: IsAlive
//    @State private var descendants: [LeafletPerson]
//    
//    // Инициализируем значения для редактирования
//    init(leafletPerson: Binding<LeafletPerson>) {
//        self._leafletPerson = leafletPerson
//        _name = State(initialValue: leafletPerson.wrappedValue.name)
//        _surname = State(initialValue: leafletPerson.wrappedValue.surname)
//        _patronymic = State(initialValue: leafletPerson.wrappedValue.patronymic)
//        _placeOfBirth = State(initialValue: leafletPerson.wrappedValue.placeOfBirth)
//        _placeOfResidence = State(initialValue: leafletPerson.wrappedValue.placeOfResidence)
//        _personImage = State(initialValue: leafletPerson.wrappedValue.personImage)
//        _gender = State(initialValue: leafletPerson.wrappedValue.gender)
//        _dateOfBirth = State(initialValue: leafletPerson.wrappedValue.dateOfBirth)
//        _dateOfDeath = State(initialValue: leafletPerson.wrappedValue.dateOfDeath)
//        _biography = State(initialValue: leafletPerson.wrappedValue.biography)
//        _isAlive = State(initialValue: leafletPerson.wrappedValue.isAlive)
//        _descendants = State(initialValue: leafletPerson.wrappedValue.descendants)
//    }
//    
//    var body: some View {
//        ScrollView {
//            VStack {
//                Image(uiImage: leafletPerson.personImage ?? UIImage(named: "defaultImage")!)
//                    .resizable()
//                    .scaledToFit()
//                    .cornerRadius(10)
//                    .frame(width: 120, height: 170)
//                Button(action: {
//                    showActionSheet = true // Открыть ActionSheet
//                }, label: {
//                    leafletPerson.personImage == nil ? Text("Ավելացնել նկար") : Text("Փոխել նկարը")
//                })
//                .actionSheet(isPresented: $showActionSheet) {
//                    leafletPerson.personImage != nil ?
//                    ActionSheet(title: Text("Ընտրել"), buttons: [
//                        .default(Text("Փոխել նկարը")) {
//                            isImagePickerPresented = true // Открыть галерею
//                        },
//                        .destructive(Text("Ջնջել նկարը")) {
//                            leafletPerson.personImage = nil // Удалить фото
//                        },
//                        .cancel()
//                    ]) :
//                    ActionSheet(title: Text("Add a photo"), buttons: [
//                        .default(Text("Ավելացնել նկար")) {
//                            isImagePickerPresented = true // Открыть галерею
//                        },
//                        .cancel()
//                    ])
//                }
//                .sheet(isPresented: $isImagePickerPresented) {
//                    ImagePicker(selectedImage: $leafletPerson.personImage)
//                }
//                VStack(alignment: .leading) {
//                    TextField("Անուն", text: $name)
//                        .background(Color.white)
//                    Divider()
//                    TextField("Ազգանուն", text: $surname)
//                        .background(Color.white)
//                    Divider()
//                    TextField("Հայրանուն", text: $patronymic)
//                        .background(Color.white)
//                    Divider()
//                    TextField("Ծննդավայրը", text: $placeOfBirth)
//                        .background(Color.white)
//                    Divider()
//                    TextField("Բնակության վայրը", text: $placeOfResidence)
//                        .background(Color.white)
//                    Divider()
//                    
//                    HStack {
//                        Text("Սեռը")
//                        Spacer()
//                        Picker(selection: $selectedGender, label: Text("Սեռը")) {
//                            ForEach(Gender.allCases, id: \.self) { gender in
//                                Text(gender.genderString)
//                                    .tag(gender)
//                            }
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                        .background(Color.white)
//                        .cornerRadius(10)
//                    }
//                    
//                    Divider()
//                    
//                    HStack {
//                        Text("Ծնվ.")
//                        Spacer()
//                        Picker("Choose year", selection: $selectedBirthYear) {
//                            ForEach(years, id: \.self) { year in
//                                Text("\(formattedYear(year))")
//                                    .tag(year)
//                            }
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                        .background(Color.white)
//                        .cornerRadius(10)
//                        .onChange(of: selectedBirthYear) { oldValue, newValue in
//                            updateLastDayOfTheMonth()
//                        }
//                        
//                        Picker(selection: $selectedBirthMonth, label: Text("Ամիսը")) {
//                            ForEach(Month.allCases, id: \.self) { month in
//                                Text(month.fullMonthName()).tag(month)
//                            }
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                        .background(Color.white)
//                        .cornerRadius(10)
//                        .onChange(of: selectedBirthMonth) { oldValue, newValue in
//                            updateLastDayOfTheMonth()
//                        }
//                        
//                        Picker(selection: $selectedBirthDay, label: Text("Օրը")) {
//                            ForEach(1...lastDayOfTheMonth, id: \.self) { day in
//                                Text("\(day)")
//                            }
//                        }
//                        .background(Color.white)
//                        .cornerRadius(10)
//                    }
//                    Divider()
//                    
//                    HStack {
//                        Text("Շարունակում է ապրել")
//                        Spacer()
//                        Picker(selection: $selectedIsAlive, label: Text("Հավերժացել է")) {
//                            ForEach(IsAlive.allCases, id: \.self) { isAlive in
//                                Text(isAlive.isAliveStrinng)
//                                    .tag(isAlive)
//                            }
//                        }
//                        .background(Color.white)
//                        .cornerRadius(10)
//                        .onChange(of: selectedIsAlive) {oldValue, newValue in
//                            leafletPerson.isAlive = selectedIsAlive
//                        }
//                    }
//                    
//                    Divider()
//                    
//                    if leafletPerson.isAlive == .isDied {
//                        HStack {
//                            Text("Մհց.")
//                            Spacer()
//                            Picker("Choose year", selection: $selectedDeathYear) {
//                                ForEach(years, id: \.self) { year in
//                                    Text("\(formattedYear(year))")
//                                        .tag(year)
//                                }
//                            }
//                            .pickerStyle(MenuPickerStyle())
//                            .background(Color.white)
//                            .cornerRadius(10)
//                            .onChange(of: selectedDeathYear) { oldValue, newValue in
//                                updateLastDayOfTheMonth()
//                            }
//                            
//                            Picker(selection: $selectedDeathMonth, label: Text("Ամիսը")) {
//                                ForEach(Month.allCases, id: \.self) { month in
//                                    Text(month.fullMonthName()).tag(month)
//                                }
//                            }
//                            .pickerStyle(MenuPickerStyle())
//                            .background(Color.white)
//                            .cornerRadius(10)
//                            .onChange(of: selectedDeathMonth) { oldValue, newValue in
//                                updateLastDayOfTheMonth()
//                            }
//                            
//                            Picker(selection: $selectedDeathDay, label: Text("Օրը")) {
//                                ForEach(1...lastDayOfTheMonth, id: \.self) { day in
//                                    Text("\(day)")
//                                }
//                            }
//                            .background(Color.white)
//                            .cornerRadius(10)
//                        }
//                        Divider()
//                        VStack {
//                            Text("Կենսագրությունը")
//                            ZStack(alignment: .topLeading) {
//                                ResizableTextView(text: $biography, dynamicHeight: $textHeight)
//                                    .frame(minHeight: textHeight, maxHeight: textHeight)
//                            }
//                            .background(Color.white)
//                        }
//                    }
//                }
//                .padding()
//                .background(Color(uiColor: .secondarySystemBackground))
//                .cornerRadius(10)
//                Spacer()
//            }
//        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {
//                    
//                }) {
//                    Text("Save")
//                }
//            }
//        }
//
//        .navigationTitle("Edit Person")
//        .onAppear {
//            if let birthYear = leafletPerson.dateOfBirth?.year {
//                selectedBirthYear = birthYear
//            }
//            if let birthMonth = leafletPerson.dateOfBirth?.month {
//                selectedBirthMonth = birthMonth
//            }
//            if let birthDay = leafletPerson.dateOfBirth?.day {
//                selectedBirthDay = birthDay
//            }
//        }
//    }
//    func updateLastDayOfTheMonth() {
//        lastDayOfTheMonth = selectedBirthMonth.lastMonthDay(isLeapYear: isLeapYear(selectedBirthYear))
//        if selectedBirthDay > lastDayOfTheMonth {
//            selectedBirthDay = lastDayOfTheMonth
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
    @State private var placeOfResidence: String
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
        _placeOfResidence = State(initialValue: leafletPerson.wrappedValue.placeOfResidence)
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
                        leafletPerson.personImage == nil ? Text("Add Photo") : Text("Change Photo")
                    })
                    .actionSheet(isPresented: $showActionSheet) {
                        leafletPerson.personImage != nil ?
                        ActionSheet(title: Text("Ընտրել"), buttons: [
                            .default(Text("Փոխել նկարը")) {
                                isImagePickerPresented = true // Открыть галерею
                            },
                            .destructive(Text("Ջնջել նկարը")) {
                                leafletPerson.personImage = nil // Удалить фото
                            },
                            .cancel()
                        ]) :
                        ActionSheet(title: Text("Ավելացնել նկար"), buttons: [
                            .default(Text("Ավելացնել նկար")) {
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
                            .background(Color.white)
                        Divider()
                        
                        TextField("Ազգանուն", text: $surname)
                            .background(Color.white)
                        Divider()
                        
                        TextField("Հայրանուն", text: $patronymic)
                            .background(Color.white)
                        Divider()
                        
                        TextField("Ծննդավայրը", text: $placeOfBirth)
                            .background(Color.white)
                        Divider()
                        
                        TextField("Բնակության վայրը", text: $placeOfResidence)
                            .background(Color.white)
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
                                .background(Color.white)
                            }
                        }
                    }
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(10)
                    Spacer()
                }
            }
            .navigationBarTitle("Edit Person", displayMode: .inline)
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
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Վերադառնալ") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Պահպանել") {
                        
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
        leafletPerson.placeOfResidence = placeOfResidence
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
    @State var testPerson = LeafletPerson(personImage: UIImage(named: "artak"), id: UUID(), name: "Արտակ", surname: "Նազարյան", patronymic: "Լյովայի", gender: .man, dateOfBirth: DatePerson(year: 1980, month: .october, day: 23), dateOfDeath: DatePerson(), placeOfBirth: "Արամուս", placeOfResidence: "Երևան", biography: "", isAlive: .isDied, descendants: [
        LeafletPerson(personImage: UIImage(named: "gayane"), id: UUID(), name: "Գայանե", surname: "Նազարյան", patronymic: "Արտակի", gender: .woman, dateOfBirth: DatePerson(year: 2020, month: .june, day: 05), dateOfDeath: DatePerson(), placeOfBirth: "Երևան", placeOfResidence: "Երևան", biography: "", isAlive: .isAlive, descendants: []),
        LeafletPerson(personImage: UIImage(named: "davit"), id: UUID(), name: "Դավիթ", surname: "Նազարյան", patronymic: "Արտակի", gender: .man, dateOfBirth: DatePerson(year: 2023, month: .october, day: 23), dateOfDeath: DatePerson(), placeOfBirth: "Երևան", placeOfResidence: "Երևան", biography: "", isAlive: .isAlive, descendants: [])
    ])
    
    return EditLeafletPersonView(leafletPerson: $testPerson)
}



//            Button(action: {
//                // Сохраняем изменения
//                leafletPerson.name = name
//                leafletPerson.surname = surname
//                leafletPerson.placeOfBirth = placeOfBirth
//                leafletPerson.placeOfResidence = placeOfResidence
//            }) {
//                Text("Save")
//            }
