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
        let game = GameModel()
        let campVM = CampViewModel(model: game.campModel)
        #expect(campVM.canLeave == false, "When nobody wants to leave")
        let workVM : WorkableVM = campVM.workablesVM[0]
        workVM.setPerson(workVM.people[at])
        campVM.updateLeaveStatus()
        #expect(campVM.canLeave == true)
    }
    @Test("Outside Move Test")
    func testOutsideGeneration(){
        let game = GameModel()
        let campVM = CampViewModel(model: game.campModel)
        let outsideVM = OutsideViewModel(model: game.outsideModel)
        campVM.workablesVM[0].setPerson(Person())
        campVM.confirm()
        game.outsideModel = game.setOutside()
        #expect(outsideVM.people.isEmpty == false, "A person was sucessfully transported")
    }
    @Test("Screen Change Routine")
    func runScreenChangeRoutine(){
        let game = GameModel()
        let vm = ViewDirectorVM(model: game.viewDirector)
        
        #expect(game.viewDirector.currentScreen == .campTutorial, "Player starts in Camp Tutorial")
        #expect(vm.showOutsideTutorial() == false, "Tutorial should not be in outside mode.")
        #expect(vm.showScreen == .tutorial && vm.shouldShowSkip(), "Start on Tutorial View")
        vm.skipTutorial()
        
        #expect(game.viewDirector.currentScreen == .camp && vm.showScreen == .camp, "Player enters camp")
        
        vm.swapToOutsideView()
        #expect(game.viewDirector.currentScreen == .outsideTutorial, "Player leaves camp and enters outside tutorial")
        #expect(vm.showOutsideTutorial() == true, "Tutorial should be in outside mode.")
        #expect(vm.showScreen == .tutorial && vm.shouldShowSkip(), "Return to Tutorial View")
        
        vm.skipTutorial()
        #expect(game.viewDirector.currentScreen == .outside && vm.showScreen == .outside, "Player exits outside tutorial")
        vm.enterTutorialView()
        #expect(game.viewDirector.currentScreen == .outsideTutorial, "The tutorial should be the outside tutorial.")
        
        vm.leaveOutsideView()
        #expect(game.viewDirector.currentScreen == .camp && vm.showScreen == .camp, "Player returns to camp")
        #expect(vm.shouldShowSkip() == false, "Tutorial view should no longer have skip button")
        vm.enterTutorialView()
        #expect(game.viewDirector.currentScreen == .campTutorial, "The tutorial should be the camp tutorial.")
    }
    @Test("Testing death")
    func testDeath(){
        let model = OutsideModel(people: [Person("Bob")])
        let outsideVM = OutsideViewModel(model: model)
        
        outsideVM.killPerson()
        #expect(outsideVM.people[0].vitality == .killed)
        outsideVM.exit()
        #expect(model.people[0].vitality == .killed)
    }
  
}
