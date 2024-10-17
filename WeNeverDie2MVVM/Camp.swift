//
//  Camp.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 10/17/24.
//

import Foundation
class CampViewModel : ObservableObject {
    var model : CampModel = CampModel()
    func getPeopleNum()->Int{
        return model.getPeopleNum()
    }
    
 
 
}
enum TaskError: Error, CustomStringConvertible {
    case invalidAssignment

    var description: String {
        switch self {
        case .invalidAssignment:
            return "Cannot assign more people than are available."
        }
    }
}
class Task : Identifiable {
    var id : UUID = UUID()
    var name : String = "Unlabeled"
    var assignedPeople : Int = 0
    var assignablePeople : Int = 0
}

class CampModel : ObservableObject {
    var totalPeople : Int = 3
    func getPeopleNum()->Int{
        return totalPeople
    }
}

#Preview {
    GameView(vm : ViewDirectorVM())
}


protocol AssignableTask : Identifiable {
    var id : UUID {get}
    var name : String {get set}
    var assignedPeople : Int {get set}
    var assignablePeople : Int {get set}
    
    func assignPeople(amount : Int) throws
    func getAssignablePeople() throws
}

class TypicalTask : AssignableTask {
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
enum TaskAssigningError: Error {
    case exceedsAssignableLimit
    case negativeAssignment
    case insufficientAssignablePeople

    // Custom error messages
    var localizedDescription: String {
        switch self {
        case .exceedsAssignableLimit:
            return "Error - Task Related : You cannot assign more people than the task allows."
        case .negativeAssignment:
            return "Error - Task Related : Assignment amount cannot be negative."
        case .insufficientAssignablePeople:
            return "Error - Task Related : A task was created having a negative amount of assignable people."
        }
    }
}
enum PersonAssignmentError: Error {
    case personInWrongPlace, nullPerson, misplacedPerson
    // Custom error messages
    var localizedDescription: String {
        switch self {
        case.personInWrongPlace :
            return "Error - Person Related : Someone was assigned to the wrong place"
        case.nullPerson :
            return "Error - Person Related : Person who shouldn't exist exists."
        case.misplacedPerson :
            return "Error - Person Related : Couldn't find asked for person."
        }
    }
}
class GoingOutside: TypicalTask {
    init() {
        super.init(name: "Going Outside", assignablePeople: 5)
    }
}

class BuildingHouses: TypicalTask {
    init() {
        super.init(name: "Building Homes", assignablePeople: 10)
    }
}

class CraftingTools: TypicalTask {
    init() {
        super.init(name: "Crafting Tools", assignablePeople: 3)
    }
}

class TaskFactory {
    
}

