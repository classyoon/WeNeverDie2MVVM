//
//  TutorialView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/23/23.
//

import SwiftUI

/*
 Needs GameManager to tell if isInMission
 */
struct FirstExit : View {
    @EnvironmentObject var vm : ViewDirectorVM
    var body: some View {
        VStack{
            HStack{
                Button("Return"){
                    vm.returnView()
                }.buttonStyle(.bordered)
            }
        }.padding()
    }
}

struct TutorialView: View {
    @State var largeText = false
    @EnvironmentObject var vm : ViewDirectorVM
    
    var textSizeButton : some View {
        Button("Toggle Text Enlargement") {
            if largeText {
                AudioManager.shared.playSFX(.open)
            }else {
                AudioManager.shared.playSFX(.close)
            }
            
            largeText.toggle()
        }.buttonStyle(.bordered).font(.largeTitle)
    }
    
    
    var firstSkip : some View {
        (vm.shouldShowSkip() ? SkipTutorialButton() : nil)
    }
    var firstExit : some View {
        (vm.shouldShowSkip() ? nil : FirstExit() )
    }
    var secondSkip : some View {
        vm.shouldShowSkip() ? firstTutorialExit() : nil
    }
    var secondExit : some View {
        (vm.shouldShowSkip() ? nil : FirstExit() )
    }
    var body: some View {
        ScrollView {
            VStack{
                
                textSizeButton
                HStack{
                    firstExit
                    firstSkip//Show skip if the player hasn't viewed camp tutorial or hasn't viewed outside tutorial while in a mission.
                }
                if vm.showOutsideTutorial() == false {
                    CampPhaseTutorial()
                }else  {
                    OutsidePhaseTutorial()
                }
                
                HStack{
                    secondSkip
                    secondExit
                }
                !vm.shouldShowSkip() ? Link("Like this game, have suggestions, have bugs? Join the discord", destination: URL(string: "https://discord.gg/ZbAMAjfghk")!).font(.title) : nil
            }
            .textSelection(.enabled)
                .font(largeText ? .title2 : .body).padding().navigationTitle(vm.showOutsideTutorial() ? "Outside Tutorial" : "Camp Tutorial")
        }
    }
    
}
    struct TutorialView_Previews: PreviewProvider {
        static var previews: some View {
            TutorialView().environmentObject(ViewDirectorVM())
        }
    }
    
    
    
    
