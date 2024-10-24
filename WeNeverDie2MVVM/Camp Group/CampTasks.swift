//
//  CampTasks.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 10/22/24.
//

import Foundation
protocol Completable : Identifiable &  Workable{
    var name : String {get set}
    var id : UUID {get}
    var neededProgress : Int {get set}
    var madeProgress : Int { get set}
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

struct GoingScavenging : Workable {
    var name: String = "Gone Scavenging"
    var id: UUID = UUID()
    var people: [Person] = []
    var typeOfActivity: QueuedDailyActivity = .goingOut
}
struct BuildingWorkshop : Completable {
    var name: String = "Building Workshop"
    var id: UUID = UUID()
    var people: [Person] = []
    var neededProgress: Int = 5
    var madeProgress: Int = 0
    var typeOfActivity: QueuedDailyActivity = .workingInCamp
}
struct WorkingAtWorkshop : Workable {
    var name: String = "Working at workshop"
    var id: UUID = UUID()
    var people: [Person] = []
    var typeOfActivity: QueuedDailyActivity = .nothing
    
}

class WorkableVM : ObservableObject{
    @Published var people: [Person]
    var model : any Workable
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
