//
//  GameView.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 9/7/24.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var vm : ViewDirectorVM
    @EnvironmentObject var game : GameModel
    var body: some View {
        VStack {
            switch vm.showScreen {
            case .tutorial :
                TutorialView()
            case .adventure:
                AdventureView(vm: AdventureViewModel(model: game.goAdventure()))
            case .camp:
                CampView(vm: CampViewModel(model: game.setCamp()))
            }
        }.environmentObject(vm)
    }
}

var testGame : GameModel = GameModel()
#Preview {
    GameView(vm : ViewDirectorVM(model: testGame.viewDirector)).environmentObject(testGame)
}

