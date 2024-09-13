//
//  LeafletPersonView.swift
//  My Family Tree
//
//  Created by Artak on 14.09.24.
//

import SwiftUI

struct LeafletPersonView: View {
    
    var leafletPerson: LeafletPerson
    
    @State private var showAboutBranch = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("artak")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.height / 2, height: UIScreen.main.bounds.height / 2 + 60) //  ?
                    .cornerRadius(10)
                    .padding()
                
                HStack {
                    Text("\(leafletPerson.name)")
                    Text("\(leafletPerson.surname)")
                }
                .padding()
                 
                NavigationLink(destination: LeafletInfo(leafletPerson: leafletPerson)) {
                    Text("About \(leafletPerson.name)")
                        .foregroundColor(.blue)
                        .padding()
                }
            
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("\(leafletPerson.name)")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showAboutBranch = true
                    }, label: {
                        Text("Back")
                    })
                }
            }
        }
    }
}

#Preview {
    LeafletPersonView(leafletPerson: LeafletPerson(/*maritalStatus: .married,*/ name: "Artak", surname: "Nazaryan", patronymic: "Lyova", gender: .man, dateOfBirth: DatePerson(year: 1980, month: .october, day: 23), dateOfDeath: DatePerson(), placeOfBirth: "Aramus", placeOfResidence: "Yerevan"))
}


