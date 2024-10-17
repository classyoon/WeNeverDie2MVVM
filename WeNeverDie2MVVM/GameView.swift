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
            case .outside:
                OutsideView()
            case .camp:
                CampView(vm: CampViewModel())
            }
        }.environmentObject(vm)
    }
}
struct OutsideView: View {
    @EnvironmentObject var vm : ViewDirectorVM
    var body: some View {
        Text("Out")
        Button("Move"){
            vm.leaveOutsideView()
        }
        Button("Tutorial"){
            vm.enterTutorialView()
        }

    }
}
struct CampView: View {
    @EnvironmentObject var viewDirector : ViewDirectorVM
    @ObservedObject var vm : CampViewModel
    var body: some View {
        Text("In")
        Text("People \(vm.getPeopleNum())")
        Button("Move"){
            viewDirector.swapToOutsideView()
        }
        Button("Tutorial"){
            viewDirector.enterTutorialView()
        }
    }
}

