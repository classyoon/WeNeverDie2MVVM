//
//  OutsideView.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 10/28/24.
//

import SwiftUI

struct OutsideView: View {
    @EnvironmentObject var viewDirector : ViewDirectorVM
    @ObservedObject var vm : OutsideViewModel
    var body: some View {
        VStack{
            Text("Out")
            Button("Move"){
                viewDirector.leaveOutsideView()
            }
            ForEach(vm.people){ person in
                Text(person.name)
            }
            Button("Tutorial"){
                viewDirector.enterTutorialView()
            }
        }

    }
}

#Preview {
    OutsideView(vm: OutsideViewModel(model: OutsideModel())).environmentObject(ViewDirectorVM())
}


class OutsideModel {
    var people : [Person]
    init(people: [Person] = Person.example) {
        self.people = people
    }
    func getPeople()->[Person]{
        return people
    }
    func setPeople(_ people : [Person]){
        self.people = people
    }
}

class OutsideViewModel : ObservableObject {
    var model : OutsideModel
    @Published var people : [Person]
    init(model: OutsideModel = OutsideModel(), people : [Person] = Person.example) {
        self.model = model
        self.people = model.getPeople()
    }
    func getPeople(){
        people = model.getPeople()
    }
}
