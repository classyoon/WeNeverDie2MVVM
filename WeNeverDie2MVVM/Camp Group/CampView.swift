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
          
            Text("\(vm.workablesVM[0].getName())")
            LazySurvivorSelector(audio: AudioManager.shared, vm: vm.workablesVM[0])
            
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
