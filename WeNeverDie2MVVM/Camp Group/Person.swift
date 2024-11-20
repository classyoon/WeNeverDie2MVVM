//
//  Person.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 10/28/24.
//

import Foundation

class Person : Identifiable, Equatable, ObservableObject {
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.id == rhs.id
    }
    
    var introduced : Bool
    @Published var name : String
    @Published var vitality : HealthStatus
    var playerControlled : Bool
    var id : UUID
    @Published var activity : QueuedDailyActivity
    init(_ name: String = "Bob", id: UUID = UUID(), activity : QueuedDailyActivity = .nothing, introduced : Bool = false, vitals : HealthStatus = .alive, player : Bool = false) {
        self.name = name
        self.id = id
        self.activity = activity
        self.introduced = introduced
        self.vitality = vitals
        self.playerControlled = player
    }
    static let example : [Person] = [Person("Bob"), Person("Jona"), Person("Jessie")]
    
    func loadData(_ storedPerson : PersonStored){
        name = storedPerson.name
        id = storedPerson.id
        activity = storedPerson.lastSavedActivity
        vitality = storedPerson.vitality
        playerControlled = storedPerson.playerControlStatus
    }
}

struct PersonStored : Codable {
    var name : String
    var id : UUID
    var lastSavedActivity : QueuedDailyActivity
    var vitality : HealthStatus
    var playerControlStatus : Bool
}

enum QueuedDailyActivity : Codable {
    case nothing, workingInCamp, goingOut
}
enum HealthStatus : Codable {
    case killed, alive, buried
}

