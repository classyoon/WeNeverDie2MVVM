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
        let outsideVM = AdventureViewModel(model: game.outsideModel)
        campVM.workablesVM[0].setPerson(Person())
        campVM.confirm()
        game.outsideModel = game.goAdventure()
        #expect(outsideVM.people.isEmpty == false, "A person was sucessfully transported")
    }
    @Test("Screen Change Routine")
    func runScreenChangeRoutine(){
        let game = GameModel()
        let decider = game.viewDirector
        if decider.showTutorialSeq {
            #expect(decider.currentScreen == .campTutorial, "Player starts in Camp Tutorial")
            #expect(decider.shouldShowAdventuringTutorial() == false, "Tutorial should not be in adventure mode.")
            #expect(decider.shouldShowSkip(), "Start on Tutorial View")
            decider.skipTutorial()
            
            #expect(game.viewDirector.currentScreen == .camp, "Player enters camp")
            
            decider.goAdventuring()
            #expect(game.viewDirector.currentScreen == .adventuringTutorial, "Player leaves camp and enters adventure tutorial")
            #expect(game.viewDirector.shouldShowAdventuringTutorial() == true, "Tutorial should be in adventure mode.")
            
            decider.skipTutorial()
            #expect(game.viewDirector.currentScreen == .adventure, "Player exits adventure tutorial")
            decider.enterTutorial()
            #expect(game.viewDirector.currentScreen == .adventuringTutorial, "The tutorial should be the adventure tutorial.")
            
            decider.returnFromAdventure()
            #expect(game.viewDirector.currentScreen == .camp, "Player returns to camp")
            #expect(decider.shouldShowSkip() == false, "Tutorial view should no longer have skip button")
            decider.enterTutorial()
            #expect(game.viewDirector.currentScreen == .campTutorial, "The tutorial should be the camp tutorial.")
        }else{
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
        #expect(model.people[0].vitality == .killed)
    }
    @Test("Testing funeral")
    func testBurial(){
        let game = GameModel()
        let outsideVM = AdventureViewModel(model: game.outsideModel)
        let campVm = CampViewModel(model: game.campModel)
        let goingOutside = WorkableVM(model: game.campModel.workables[0])
        goingOutside.setPerson(game.campModel.people[0])
        goingOutside.confirm()
        game.outsideModel = game.goAdventure()
        outsideVM.killPerson()
        #expect(outsideVM.people[0].vitality == .killed)
        outsideVM.exit()
        #expect(game.outsideModel.people[0].vitality == .killed)
        
        game.campModel = game.setCamp()
        #expect(game.campModel.people[0].vitality == .killed)
        
    
    }
  
}
