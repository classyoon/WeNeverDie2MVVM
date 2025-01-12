//
//  CampTasks.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 10/22/24.
//

import Foundation
protocol Workable : Identifiable {
    var name : String {get set}
    var id : UUID {get}
    var typeOfActivity : QueuedDailyActivity {get}
}

protocol Completable : Hashable &  Workable{
    var name : String {get set}
    var id : UUID {get}
    var neededProgress : Int {get set}
    var madeProgress : Int { get set}
    var locks : [String] {get set}
}
extension Completable {
    mutating func progress(workers : [Person]){
        for worker in workers{
            neededProgress += 1
        }
    }
}
struct GoingScavenging : Workable {
    var name: String = "Gone Scavenging"
    var id: UUID = UUID()
    var typeOfActivity: QueuedDailyActivity = .goingOut
}
struct BuildingWorkshop : Completable {
    var name: String = "Building Workshop"
    var id: UUID = UUID()
    var neededProgress: Int = 5
    var madeProgress: Int = 0
    var typeOfActivity: QueuedDailyActivity = .workingInCamp
    var locks: [String] = ["Working at workshop"]
}
struct WorkingAtWorkshop : Workable {
    var name: String = "Working at workshop"
    var id: UUID = UUID()
    var typeOfActivity: QueuedDailyActivity = .nothing
}
///
///BuildKeeper is intended to work like a shop keeper. It will accept values from customer in exchange for access to builds
///
class BuildKeeper {
    var builds : [any Workable] = [GoingScavenging(), BuildingWorkshop(), WorkingAtWorkshop()]
//    func getAvailableBuilds()->[any Workable]{
//        
//    }
}
///
///Customer doesn't have to know how it got its builds, it just needs to be able to use them when it gets them and dismiss them when it wants.
///
class Customer {
    var builds : [any Workable] = []
    var money : Int = 10
    var workers : [Person] = []
}
