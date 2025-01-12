//
//  ViewPicker.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 9/7/24.
//

import Foundation


enum IntendedView : Codable {
    case adventure, camp
}

class ViewPicker : ObservableObject {
    @Published var inTutorial : Bool
    var tutorial : TutorialManager
    @Published var chosenScreen : IntendedView = .camp
    init() {
        self.tutorial = TutorialManager(assigned: .camp)
        self.inTutorial = !tutorial.showTutorial()
    }
    func enterTutorial(){
        inTutorial = true
    }
    func exitTutorial(){
        inTutorial = false
    }
    func enterAdventure(){
        chosenScreen = .adventure
        tutorial.assignedScreen = chosenScreen
        inTutorial = !tutorial.showTutorial()
    }
    func enterCamp(){
        chosenScreen = .camp
        tutorial.assignedScreen = chosenScreen
        inTutorial = !tutorial.showTutorial()
    }
}

class TutorialManager : ObservableObject {
    var saveKey : String = "Test"
    var seenCampTutorial : Bool
    var seenAdventureTutorial : Bool
    
    var assignedScreen : IntendedView
    func showTutorial()->Bool{
        switch assignedScreen {
        case .camp:
            seenCampTutorial
        case .adventure:
            seenAdventureTutorial
        }
    }
    func markViewed(){
        switch assignedScreen {
        case .camp:
            seenCampTutorial = true
        case .adventure:
            seenAdventureTutorial = true
        }
        save(items: TutorialData(storing: self), key: saveKey)
    }
    init(seenCampTutorial: Bool = false, seenAdventureTutorial: Bool = false, assigned:  IntendedView = .camp) {
        guard willSaveAndLoad == false else {
            let saveddata = load(key: saveKey) ?? TutorialData()
            self.seenAdventureTutorial = saveddata.seenAdventureTutorial
            self.seenCampTutorial = saveddata.seenCampTutorial
            self.assignedScreen = assigned
            return
        }
        guard tutorialChecking == true else {
            self.seenCampTutorial = true
            self.seenAdventureTutorial = true
            self.assignedScreen = assigned
            return
        }
        self.seenCampTutorial = seenCampTutorial
        self.seenAdventureTutorial = seenAdventureTutorial
        self.assignedScreen = assigned
    }
}
class TutorialViewModel {
    var model : TutorialManager
    var viewPicker : ViewPicker
    @Published var largeText = false
    var title : String {
        switch model.assignedScreen {
        case .adventure:
            "Outside Tutorial"
        case .camp:
            "Camp Tutorial"
        }
    }
    var exitButton : String{
        switch model.assignedScreen {
        case .adventure:
            "Begin Exploring"
        case .camp:
            "Begin Game"
        }
    }
    var showSkips : Bool {
        model.showTutorial()
    }
    
    func update(){
        model.markViewed()
        viewPicker.exitTutorial()
        
    }
    func toggleLargeText(){
        largeText ? AudioManager.shared.playSFX(.open) : AudioManager.shared.playSFX(.close)
        largeText.toggle()
    }
    init(model: TutorialManager, largeText: Bool = false, viewPicker: ViewPicker) {
        self.model = model
        self.largeText = largeText
        self.viewPicker = viewPicker
    }
}
struct TutorialData : Codable, Identifiable {
    var id : UUID
    var seenCampTutorial : Bool
    var seenAdventureTutorial : Bool
    init(storing presentUser : TutorialManager? = nil, seenCampTutorial: Bool = false, seenAdventureTutorial: Bool = false){
        self.id = UUID()
        guard let accessedUser = presentUser else {
            self.seenCampTutorial = seenCampTutorial
            self.seenAdventureTutorial = seenAdventureTutorial
            return
        }
        self.seenCampTutorial = accessedUser.seenCampTutorial
        self.seenAdventureTutorial = accessedUser.seenAdventureTutorial
    }
}
func save<T: Identifiable & Codable>(items: T, key: String) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(items) {
        let defaults = UserDefaults.standard
        defaults.set(encoded, forKey: key)
        print("Saving with : \(key)")
    }
}
func load<T: Identifiable & Codable>(key: String) -> T? {
    guard let data = UserDefaults.standard.object(forKey: key) as? Data else { return  nil }
    
    let decoder = JSONDecoder()
    if let dataArray = try? decoder.decode(T.self, from: data) {
        print("Loading with : \(key)")
        return dataArray
    }else {
        print("Failed to load with : \(key)")
    }
    return nil
}
