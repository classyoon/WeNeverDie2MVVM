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
            ForEach(vm.workablesVM){ workable in
                Text("\(workable.getName())")
                LazySurvivorSelector(vm: workable).environmentObject(vm)
            }
            Button(vm.canLeave ? "Head to outside" : "Wait next day"){
                if vm.canLeave {
                    viewDirector.swapToOutsideView()
                }
            }
            Button("Tutorial"){
                viewDirector.enterTutorialView()
            }
            
        }.overlay{
            if vm.displayInfo {
                VStack{
                    Text(vm.inspectedPerson?.name ?? "Error")
                    Button("Exit"){
                        vm.displayInfo = false
                    }
                }.background(in: Rectangle())
            }
        }
    }
}


#Preview {
    GameView(vm: ViewDirectorVM(showScreen: .camp))
}
