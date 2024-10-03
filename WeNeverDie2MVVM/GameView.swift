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
            case .outsideTutorial:
                TutorialView(vm:vm)
            case .campTutorial:
                TutorialView(vm:vm)
            case .board:
                OutsideView(vm: vm)
            case .camp:
                CampView(vm : vm)
                    
            }
         
        }
    }
}
struct OutsideView: View {
    @ObservedObject var vm : ViewDirectorVM
    var body: some View {
        Text("Out")
        Button("Move"){
            vm.leaveBoard()
        }
    }
}
struct CampView: View {
    @ObservedObject var vm : ViewDirectorVM
    var body: some View {
        Text("In")
        Button("Move"){
            vm.swapToBoard()
        }
    }
}


#Preview {
    GameView(vm : ViewDirectorVM())
}
