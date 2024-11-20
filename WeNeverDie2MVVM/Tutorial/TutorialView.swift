//
//  TutorialView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/23/23.
//

import SwiftUI
struct FirstExitButton: View {
    @EnvironmentObject var vm : ViewPicker
    var body: some View {
        Button(!vm.showAdventureTutorial() ? "Begin Game" : "Begin Exploring"){
            vm.skipTutorial()
        }.buttonStyle(.bordered)
            .padding()
    }
}
struct ExitTutorialButton : View {
    @EnvironmentObject var vm : ViewPicker
    var body: some View {
        VStack{
            HStack{
                Button("Return"){
                    vm.skipTutorial()
                }.buttonStyle(.bordered)
            }
        }.padding()
    }
}
struct TutorialView: View {
    @State var largeText = false
    @EnvironmentObject var vm : ViewPicker
    
    var textSizeButton : some View {
        Button("Toggle Text Enlargement") {
            largeText ? AudioManager.shared.playSFX(.open) : AudioManager.shared.playSFX(.close)
            largeText.toggle()
        }.buttonStyle(.bordered).font(.largeTitle)
    }
    @ViewBuilder
    var skipOrExitButton: some View {
        if vm.shouldShowSkip() {
            FirstExitButton()
        } else {
            ExitTutorialButton()
        }
    }
    var body: some View {
        ScrollView {
            VStack{
                
                textSizeButton
                skipOrExitButton
                switch vm.chosenScreen {
                case .adventuringTutorial,.adventure:
                    AdventuringTutorial()
                case .campTutorial,.camp:
                    CampPhaseTutorial()
                }
                skipOrExitButton
                !vm.shouldShowSkip() ? Link("Like this game, have suggestions, have bugs? Join the discord", destination: URL(string: "https://discord.gg/ZbAMAjfghk")!).font(.title) : nil
            }
            .textSelection(.enabled)
            .font(largeText ? .title2 : .body).padding().navigationTitle(vm.showAdventureTutorial() ? "Outside Tutorial" : "Camp Tutorial")
        }
    }
    
}
    struct TutorialView_Previews: PreviewProvider {
        static var previews: some View {
            TutorialView().environmentObject(ViewPicker())
        }
    }
    
    
    
    
