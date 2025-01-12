//
//  TutorialView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/23/23.
//

import SwiftUI
struct FirstExitButton: View {
    var vm : TutorialViewModel
    @EnvironmentObject var viewPicker : ViewPicker
    var body: some View {
        Button(vm.exitButton){
            vm.update()
          
        }.buttonStyle(.bordered)
            .padding()
    }
}
struct ExitTutorialButton : View {
    var vm : TutorialViewModel
    @EnvironmentObject var viewPicker : ViewPicker
    var body: some View {
        VStack{
            HStack{
                Button("Return"){
                    vm.update()
                    viewPicker.exitTutorial()
                }.buttonStyle(.bordered)
            }
        }.padding()
    }
}
struct TutorialView: View {
    var vm : TutorialViewModel
    
    var textSizeButton : some View {
        Button("Toggle Text Enlargement") {
            vm.toggleLargeText()
        }.buttonStyle(.bordered).font(.largeTitle)
    }
    @ViewBuilder
    var skipOrExitButton: some View {
        if !vm.showSkips {
            FirstExitButton(vm: vm)
        } else {
            ExitTutorialButton(vm: vm)
        }
    }
    var body: some View {
        ScrollView {
            VStack{
                textSizeButton
                skipOrExitButton
                switch vm.model.assignedScreen {
                case .adventure:
                    AdventuringTutorial()
                case .camp:
                    CampPhaseTutorial()
                }
                skipOrExitButton
                !vm.showSkips ? Link("Like this game, have suggestions, have bugs? Join the discord", destination: URL(string: "https://discord.gg/ZbAMAjfghk")!).font(.title) : nil
            }
            .textSelection(.enabled)
            .font(vm.largeText ? .title2 : .body).padding().navigationTitle(vm.title)
        }
    }
}


#Preview {
    TutorialView(vm: TutorialViewModel(model: TutorialManager(), viewPicker: ViewPicker()))
}
