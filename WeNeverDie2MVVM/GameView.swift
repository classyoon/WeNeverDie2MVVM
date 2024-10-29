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
            case .outside:
                OutsideView(vm: OutsideViewModel(model: game.outsideModel))
            case .camp:
                CampView(vm: CampViewModel(model: game.campModel))
            }
        }.environmentObject(vm)
    }
}

#Preview {
    GameView(vm : ViewDirectorVM())
}

