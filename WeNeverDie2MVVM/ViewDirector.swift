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
    
    
    init(model: VisualDirector) {
        self.model = model
        self.showScreen = model.findPriorityView()
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
        print("Find priority \(seenOutTutorial)")
        print("seenOutside \(seenOutTutorial)")
        print("seenOutside \(isInMission)")
        if !seenOutTutorial && isInMission {
            temp = .outsideTutorial
            print("1")
        }else if !seenCampTutorial && !isInMission {
            temp = .campTutorial
            print("2")
        }
        else if isInMission {
            temp = .board
            print("3")
        }
        else {
            temp = .camp
            print("4")
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
