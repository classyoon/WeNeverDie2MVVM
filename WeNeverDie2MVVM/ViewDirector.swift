//
//  ViewDirector.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 9/7/24.
//

import Foundation
class ViewDirectorVM : ObservableObject {
    var model : VisualDirector
    @Published var showScreen : MandatoryScreenShow
    private func setShowScreen(){
        showScreen = model.findPriorityView()
    }
    func skipTutorial(){
        model.skipTutorial(skipped: showScreen)
        setShowScreen()
    }
    func showBoardTutorial()-> Bool{
        return model.isInMission
    }
    func shouldShowSkip()->Bool {
        if showScreen == .campTutorial && !model.seenCampTutorial {
            return true
        }
        if showScreen == .outsideTutorial && !model.seenOutTutorial {
            return true
        }
        return false
    }
    func swapToBoard(){
        model.setToBoard()
        setShowScreen()
    }
    func leaveBoard(){
        model.exitBoard()
        setShowScreen()
    }
    
    
    init(model: VisualDirector, showScreen: MandatoryScreenShow = .camp) {
        self.model = model
        self.showScreen = showScreen
    }
    init(showScreen : MandatoryScreenShow){
        self.model = VisualDirector()
        self.showScreen = showScreen
    }
    init(){
        self.model = VisualDirector()
        self.showScreen = model.findPriorityView()
    }
    
}
enum MandatoryScreenShow {
    case outsideTutorial, campTutorial, board, camp
}

class VisualDirector {
    var isInMission = false
    var seenCampTutorial = false
    var seenOutTutorial = false
    func findPriorityView()->MandatoryScreenShow{
        var temp = MandatoryScreenShow.camp
        if !seenOutTutorial && isInMission {
            temp = .outsideTutorial
        }else if !seenCampTutorial && !isInMission {
            temp = .campTutorial
        }
        else if isInMission {
            temp = .board
        }
        else {
            temp = .camp
        }
        return temp
    }
    
    
    func skipTutorial(skipped : MandatoryScreenShow){
        if skipped == .campTutorial {
            seenCampTutorial = true
        }else {
            seenOutTutorial = true
        }
    }
    func setToBoard(){
        isInMission = true
    }
    func exitBoard(){
        isInMission = false
    }
}
