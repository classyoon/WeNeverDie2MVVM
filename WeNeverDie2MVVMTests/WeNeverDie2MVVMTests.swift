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
        let game = UniversalMaster()
        let campVM = CampViewModel(model: game.camp)
        #expect(campVM.canLeave == false, "When nobody wants to leave")
        let workVM : WorkableVM = campVM.workablesVM[0]
        workVM.setPerson(workVM.people[at])
        campVM.updateLeaveStatus()
        #expect(campVM.canLeave == true)
    }
    @Test("Outside Move Test")
    func testOutsideGeneration(){
        let game = UniversalMaster()
        let campVM = CampViewModel(model: game.camp)
        let outsideVM = AdventureViewModel(model: game.adventure)
        campVM.workablesVM[0].setPerson(Person())
        game.adventure = game.getUpdatedAdventure()
        #expect(outsideVM.people.isEmpty == false, "A person was sucessfully transported")
    }
    @Test("Screen Change Routine")
    func runScreenChangeRoutine(){
        let game = UniversalMaster()
        let decider = game.viewPicker
        let tutorial = decider.tutorial
        if willSaveAndLoad == false {
            #expect(decider.chosenScreen == .camp, "Player starts in Camp")
            #expect(tutorial.assignedScreen == .camp, "Player starts in Camp")
            #expect(tutorial.showTutorial() == false)
            #expect(decider.inTutorial)
            var vm  = TutorialViewModel(model: tutorial, viewPicker: decider)
            vm.update()
            #expect(decider.inTutorial == false)
            #expect(tutorial.seenCampTutorial == true)
            decider.enterAdventure()
            #expect(decider.chosenScreen == .adventure, "Player moves to adventure")
            #expect(tutorial.assignedScreen == .adventure, "Player moves to adventure")
            #expect(decider.inTutorial == true)
            vm.update()
            #expect(decider.inTutorial == false)
        }else if tutorialChecking == false{
            print("Tutorial sequence off")
        }
        
    }
    @Test("Testing death")
    func testDeath(){
        let model = AdventureModel(people: [Person("Bob")])
        let outsideVM = AdventureViewModel(model: model)
        
        outsideVM.killPerson()
        #expect(outsideVM.people[0].vitality == .killed)
        outsideVM.exit()
        #expect(model.peopleInAdventure[0].vitality == .killed)
    }
    @Test("Testing funeral")
    func testBurial(){
        let game = UniversalMaster()
        let outsideVM = AdventureViewModel(model: game.adventure)
        let campVm = CampViewModel(model: game.camp)
        let goingOutside = WorkableVM(model: game.camp.workables[0])
        goingOutside.setPerson(game.camp.encampedCharacters[0])
        game.adventure = game.getUpdatedAdventure()
        outsideVM.killPerson()
        #expect(outsideVM.people[0].vitality == .killed)
        outsideVM.exit()
        #expect(game.adventure.peopleInAdventure[0].vitality == .killed)
        
        game.camp = game.getUpdatedCamp()
        #expect(game.camp.encampedCharacters[0].vitality == .killed)
        
    
    }
  
}
