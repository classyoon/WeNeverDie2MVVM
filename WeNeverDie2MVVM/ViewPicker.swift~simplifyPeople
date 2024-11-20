//
//  ViewPicker.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 9/7/24.
//

import Foundation


enum IntendedView {
    case adventuringTutorial, campTutorial, adventure, camp
}

struct ViewPickerData : Codable, Identifiable {
    var id : UUID
    var isAdventuring : Bool
    var seenCampTutorial : Bool
    var seenAdventureTutorial : Bool
    
    init(storing presentUser : ViewPicker? = nil, isAdventuring: Bool = false, seenCampTutorial: Bool = false, seenAdventureTutorial: Bool = false){
        self.id = UUID()
        guard let accessedUser = presentUser else {
            self.isAdventuring = isAdventuring
            self.seenCampTutorial = seenCampTutorial
            self.seenAdventureTutorial = seenAdventureTutorial
            return
        }
        self.isAdventuring = accessedUser.isAdventuring
        self.seenCampTutorial = accessedUser.seenCampTutorial
        self.seenAdventureTutorial = accessedUser.seenAdventureTutorial
    }
}
class ViewPicker : ObservableObject {
    var isAdventuring : Bool
    var saveKey : String = "Test"
    var seenCampTutorial : Bool
    var seenAdventureTutorial : Bool
    
    var requireTutorial : Bool = true
    var willSaveAndLoad : Bool = true
    @Published var chosenScreen : IntendedView = .campTutorial
    init(isInMission: Bool = false, seenCampTutorial: Bool = false, seenAdventureTutorial: Bool = false) {
        guard requireTutorial == true else {
            self.isAdventuring = true
            self.seenAdventureTutorial = true
            self.seenCampTutorial = true
            self.chosenScreen = .camp
            return
        }
        guard willSaveAndLoad == false else {
            let saveddata = load(key: saveKey) ?? ViewPickerData()
            self.isAdventuring = saveddata.isAdventuring
            self.seenCampTutorial = saveddata.seenCampTutorial
            self.seenAdventureTutorial = saveddata.seenAdventureTutorial
            findPriorityView()
            return
        }
        self.isAdventuring = isInMission
        self.seenCampTutorial = seenCampTutorial
        self.seenAdventureTutorial = seenAdventureTutorial
    }
    func enterTutorial(){
        if isAdventuring {
            chosenScreen = .adventuringTutorial
        }else{
            chosenScreen = .campTutorial
        }
    }

    private func findPriorityView() {
        if isAdventuring {
            chosenScreen = seenAdventureTutorial ? .adventure : .adventuringTutorial
        } else {
            chosenScreen = seenCampTutorial ? .camp : .campTutorial
        }
        guard willSaveAndLoad == true else {return}
        save(items: ViewPickerData(storing:self), key: saveKey)
    }

    
    func showAdventureTutorial()->Bool{
        return chosenScreen == .adventuringTutorial
    }
    
    func shouldShowSkip()->Bool {
        if (chosenScreen == .campTutorial && !seenCampTutorial || chosenScreen == .adventuringTutorial && !seenAdventureTutorial){
            return true
        }
        return false
    }
    func skipTutorial(){
        if  chosenScreen == .campTutorial {
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
