//
//  GameView.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 9/7/24.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewPicker : ViewPicker
    @EnvironmentObject var universalData : UniversalMaster
    var body: some View {
        VStack {
            switch viewPicker.chosenScreen {
            case .campTutorial, .adventuringTutorial :
                TutorialView()
            case .adventure:
                AdventureView(vm: AdventureViewModel(model: universalData.getUpdatedAdventure()))
            case .camp:
                CampView(vm: CampViewModel(model: universalData.getUpdatedCamp()))
            }
        }.environmentObject(viewPicker)
    }
}

var testGame : UniversalMaster = UniversalMaster()
#Preview {
    GameView(viewPicker : testGame.viewPicker ).environmentObject(testGame)
}

