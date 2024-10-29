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

