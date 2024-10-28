//
//  LazySurvivorSelector.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 4/5/23.
//

import SwiftUI


struct ButtonGridView : View {
    let columns = [GridItem(.adaptive(minimum: 100))]
    @EnvironmentObject var vm : WorkableVM
   
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(vm.people) { person in
                    VStack{
                        SurvivorButtonView(person : person)
                        HStack{
                            InfoButtonView().environmentObject(person)
                        }
                    }
                }
            }.environmentObject(vm)
        }
    }
}
struct SurvivorButtonView :View {
    @EnvironmentObject var vm : WorkableVM
    @ObservedObject var person : Person
    @EnvironmentObject var campvm : CampViewModel
    var body: some View {
        Button {
            vm.setPerson(person)
            campvm.updateLeaveStatus()
        } label: {
            Image(systemName: person.activity == vm.model.typeOfActivity ? "person.fill" : "person")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .foregroundColor(.white)
        }
    }
}



struct LazySurvivorSelector: View {
    @ObservedObject var vm : WorkableVM

    var body: some View {
        VStack{
            ButtonGridView()
        }.environmentObject(vm)
        .background(.brown.opacity(0.7))
    }
}



struct InfoButtonView : View {
    @EnvironmentObject var person : Person
    var body: some View {
        HStack{
            Button {
                print("Button pressed")
            } label: {
                Image(systemName: "info.circle")
            }.padding(0)
                .foregroundColor(.white)
            Text(person.name)
        }
       
    }
}
