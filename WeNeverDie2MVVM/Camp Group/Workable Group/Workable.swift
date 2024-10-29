//
//  Workable.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 10/28/24.
//

import Foundation
class WorkableVM : ObservableObject, Equatable, Identifiable{
    var id: UUID = UUID()
    @Published var people: [Person]
    var model : any Workable
    static func == (lhs: WorkableVM, rhs: WorkableVM) -> Bool {
        lhs.model.id == rhs.model.id
    }
    func confirm(){
        model.assign(people)
    }
    func getName()->String{
        model.name
    }
    func setPerson(_ askForPerson : Person){
        for person in people.indices {
            guard people[person] == askForPerson else {
                continue
            }
            if people[person].activity == model.typeOfActivity {
                people[person].activity = .nothing
            }else{
                people[person].activity = model.typeOfActivity
            }
            break
        }
    }
    init(people: [Person] = Person.example, model: any Workable) {
        self.people = people
        self.model = model
    }
}
protocol Workable : Identifiable {
    var name : String {get set}
    var id : UUID {get}
    var people : [Person] {get set}
    var typeOfActivity : QueuedDailyActivity {get}
}
extension Workable {
    mutating func assign(_ people : [Person]){
        self.people = people
    }
}
