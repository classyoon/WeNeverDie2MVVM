//
//  UniversalMaster.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 11/11/24.
//


import Foundation

class UniversalMaster  : ObservableObject {
    var viewPicker = ViewPicker()
    var adventure = AdventureModel()
    var camp = CampModel()
    var allPeople : [Person] = Person.example
    var allProjects : [any Workable] = [GoingScavenging(), WorkingAtWorkshop(), BuildingWorkshop()]
    func getUpdatedCamp()->CampModel{
        camp.workables = allProjects
        camp.encampedCharacters = allPeople+adventure.exit()
        return camp
    }
    func getUpdatedAdventure()->AdventureModel{
        adventure.peopleInAdventure = camp.getLeavers()
        return adventure
    }
}

