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
        return model.isInMission
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
    var isInMission = false
    var seenCampTutorial = false
    var seenOutTutorial = false
    var currentScreen : IntendedView = .campTutorial
    var shared : VisualDirector
    private init(isInMission: Bool = false, seenCampTutorial: Bool = false, seenOutTutorial: Bool = false, currentScreen: IntendedView, shared: VisualDirector) {
        self.isInMission = isInMission
        self.seenCampTutorial = seenCampTutorial
        self.seenOutTutorial = seenOutTutorial
        self.currentScreen = currentScreen
        self.shared = shared
    }
    
    
    private func findPriorityView(){
        if !seenOutTutorial && isInMission {
            currentScreen = .outsideTutorial
        }else if !seenCampTutorial && !isInMission {
            currentScreen = .campTutorial
        }
        else if isInMission {
            currentScreen = .outside
        }
        else {
            currentScreen = .camp
        }
    }
    func getShowScreen()->ShowScreen{
        findPriorityView()
        if currentScreen == .campTutorial || currentScreen == .outsideTutorial{
            return .tutorial
        }else if currentScreen == .outside {
            return .outside
        }else{
            return .camp
        }
    }
    
    func shouldShowSkip()->Bool {
        if currentScreen == .campTutorial && !seenCampTutorial {
            return true
        }
        if currentScreen == .outsideTutorial && !seenOutTutorial {
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
        findPriorityView()
    }
    func exitOutsideView(){
        isInMission = false
        findPriorityView()
    }
}
