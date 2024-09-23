//
//  LeafletPersonView.swift
//  My Family Tree
//
//  Created by Artak on 14.09.24.
//


import SwiftUI
import UIKit

struct LeafletPersonInfoView: View {
    
    @State var leafletPerson = persons[0]
    
    @State private var isFullScreen = false
    @State private var showAddNewLeaflet = false
    @State private var showAboutBranch = false
    @State private var isImagePickerPresented = false
    @State private var showActionSheet = false
    
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
                    
                    Button(action: {
                        showActionSheet = true // Открыть ActionSheet
                    }, label: {
                        leafletPerson.personImage == nil ? Text("Add Photo") : Text("Change Photo")
                    })
                    .actionSheet(isPresented: $showActionSheet) {
                        leafletPerson.personImage != nil ?
                        ActionSheet(title: Text("Choose an action"), buttons: [
                            .default(Text("Change Photo")) {
                                isImagePickerPresented = true // Открыть галерею
                            },
                            .destructive(Text("Delete Photo")) {
                                leafletPerson.personImage = nil // Удалить фото
                            },
                            .cancel()
                        ]) :
                        ActionSheet(title: Text("Add a photo"), buttons: [
                            .default(Text("Add Photo")) {
                                isImagePickerPresented = true // Открыть галерею
                            },
                            .cancel()
                        ])
                    }
                    .sheet(isPresented: $isImagePickerPresented) {
                        ImagePicker(selectedImage: $leafletPerson.personImage)
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
                        
                        Button {
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


#Preview {
    LeafletPersonInfoView()
}
