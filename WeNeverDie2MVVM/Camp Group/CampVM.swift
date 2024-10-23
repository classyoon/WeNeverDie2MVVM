//
//  CampVM.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 10/22/24.
//

import Foundation
class CampViewModel : ObservableObject {
    @Published var showBuildMenu = false
    @Published var showBuildInfo = false
    @Published var displayInfo  = false
    @Published var showWarning = false
    var model : CampModel
    @Published var tasks : [BasicTask] = [BasicTask(name: "Farming", assignablePeople: 3), BasicTask(name: "Building", assignablePeople: 3)]
    func getPeopleNum()->Int{
        return model.getPeopleNum()
    }
 
    init(showBuildMenu: Bool = false, showBuildInfo: Bool = false, displayInfo: Bool = false, showWarning: Bool = false, model: CampModel = CampModel(), tasks : [BasicTask] = [BasicTask(name: "Farming", assignablePeople: 3), BasicTask(name: "Building", assignablePeople: 3)]){
        self.showBuildMenu = showBuildMenu
        self.showBuildInfo = showBuildInfo
        self.displayInfo = displayInfo
        self.showWarning = showWarning
        self.model = model
        self.tasks = tasks
    }
}
