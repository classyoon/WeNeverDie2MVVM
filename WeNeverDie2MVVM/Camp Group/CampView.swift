//
//  CampView.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 10/22/24.
//
import SwiftUI
import Foundation
struct CampView: View {
    @EnvironmentObject var viewDirector : ViewDirectorVM
    @ObservedObject var vm : CampViewModel
    var body: some View {
        VStack{
            Text("In")
            Text("People \(vm.getPeopleNum())")
          
            ForEach(vm.tasks) { task in
                LazySurvivorSelector(audio: AudioManager.shared, vm: SelectorViewModel(task: task))
            }
            Button("Move"){
                viewDirector.swapToOutsideView()
            }
            Button("Tutorial"){
                viewDirector.enterTutorialView()
            }
        }
    }
}


#Preview {
    GameView(vm: ViewDirectorVM(showScreen: .camp))
}
