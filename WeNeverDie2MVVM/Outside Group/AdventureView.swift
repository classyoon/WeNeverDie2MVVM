//
//  AdventureView.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 10/28/24.
//

import SwiftUI

struct AdventureView: View {
    @EnvironmentObject var viewDirector : ViewPicker
    @ObservedObject var vm : AdventureViewModel
    var body: some View {
        VStack{
            Text("Out")
            Button("Move"){
                viewDirector.returnFromAdventure()
                vm.exit()
            }
            ForEach(vm.people){ person in
                Text(person.name)
            }
            Button("Kill"){
                vm.killPerson()
            }
            Button("Tutorial"){
                viewDirector.enterTutorial()
            }
        }

    }
}

#Preview {
    AdventureView(vm: AdventureViewModel(model: AdventureModel())).environmentObject(ViewPicker())
}


class AdventureModel : Identifiable{
    var peopleInAdventure : [Person]
    var id : UUID
    init(people: [Person] = Person.example, id : UUID = UUID()) {
        self.peopleInAdventure = people
        self.id = id
    }
    func getPeople()->[Person]{
        return peopleInAdventure
    }
    func setPeople(_ people : [Person]){
        self.peopleInAdventure = people
    }
  
    func returnPeople()->[Person]{
        return peopleInAdventure
    }
    func exit()->[Person]{
        var peopleLeaving : [Person] = []
            for person in peopleInAdventure {
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
