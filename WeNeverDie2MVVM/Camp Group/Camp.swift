//
//  Camp.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 10/17/24.
//
import Foundation

class Stockpile : ObservableObject {
    var people : [Person] = Person.example
}
class Person : Identifiable, Equatable, ObservableObject {
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.id == rhs.id
    }
    
    @Published var name : String
    var id : UUID
    @Published var screenLocation : ScreenLocations
    @Published var activity : QueuedDailyActivity
    init(_ name: String = "Bob", id: UUID = UUID(), activity : QueuedDailyActivity = .nothing, screenLocation : ScreenLocations = .inCamp) {
        self.name = name
        self.id = id
        self.activity = activity
        self.screenLocation = screenLocation
    }
    static let example : [Person] = [Person("Bob"), Person("Jona"), Person("Jessie")]
}


enum QueuedDailyActivity {
    case nothing, workingInCamp, goingOut
}
enum ScreenLocations {
    case inCamp, outside, grave, unseen
}

