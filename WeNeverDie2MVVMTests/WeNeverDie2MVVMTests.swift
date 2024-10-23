//
//  WeNeverDie2MVVMTests.swift
//  WeNeverDie2MVVMTests
//
//  Created by Conner Yoon on 9/7/24.
//

import XCTest
@testable import WeNeverDie2MVVM

final class WeNeverDie2MVVMTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    /*
     The following tests whether the screen changes work as they should.
     */
    func testScreenChanges() throws {
        let game = GameModel()
        let vm = ViewDirectorVM(model: game.viewDirector)
        
        XCTAssertEqual(game.viewDirector.currentScreen, .campTutorial, "Player starts in Camp Tutorial")
        XCTAssertEqual(vm.showScreen, .tutorial, "Start on Tutorial View")
        XCTAssertTrue(vm.shouldShowSkip())
        
        vm.skipTutorial()
        XCTAssertEqual(game.viewDirector.currentScreen, .camp, "Player enters camp")
        XCTAssertEqual(vm.showScreen, .camp, "Move to Camp View")
        
        vm.swapToOutsideView()
        XCTAssertEqual(game.viewDirector.currentScreen, .outsideTutorial, "Player leaves camp and enters outside tutorial")
        XCTAssertEqual(vm.showScreen, .tutorial, "Return to Tutorial View")
        XCTAssertTrue(vm.shouldShowSkip())
        
        vm.skipTutorial()
        XCTAssertEqual(game.viewDirector.currentScreen, .outside, "Player exits outside tutorial")
        XCTAssertEqual(vm.showScreen, .outside, "Move to Outside View")
        
        vm.leaveOutsideView()
        XCTAssertEqual(game.viewDirector.currentScreen, .camp, "Player returns to camp")
        XCTAssertEqual(vm.showScreen, .camp, "Return to Camp View")
    }
    func testSelectorTap(){
        var testSelector = SelectorViewModel(task: BasicTask(name: "House Keeping", assignablePeople: 5))
        XCTAssertEqual(testSelector.task.assignedPeople, 0, "Test at 0")
        testSelector.tap(index: 3)
        XCTAssertEqual(testSelector.task.assignedPeople, 3, "Test at 3")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
