//
//  AdventureView.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 10/28/24.
//

import SwiftUI

struct AdventureView: View {
    @EnvironmentObject var viewDirector : ViewDirectorVM
    @ObservedObject var vm : AdventureViewModel
    var body: some View {
        VStack{
            Text("Out")
            Button("Move"){
                viewDirector.leaveAdventureView()
                vm.exit()
            }
            ForEach(vm.people){ person in
                Text(person.name)
            }
            Button("Kill"){
                vm.killPerson()
            }
            Button("Tutorial"){
                viewDirector.enterTutorialView()
            }
        }

    }
}

#Preview {
    AdventureView(vm: AdventureViewModel(model: AdventureModel())).environmentObject(ViewDirectorVM())
}


class AdventureModel  {
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
  
    func returnPeople()->[Person]{
        return people
    }
    func exit()->[Person]{
        var peopleLeaving : [Person] = []
            for person in people {
                guard person.vitality == .alive else {
                    continue
                }
                peopleLeaving.append(person)
               
            }
        
        return peopleLeaving
    }
}

class AdventureViewModel : ObservableObject {
    var model : AdventureModel
    @Published var people : [Person]
    init(model: AdventureModel = AdventureModel(), people : [Person] = Person.example) {
        self.model = model
        self.people = model.getPeople()
    }
    func getPeople(){
        people = model.getPeople()
    }
    func killPerson(){
//        var target = people.randomElement()?.vitality
//        print("name \(target?.name ?? "Nobody")")
//        target?.vitality = .killed
//        people.randomElement()?.vitality = .killed
        people[0].vitality = .killed
    }
    func exit(){
        model.setPeople(people)
    }
  
}
