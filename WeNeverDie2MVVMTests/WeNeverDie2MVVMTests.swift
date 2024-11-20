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
        campVM.confirm()
        game.adventure = game.getUpdatedAdventure()
        #expect(outsideVM.people.isEmpty == false, "A person was sucessfully transported")
    }
    @Test("Screen Change Routine")
    func runScreenChangeRoutine(){
        let game = UniversalMaster()
        let decider = game.viewPicker
        if decider.requireTutorial && decider.willSaveAndLoad == false{
            #expect(decider.chosenScreen == .campTutorial, "Player starts in Camp Tutorial")
            #expect(decider.showAdventureTutorial() == false, "Tutorial should not be in adventure mode.")
            #expect(decider.shouldShowSkip(), "Start on Tutorial View")
            decider.skipTutorial()
            
            #expect(game.viewPicker.chosenScreen == .camp, "Player enters camp")
            
            decider.goAdventuring()
            #expect(game.viewPicker.chosenScreen == .adventuringTutorial, "Player leaves camp and enters adventure tutorial")
            #expect(game.viewPicker.showAdventureTutorial() == true, "Tutorial should be in adventure mode.")
            
            decider.skipTutorial()
            #expect(game.viewPicker.chosenScreen == .adventure, "Player exits adventure tutorial")
            decider.enterTutorial()
            #expect(game.viewPicker.chosenScreen == .adventuringTutorial, "The tutorial should be the adventure tutorial.")
            
            decider.returnFromAdventure()
            #expect(game.viewPicker.chosenScreen == .camp, "Player returns to camp")
            #expect(decider.shouldShowSkip() == false, "Tutorial view should no longer have skip button")
            decider.enterTutorial()
            #expect(game.viewPicker.chosenScreen == .campTutorial, "The tutorial should be the camp tutorial.")
        }else if decider.requireTutorial == false{
            #expect(decider.isAdventuring)
            #expect(decider.seenAdventureTutorial)
            #expect(decider.seenCampTutorial)
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
        goingOutside.confirm()
        game.adventure = game.getUpdatedAdventure()
        outsideVM.killPerson()
        #expect(outsideVM.people[0].vitality == .killed)
        outsideVM.exit()
        #expect(game.adventure.peopleInAdventure[0].vitality == .killed)
        
        game.camp = game.getUpdatedCamp()
        #expect(game.camp.encampedCharacters[0].vitality == .killed)
        
    
    }
  
}
