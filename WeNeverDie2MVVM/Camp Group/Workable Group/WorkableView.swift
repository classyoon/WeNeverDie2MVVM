//
//  WorkableView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 4/5/23.
//

import SwiftUI

struct WorkableView: View {
    @ObservedObject var vm : WorkableVM

    var body: some View {
        VStack{
            ArrayOfPersonButtonsView()
        }.environmentObject(vm)
        .background(.brown.opacity(0.7))
    }
}
struct ArrayOfPersonButtonsView : View {
    let columns = [GridItem(.adaptive(minimum: 100))]
    @EnvironmentObject var vm : WorkableVM
   
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(vm.people) { person in
                    VStack{
                        PersonButtonView()
                        HStack{
                            InfoButtonView()
                        }
                    }.environmentObject(person)
                }
            }.environmentObject(vm)
        }
    }
}
struct PersonButtonView :View {
    @EnvironmentObject var vm : WorkableVM
    @EnvironmentObject var person : Person
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
struct InfoButtonView : View {
    @EnvironmentObject var person : Person
    @EnvironmentObject var campvm : CampViewModel
    var body: some View {
        HStack{
            Button {
                print("Button pressed")
                campvm.displayInfo = true
                campvm.inspectedPerson = person
            } label: {
                Image(systemName: "info.circle")
            }.padding(0)
                .foregroundColor(.white)
            Text(person.name)
        }
       
    }
}
//var camp : CampVM = Camp
#Preview {
    
    WorkableView(vm: WorkableVM(model: GoingScavenging()))
}
