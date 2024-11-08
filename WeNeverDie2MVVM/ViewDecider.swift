//
//  ViewDecider.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 9/7/24.
//

import Foundation


enum IntendedView : Codable {
    case adventuringTutorial, campTutorial, adventure, camp
}

class ViewDecider : ObservableObject {
    private var isAdventuring : Bool
    private var seenCampTutorial : Bool
    private var seenAdventureTutorial : Bool
    var showTutorialSeq : Bool = true
    @Published var currentScreen : IntendedView
    init(isInMission: Bool = false, seenCampTutorial: Bool = false, seenAdventureTutorial: Bool = false, currentScreen: IntendedView = .campTutorial) {
        self.isAdventuring = isInMission
        self.seenCampTutorial = seenCampTutorial
        self.seenAdventureTutorial = seenAdventureTutorial
        self.currentScreen = currentScreen
        if showTutorialSeq == false {
            self.seenAdventureTutorial = true
            self.seenCampTutorial = true
            self.currentScreen = .camp
        }
        findPriorityView()
    }
    func enterTutorial(){
        if isAdventuring {
            currentScreen = .adventuringTutorial
        }else{
            currentScreen = .campTutorial
        }
    }

    private func findPriorityView() {
        if isAdventuring {
            currentScreen = seenAdventureTutorial ? .adventure : .adventuringTutorial
        } else {
            currentScreen = seenCampTutorial ? .camp : .campTutorial
        }
    }

    
    func shouldShowAdventuringTutorial()->Bool{
        if currentScreen == .adventuringTutorial  {
            return true
        }
        return false
    }
    
    func shouldShowSkip()->Bool {
        if (currentScreen == .campTutorial && !seenCampTutorial || currentScreen == .adventuringTutorial && !seenAdventureTutorial){
            return true
        }
        return false
    }
    func skipTutorial(){
        if  currentScreen == .campTutorial {
            seenCampTutorial = true
        }else {
            seenAdventureTutorial = true
        }
        findPriorityView()
    }
    func goAdventuring(){
        isAdventuring = true
        findPriorityView()
    }
    func returnFromAdventure(){
        isAdventuring = false
        findPriorityView()
    }
}
