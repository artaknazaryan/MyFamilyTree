//
//  LeafletPersonView.swift
//  My Family Tree
//
//  Created by Artak on 14.09.24.
//


import SwiftUI

struct LeafletPersonInfoView: View {
    
    var leafletPerson = persons[0]
    
    @State private var showAddNewLeaflet = false
    @State private var showAboutBranch = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(uiImage: leafletPerson.personImage ?? UIImage(named: "pesrosnImage")!)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .frame(width: 120, height: 170)
                
                List {
                    Section(header: Text("Անձնական Տվյալներ")) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(leafletPerson.surname)
                                Text(leafletPerson.name)
                                Text(leafletPerson.patronymic)
                                Spacer()
                            }
                            Divider()
                            HStack {
                                Text("\(leafletPerson.dateOfBirth?.formattedDate() ?? "Անհայտ") թ.")
                                if leafletPerson.isDied {
                                    Divider()
                                        .frame(height: 20)
                                    Text(leafletPerson.dateOfDeath?.formattedDate() ?? "Անհայտ")
                                }
                            }
                            Divider()
                            Text("Ծննդավայրը - \(leafletPerson.placeOfBirth)")
                            Divider()
                            Text("Բնակության վայրը- \(leafletPerson.placeOfResidence)")
                        }
                        .padding(.leading)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                    }
                    if leafletPerson.gender == .man && !leafletPerson.descendants.isEmpty {
                        Section(header: Text("ԶԱՎԱԿՆԵՐԸ")) {
                            ForEach(leafletPerson.descendants) { descendant in
                                NavigationLink(destination: LeafletPersonInfoView(leafletPerson: descendant)) {
                                    Text("\(descendant.name) \(descendant.surname)")
                                }
                            }
                        }
                    }
                    
                    Button { // переход на AddNewLeafletView
                        showAddNewLeaflet.toggle()
                    } label: {
                        Text("Նոր տերև")
                    }
                    .sheet(isPresented: $showAddNewLeaflet) {
                        AddNewLeafletView() 
                    }

                    if !leafletPerson.biography.isEmpty {
                        Button(action: {
                            showAboutBranch = true
                        }) {
                            Text("\(leafletPerson.name)ի կենսագրությունը")
                                .font(.system(size: 18))
                                .padding()
                        }
                        .sheet(isPresented: $showAboutBranch) {
                            ScrollView {
                                Text(leafletPerson.biography)
                                    .padding()
                            }
                            Spacer()
                        }
                    }
                }
            }
            Spacer()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(leafletPerson.name)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Ваш код для действия кнопки
                }) {
                    Text("Edit")
                }
            }
        }
        
    }
}

#Preview {
    LeafletPersonInfoView()
}
