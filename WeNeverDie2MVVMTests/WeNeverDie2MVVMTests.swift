//
//  WeNeverDie2MVVMTests.swift
//  WeNeverDie2MVVMTests
//
//  Created by Conner Yoon on 9/7/24.
//

@testable import WeNeverDie2MVVM

import Testing
class TestingApparatus {
    @Test("Selector Test", arguments: [0,1,2])
    func testSelectorTap(at : Int){
        let camp : CampModel = CampModel()
        let campVM : CampViewModel = CampViewModel(model: camp)
        #expect(campVM.canLeave == false)
        let workVM : WorkableVM = campVM.workablesVM[0]
        workVM.setPerson(workVM.people[at])
        campVM.updateLeaveStatus()
        #expect(campVM.canLeave == true)
        workVM.confirm()// I plan for confirm to set the people that will be in the model so that camp can then just read all of them to see where people go.
        #expect(workVM.model.people[at].activity == .goingOut)
    }
    @Test("Selector Tests", arguments: [0,1,2])
    func manySelectorTests(at : Int){
        let camp : CampModel = CampModel()
        let campVM : CampViewModel = CampViewModel(model: camp)
        #expect(campVM.canLeave == false)
        for workable in campVM.workablesVM {
            workable.setPerson(workable.people[at])
            campVM.updateLeaveStatus()
//            if workable.model.typeOfActivity == .goingOut {
//                #expect(campVM.canLeave == true)
//            }
            workable.confirm()
            #expect(workable.model.people[at].activity == workable.model.typeOfActivity)
        }
       
    }
    
    
    @Test("Screen Change Routine")
    func runScreenChangeRoutine(){
        let game = GameModel()
        let vm = ViewDirectorVM(model: game.viewDirector)
        
        #expect(game.viewDirector.currentScreen == .campTutorial, "Player starts in Camp Tutorial")
        #expect(vm.showScreen == .tutorial && vm.shouldShowSkip(), "Start on Tutorial View")
        vm.skipTutorial()
        
        #expect(game.viewDirector.currentScreen == .camp && vm.showScreen == .camp, "Player enters camp")
        
        vm.swapToOutsideView()
        #expect(game.viewDirector.currentScreen == .outsideTutorial, "Player leaves camp and enters outside tutorial")
        #expect(vm.showScreen == .tutorial && vm.shouldShowSkip(), "Return to Tutorial View")
        
        vm.skipTutorial()
        #expect(game.viewDirector.currentScreen == .outside && vm.showScreen == .outside, "Player exits outside tutorial")
        
        vm.leaveOutsideView()
        #expect(game.viewDirector.currentScreen == .camp && vm.showScreen == .camp, "Player returns to camp")
        #expect(vm.shouldShowSkip() == false, "Tutorial view should no longer have skip button")
    }
}
