//
//  GameView.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 9/7/24.
//

import SwiftUI

struct GameView: View {
    @StateObject var vm : ViewDirectorVM = ViewDirectorVM(model: VisualDirector())
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
    var vm : ViewDirectorVM
    var body: some View {
        Text("Out")
    }
}
struct CampView: View {
    var vm : ViewDirectorVM
    var body: some View {
        Text("In")
    }
}


#Preview {
    GameView(vm : ViewDirectorVM())
}
