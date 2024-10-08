//
//  GameView.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 9/7/24.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var vm : ViewDirectorVM
    var body: some View {
        VStack {
            switch vm.showScreen {
            case .tutorial :
                TutorialView()
            case .board:
                OutsideView()
            case .camp:
                CampView()
                    
            }
         
        }.environmentObject(vm)
    }
}
struct OutsideView: View {
    @EnvironmentObject var vm : ViewDirectorVM
    var body: some View {
        Text("Out")
        Button("Move"){
            vm.leaveBoard()
        }
        Button("Tutorial"){
            vm.enterTutorial()
        }

    }
}
struct CampView: View {
    @EnvironmentObject var vm : ViewDirectorVM
    var body: some View {
        Text("In")
        Button("Move"){
            vm.swapToBoard()
        }
        Button("Tutorial"){
            vm.enterTutorial()
        }
    }
}


#Preview {
    GameView(vm : ViewDirectorVM())
}
