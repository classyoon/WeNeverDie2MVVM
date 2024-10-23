//
//  TaskLibrary.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 10/22/24.
//

import Foundation
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




enum TaskError: Error, CustomStringConvertible {
    case invalidAssignment

    var description: String {
        switch self {
        case .invalidAssignment:
            return "Cannot assign more people than are available."
        }
    }
}
