//
//  Testing.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 11/19/24.
//


import Foundation
class StoredPerson {
    var id: UUID
    var name: String
    var health: Int
    var game : Game
    init(id: UUID = UUID(), name: String, health: Int, game : Game) {
        self.id = id
        self.name = name
        self.health = health
        self.game = game
    }
}

class Game {
    var id: UUID
    var name: String
    var characters : [StoredPerson]
    var builds : [Build]
    
    init(id: UUID, name: String, characters : [StoredPerson], builds : [Build]) {
        self.id = id
        self.name = name
        self.characters = characters
        self.builds = builds
    }
}
class Build {
    var id: UUID
    var name: String
    var health: Int
    var game : Game
    init(id: UUID = UUID(), name: String, health: Int, game : Game) {
        self.id = id
        self.name = name
        self.health = health
        self.game = game
    }
}
