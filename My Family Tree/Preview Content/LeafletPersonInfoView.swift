//
//  LeafletPersonView.swift
//  My Family Tree
//
//  Created by Artak on 14.09.24.
//


import SwiftUI
import UIKit


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct LeafletPersonInfoView: View {
    
    @State var leafletPerson: LeafletPerson
    @State private var isFullScreen = false
    @State private var showAddNewLeaflet = false
    @State private var showAboutBranch = false
    @State private var isImagePickerPresented = false
    @State private var showActionSheet = false
    @State private var showEditLeaflet = false
    
    var body: some View {
        NavigationStack {
                if isFullScreen && leafletPerson.personImage != nil {
                    Spacer()
                    Image(uiImage: leafletPerson.personImage!)
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                isFullScreen.toggle()
                            }
                        }
                    Spacer()
                } else {
                    VStack {
                        HStack {
                            Image(uiImage: leafletPerson.personImage ?? UIImage(named: "pesrosnImage")!)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                                .frame(width: 120, height: 170)
                                .onTapGesture {
                                    withAnimation {
                                        isFullScreen.toggle()
                                    }
                                }
                            
                            // Проверяем, если человек не одинок, и есть данные о супруге
                            if leafletPerson.maritalStatus != .notMarried, let spouse = leafletPerson.spouse {
                                Image(uiImage: spouse.spouseImage ?? UIImage(named: "pesrosnImage")!)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                                    .frame(width: 120, height: 170)
                            }
                        }
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
                                        Text("\(leafletPerson.dateOfBirth?.formattedDate() ?? "Անհայտ")")
                                        if leafletPerson.isAlive == .isDied {
                                            Divider()
                                                .frame(height: 20)
                                            Text(leafletPerson.dateOfDeath?.formattedDate() ?? "Անհայտ")
                                        }
                                    }
                                    Divider()
                                    Text("Ծննդավայրը - \(leafletPerson.placeOfBirth)")
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
                                    Button(action: {
                                        showAddNewLeaflet.toggle()
                                    }) {
                                        Text("Նոր տերև")
                                    }
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center)
                                    .sheet(isPresented: $showAddNewLeaflet) {
                                        AddNewLeafletView(onAdd: { newPerson in
                                            addDescendant(to: &leafletPerson, descendant: newPerson)
                                        })
                                    }
                                }
                            } else if leafletPerson.gender == .man {
                                Button(action: {
                                    showAddNewLeaflet.toggle()
                                }) {
                                    Text("Նոր տերև")
                                }
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                                .sheet(isPresented: $showAddNewLeaflet) {
                                    AddNewLeafletView(onAdd: { newPerson in
                                        addDescendant(to: &leafletPerson, descendant: newPerson)
                                    })
                                }
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
                }
            Spacer()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(leafletPerson.name)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showEditLeaflet.toggle()
                }) {
                    Text("Խմբագրել")
                }
            }
        }
        .sheet(isPresented: $showEditLeaflet) {
            EditLeafletPersonView(leafletPerson: $leafletPerson)
        }
    }
}

// Функция для добавления нового потомка
func addDescendant(to parent: inout LeafletPerson, descendant: LeafletPerson) {
    parent.descendants.append(descendant)
}


#Preview {
    LeafletPersonInfoView(leafletPerson: persons[0])
}
