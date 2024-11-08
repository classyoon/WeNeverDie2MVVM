//
//  GameData.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 10/28/24.
//

import Foundation
class GameModel  : ObservableObject {
    var viewDirector = ViewDecider()
    var outsideModel = AdventureModel()
    var campModel = CampModel()
    var people : [Person] = Person.example
    var projects : [any Workable] = [GoingScavenging(), WorkingAtWorkshop(), BuildingWorkshop()]
    
    func setCamp()->CampModel{
        CampModel(workables: projects, people: people+outsideModel.exit())
    }
    func goAdventure()->AdventureModel{
        AdventureModel(people: campModel.getLeavers())
    }
}
