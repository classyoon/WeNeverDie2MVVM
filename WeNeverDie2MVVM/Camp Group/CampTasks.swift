//
//  CampTasks.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 10/22/24.
//

import Foundation
class BasicTask : Identifiable{
    let id: UUID
     var name: String
     var assignedPeople: Int
     var assignablePeople: Int
    init(id: UUID = UUID(), name: String, assignedPeople: Int = 0, assignablePeople: Int) {
        self.id = id
        self.name = name
        self.assignedPeople = assignedPeople
        self.assignablePeople = assignablePeople
    }
    func assignPeople(amount: Int) throws {
          // Negative assignment not allowed
          if amount < 0 {
              throw TaskAssigningError.negativeAssignment
          }
          // Prevent over-assigning
          if amount > assignablePeople {
              throw TaskAssigningError.exceedsAssignableLimit
          }
          assignedPeople = amount
    }
    func getAssignablePeople() throws {
          // Negative assignment not allowed
        if assignablePeople < 0 {
            throw TaskAssigningError.insufficientAssignablePeople
        }
    }
}
protocol AssignableTask : Identifiable {
    var id : UUID {get}
    var name : String {get set}
    var assignedPeople : Int {get set}
    var assignablePeople : Int {get set}
    
    func assignPeople(amount : Int) throws
    func getAssignablePeople() throws
}
enum CampResources {
    case food, material
}
protocol TakesInputTask : AssignableTask {
    var output : [ResourceNugget] {get set}
}
protocol TakesOutputTask : AssignableTask {
    var input : [ResourceNugget] {get set}
}
struct ResourceNugget {
    var amount : Int
    var type : CampResources
}

class TypicalTask : AssignableTask {
    static func == (lhs: TypicalTask, rhs: TypicalTask) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    let id: UUID
     var name: String
     var assignedPeople: Int
     var assignablePeople: Int
    
     init(name: String, assignablePeople: Int, assignedPeople: Int = 0) {
         self.id = UUID()
         self.name = name
         self.assignablePeople = assignablePeople
         self.assignedPeople = assignedPeople
     }
    func assignPeople(amount: Int) throws {
          // Negative assignment not allowed
          if amount < 0 {
              throw TaskAssigningError.negativeAssignment
          }
          // Prevent over-assigning
          if amount > assignablePeople {
              throw TaskAssigningError.exceedsAssignableLimit
          }
          assignedPeople = amount
    }
    func getAssignablePeople() throws {
          // Negative assignment not allowed
        if assignablePeople < 0 {
            throw TaskAssigningError.insufficientAssignablePeople
        }
    }
}
class TakesToMakeTask : TypicalTask, TakesInputTask & TakesOutputTask  {
    var output: [ResourceNugget]
    var input: [ResourceNugget]
    init(output : [ResourceNugget] = [], input : [ResourceNugget] = []) {
        self.output = output
        self.input = input
        super.init(name: "Crafting Tools", assignablePeople: 3)
    }
}
