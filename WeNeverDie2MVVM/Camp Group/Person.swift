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
    
    @Published var introduced : Bool
    @Published var name : String
    @Published var vitality : HealthStatus
    var id : UUID
    @Published var screenLocation : ScreenLocations
    @Published var activity : QueuedDailyActivity
    init(_ name: String = "Bob", id: UUID = UUID(), activity : QueuedDailyActivity = .nothing, screenLocation : ScreenLocations = .inCamp, introduced : Bool = false, vitals : HealthStatus = .alive) {
        self.name = name
        self.id = id
        self.activity = activity
        self.screenLocation = screenLocation
        self.introduced = introduced
        self.vitality = vitals
    }
    static let example : [Person] = [Person("Bob"), Person("Jona"), Person("Jessie")]
}


enum QueuedDailyActivity {
    case nothing, workingInCamp, goingOut
}
enum HealthStatus{
    case killed, alive, buried
}
enum ScreenLocations {
    case inCamp, outside, grave, unseen
}

