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
                    
//                    Button(action: {
//                        showActionSheet = true // Открыть ActionSheet
//                    }, label: {
//                        leafletPerson.personImage == nil ? Text("Add Photo") : Text("Change Photo")
//                    })
//                    .actionSheet(isPresented: $showActionSheet) {
//                        leafletPerson.personImage != nil ?
//                        ActionSheet(title: Text("Ընտրել"), buttons: [
//                            .default(Text("Փոխել նկարը")) {
//                                isImagePickerPresented = true // Открыть галерею
//                            },
//                            .destructive(Text("Ջնջել նկարը")) {
//                                leafletPerson.personImage = nil // Удалить фото
//                            },
//                            .cancel()
//                        ]) :
//                        ActionSheet(title: Text("Ավելացնել նկար"), buttons: [
//                            .default(Text("Ավելացնել նկար")) {
//                                isImagePickerPresented = true // Открыть галерею
//                            },
//                            .cancel()
//                        ])
//                    }
//                    .sheet(isPresented: $isImagePickerPresented) {
//                        ImagePicker(selectedImage: $leafletPerson.personImage)
//                    }

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
                                    if leafletPerson.isAlive == .isDied {
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
                    showEditLeaflet.toggle()
                }) {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $showEditLeaflet) {
                    EditLeafletPersonView(leafletPerson: $leafletPerson) // Передаем данные для редактирования
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

//extension LeafletPersonInfoView {
//    final class LeafletPersonInfoViewModel: ObservableObject {
//        @Published fileprivate var leafletPerson = persons[0]
//    }
//}

//class LeafletPersonViewModel: ObservableObject {
//    @Published var leafletPerson = persons[0] // Предполагается, что LeafletPerson - ваша модель
//    
//    init(leafletPerson: LeafletPerson) {
//        self.leafletPerson = leafletPerson
//    }
//    
//    func updateImage(_ image: UIImage?) {
//        leafletPerson.personImage = image
//    }
//    
//    func deleteImage() {
//        leafletPerson.personImage = nil
//    }
//}

#Preview {
    LeafletPersonInfoView(leafletPerson: persons[0])
}
