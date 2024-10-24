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
    @Published var workablesVM : [WorkableVM] = [WorkableVM(model: GoingScavenging())]
    init(showBuildMenu: Bool = false, showBuildInfo: Bool = false, displayInfo: Bool = false, showWarning: Bool = false, workablesVM : [WorkableVM] = [WorkableVM(model: GoingScavenging())]){
        self.showBuildMenu = showBuildMenu
        self.showBuildInfo = showBuildInfo
        self.displayInfo = displayInfo
        self.showWarning = showWarning
        self.workablesVM = workablesVM
    }
}
