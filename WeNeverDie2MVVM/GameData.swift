//
//  GameData.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 10/28/24.
//

import Foundation
class GameModel : ObservableObject {
    var viewDirector = VisualDirector()
    var outsideModel = OutsideModel()
    var campModel = CampModel()
    var people : [Person] = Person.example
    var projects : [any Completable] = []
    
    
}
