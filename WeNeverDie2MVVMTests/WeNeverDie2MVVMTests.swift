//
//  WeNeverDie2MVVMTests.swift
//  WeNeverDie2MVVMTests
//
//  Created by Conner Yoon on 9/7/24.
//

@testable import WeNeverDie2MVVM

import Testing
class TestingApparatus {
    @Test("Selector Test")
    func testSelectorTap(){
        var testSelector = SelectorViewModel(task: BasicTask(name: "House Keeping", assignablePeople: 5))
        #expect(testSelector.task.assignedPeople == 0, "Test at 0")
        testSelector.tap(index: 3)
        #expect(testSelector.task.assignedPeople == 3, "Test at 3")
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
    @Test("Sample Test", arguments: [0,1,2,3])
    func sampleTesting(sampleInput : Int) {
        var task = BasicTask(name: "Test", assignablePeople: 3)
        var selector = SelectorViewModel(task: task)
        selector.tap(index: sampleInput)
        #expect(task.assignedPeople == sampleInput)
    }
}
