//
//  WeNeverDie2MVVMApp.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 9/7/24.
//

import SwiftUI
import SwiftData

@main
struct WeNeverDie2MVVMApp: App {
    @StateObject var game : GameModel = GameModel()
    var body: some Scene {
        WindowGroup{
            GameView(vm : ViewDirectorVM(model: game.viewDirector))
        }.environmentObject(game)
    }
}

class GameModel : ObservableObject {
    @Published var viewDirector = VisualDirector()
    @Published var camp = Stockpile()

}
