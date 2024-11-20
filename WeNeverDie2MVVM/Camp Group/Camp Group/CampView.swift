//
//  CampView.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 10/22/24.
//
import SwiftUI
import Foundation
struct CampView: View {
    @EnvironmentObject var viewDirector : ViewPicker
    @ObservedObject var vm : CampViewModel
    
    var body: some View {
        VStack{
            Text("In")
            ForEach(vm.workablesVM){ workable in
                Text("\(workable.getName())")
                WorkableView(vm: workable).environmentObject(vm)
            }
            Button(vm.canLeave ? "Head to adventure" : "Wait next day"){
                if vm.canLeave {
                    viewDirector.enterAdventure()
                }
            }
            Button("Tutorial"){
                viewDirector.enterTutorial()
            }
            
        }.overlay{
            if vm.displayInfo {
                VStack{
                    Text(vm.inspectedPerson?.name ?? "Error")
                    Button("Exit"){
                        vm.displayInfo = false
                    }
                }
                    .frame(width: 200, height: 100)
                    .background(in: Rectangle())
            }
        }
    }
}


#Preview {
    GameView(viewPicker: ViewPicker()).environmentObject(UniversalMaster())
}
