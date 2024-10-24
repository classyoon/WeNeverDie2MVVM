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
        return model.shouldShowOutsideTutorial()
    }
    func shouldShowSkip()->Bool {
        return model.shouldShowSkip()
    }
    func returnView(){
        showScreen = model.getShowScreen()
    }
    func enterTutorialView(){
        showScreen = .tutorial
    }
    func swapToOutsideView(){
        model.setToOutside()
        showScreen = model.getShowScreen()
    }
    func leaveOutsideView(){
        model.exitOutsideView()
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
    case outsideTutorial, campTutorial, outside, camp
}
enum ShowScreen {
    case tutorial, outside, camp
}
    

class VisualDirector {
    private var isInMission : Bool
    private var seenCampTutorial : Bool
    private var seenOutTutorial : Bool
    var currentScreen : IntendedView
    init(isInMission: Bool = false, seenCampTutorial: Bool = false, seenOutTutorial: Bool = false, currentScreen: IntendedView = .campTutorial) {
        self.isInMission = isInMission
        self.seenCampTutorial = seenCampTutorial
        self.seenOutTutorial = seenOutTutorial
        self.currentScreen = currentScreen
    }
    

    private func findPriorityView() {
        if isInMission {
            currentScreen = seenOutTutorial ? .outside : .outsideTutorial
        } else {
            currentScreen = seenCampTutorial ? .camp : .campTutorial
        }
    }

    
    func shouldShowOutsideTutorial()->Bool{
        return seenOutTutorial
    }
    func getShowScreen()->ShowScreen{
        findPriorityView()
        
        switch currentScreen {
        case .outsideTutorial:
            return .tutorial
        case .campTutorial:
            return .tutorial
        case .outside:
            return .outside
        case .camp:
            return .camp
        }
    }
    
    func shouldShowSkip()->Bool {
        if (currentScreen == .campTutorial && !seenCampTutorial || currentScreen == .outsideTutorial && !seenOutTutorial){
            return true
        }
        return false
    }
    func skipTutorial(){
        if  currentScreen == .campTutorial {
            seenCampTutorial = true
        }else {
            seenOutTutorial = true
        }
    }
    func setToOutside(){
        isInMission = true
    }
    func exitOutsideView(){
        isInMission = false
    }
}
