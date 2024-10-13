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
        Text("People Leaving \(vm.getTravelers())")
        Button("Increase"){
            vm.increaseTravelers()
        }
        Button("Move"){
            viewDirector.swapToOutsideView()
        }
        Button("Tutorial"){
            viewDirector.enterTutorialView()
        }
    }
}

class CampViewModel : ObservableObject {
    @ObservedObject var model : CampModel = CampModel()
    func getPeopleNum()->Int{
        return model.getPeopleNum()
    }
    func getTravelers()->Int{
        return model.getTravelers()
    }
    func increaseTravelers(){
        model.increaseTravelers()
    }
}

class CampModel : ObservableObject {
    var peopleNumber : Int = 3
    var travelersNumber : Int = 0
    func getPeopleNum()->Int{
        return peopleNumber
    }
    func getTravelers()->Int{
        return travelersNumber
    }
    func increaseTravelers(){
        if travelersNumber < peopleNumber {
            travelersNumber += 1
        }
    }
   
    
}

#Preview {
    GameView(vm : ViewDirectorVM())
}
