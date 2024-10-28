//
//  CampVM.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 10/22/24.
//

import Foundation
class CampViewModel : ObservableObject {
    @Published var showBuildMenu : Bool
    @Published var showBuildInfo : Bool
    @Published var displayInfo  : Bool
    @Published var showWarning : Bool
    @Published var inspectedPerson : Person?
    var model : CampModel
    @Published var workablesVM : [WorkableVM] = []
    @Published var canLeave : Bool
    func updateLeaveStatus(){
        canLeave = model.canLeave()
    }
    init(showBuildMenu: Bool = false, showBuildInfo: Bool = false, displayInfo: Bool = false, showWarning: Bool = false, model : CampModel = CampModel(), canLeave : Bool = false, inspectedPerson : Person? = nil){
        self.showBuildMenu = showBuildMenu
        self.showBuildInfo = showBuildInfo
        self.displayInfo = displayInfo
        self.showWarning = showWarning
        self.model = model
        self.canLeave = false
        for workable in model.workables {
            workablesVM.append(WorkableVM(model: workable))
        }
        self.canLeave = model.canLeave()
        self.inspectedPerson = inspectedPerson
    }
   
}
struct CampModel {
    var workables : [any Workable] = workablesExample
    var people : [Person] = Person.example
    func canLeave()->Bool{
        for person in people {
            guard person.activity == .goingOut else {
                continue
            }
            return true
        }
        return false
    }
    
}
let workablesExample : [any Workable] = [GoingScavenging(), BuildingWorkshop(), WorkingAtWorkshop()]
