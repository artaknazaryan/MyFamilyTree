//
//  TreeView.swift
//  My Family Tree
//
//  Created by Artak on 16.09.24.
//


import SwiftUI

struct TreeView: View {
    @State private var showLeafletPerson = false
    var person = persons[0]
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // NavigationLink оборачивает область для клика
                NavigationLink(isActive: $showLeafletPerson) {
                    LeafletPersonInfoView(leafletPerson: LeafletPerson(
                        personImage: person.personImage,
                        name: person.name,
                        surname: person.surname,
                        patronymic: person.patronymic,
                        gender: person.gender,
                        dateOfBirth: person.dateOfBirth,
                        dateOfDeath: person.dateOfDeath,
                        placeOfBirth: person.placeOfBirth,
                        placeOfResidence: person.placeOfResidence,
                        biography: person.biography,
                        isAlive: person.isAlive, 
                        descendants: person.descendants
                    ))
                } label: {
                    ZStack {
                        Image(systemName: "leaf.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 90)
                            .foregroundColor(.green)
                        VStack {
                            Text(person.name)
                                .font(.headline)
                                .foregroundColor(.black)
                            Text(person.surname)
                                .font(.subheadline)
                                .foregroundColor(.black)
                        }
                        .padding(5)
                        .background(Color.clear)
                        .cornerRadius(10)
                    }

                }
            }
            .padding()
        }
    }
}

#Preview {
    TreeView()
}
