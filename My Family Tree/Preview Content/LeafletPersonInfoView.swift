//
//  LeafletPersonView.swift
//  My Family Tree
//
//  Created by Artak on 14.09.24.
//


import SwiftUI

struct LeafletPersonInfoView: View {
    
    var leafletPerson = persons[0]
    @State private var showAboutBranch = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(uiImage: leafletPerson.personImage ?? UIImage(named: "pesrosnImage")!)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2 * 1.3 )
                
                List {
                    Section(header: Text("Անձնական Տվյալներ")) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(leafletPerson.surname)
                                Text(leafletPerson.name)
                                Text(leafletPerson.patronymic)
                                Spacer()
                            }
                            HStack {
                                Text("\(leafletPerson.dateOfBirth?.formattedDate() ?? "Unknown") թ.")
                                if leafletPerson.isDied {
                                    Divider()
                                        .frame(height: 20)
                                    Text(leafletPerson.dateOfDeath?.formattedDate() ?? "Unknown")
                                }
                            }
                            Text("Ծննդավայրը - \(leafletPerson.placeOfBirth)")
                            Text("Բնակության վայրը- \(leafletPerson.placeOfResidence)")
                        }
                        .padding()
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

//#Preview {
//    LeafletPersonInfoView(leafletPerson:
//                            LeafletPerson(/*maritalStatus: .married,*/ name: "Monte", surname: "Melkonyan", patronymic: "", gender: .man, dateOfBirth: DatePerson(year: 1957, month: .november, day: 25), dateOfDeath: DatePerson(year: 1993, month: .june, day: 12), placeOfBirth: "USA", placeOfResidence: "Armenia", biography: """
//                                                                                Монте Мелькониан (Армянский: Մոնթէ Մելքոնեան,25 ноября 1957 года - 12 июня 1993 года) был армяно-американским революционероми левый националистический боевик. Он был командующим Армией обороны Арцах и был убит во время борьбы против Азербайджана в Первой Нагорно-Карабахской войне.
//                                                                                
//                                                                                Мелконян, родившийся в Калифорнии, покинул Соединенные Штаты и прибыл в Иран в качестве учителя в 1978 году, во время иранской революции. Он принял участие в демонстрациях против Мохаммеда Резы Пехлеви, а затем отправился в Ливан, чтобы служить в армянском ополчении, базирующемся в Бейруте, сражающемся в гражданской войне в Ливане. Мелконян был активен в Бурдж-Хаммуде и был одним из планировщиков нападения на турецкое консульство в Париже в 1981 году. Позже он был арестован и заключен в тюрьму во Франции. Он был освобожден в 1989 году и получил визу для поездки в Армению в 1990 году.
//                                                                                
//                                                                                До Первой Нагорно-Карабахской войны, во время которой он командовал примерно 4000 армянскими войсками, Мелконян не имел официальной службы в вооруженных силах какой-либо страны. Вместо этого его военный опыт был во время его деятельности в ASALA во время гражданской войны в Ливане. С ASALA Мелконян боролся против различных правых ливанских ополченцев в Бейруте и его окрестностях, а также участвовал в боевых действиях против Израиля во время Ливанской войны 1982 года.
//                                                                                
//                                                                                В течение своей военной карьеры Мелконян принял ряд союзников, включая Абу Синди, Тимоти Шона МакКормака и Саро. Во время Первой Нагорно-Карабахской войны многие армянские солдаты под его командованием называли его Аво (Աւօ). 12 июня 1993 года Мельконян был убит азербайджанскими солдатами, когда он обследовал деревню Марзили с пятью другими армянскими солдатами после битвы. Он был похоронен на военном кладбище в Йераблуре в столице Армении Ереване, и в 1996 году был посмертно присвоен титул Национального Героя Армении.
//                                                                                """, isDied: true, descendants: []))
//}
