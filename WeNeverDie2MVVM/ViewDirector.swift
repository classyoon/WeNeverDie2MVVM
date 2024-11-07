//
//  ViewDirector.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 9/7/24.
//

import Foundation
class ViewDirectorVM : ObservableObject {
    var model : VisualDirector
    @Published var showScreen : ShowScreen
    func skipTutorial(){
        model.skipTutorial()
        showScreen = model.getShowScreen()
    }
    func showOutsideTutorial()-> Bool{
        return model.shouldShowAdventuringTutorial()
    }
    func shouldShowSkip()->Bool {
        return model.shouldShowSkip()
    }
    func returnView(){
        showScreen = model.getShowScreen()
    }
    func enterTutorialView(){
        showScreen = .tutorial
        model.setWhichTutorial()
    }
    func swapToAdventureView(){
        model.goAdventuring()
        showScreen = model.getShowScreen()
    }
    func leaveAdventureView(){
        model.returnFromAdventure()
        showScreen = model.getShowScreen()
    }
    
    init(model: VisualDirector) {
        self.model = model
        self.showScreen = model.getShowScreen()
    }
    
    init(showScreen : ShowScreen){
        self.model = VisualDirector()
        self.showScreen = showScreen
    }
    init(){
        self.model = VisualDirector()
        self.showScreen = model.getShowScreen()
    }
}

enum IntendedView : Codable {
    case adventuringTutorial, campTutorial, adventure, camp
}
enum ShowScreen {
    case tutorial, adventure, camp
}

class VisualDirector {
    private var isAdventuring : Bool
    private var seenCampTutorial : Bool
    private var seenAdventureTutorial : Bool
    private var showTutorialSeq : Bool = false
    var currentScreen : IntendedView
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
    func setWhichTutorial(){
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
    func getShowScreen()->ShowScreen{
        findPriorityView()
        
        switch currentScreen {
        case .adventuringTutorial:
            return .tutorial
        case .campTutorial:
            return .tutorial
        case .adventure:
            return .adventure
        case .camp:
            return .camp
        }
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
    }
    func goAdventuring(){
        isAdventuring = true
    }
    func returnFromAdventure(){
        isAdventuring = false
    }
}
