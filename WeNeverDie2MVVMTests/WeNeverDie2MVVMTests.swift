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
    func testScreenChanges() throws {
        let game = GameModel()
        let vm = ViewDirectorVM(model: game.viewDirector)
        
        XCTAssertEqual(game.viewDirector.currentScreen, .campTutorial, "Start in Camp Tutorial")
        XCTAssertEqual(vm.showScreen, .tutorial, "Start on Tutorial View")
        XCTAssertTrue(vm.shouldShowSkip())
        
        vm.skipTutorial()
        XCTAssertEqual(game.viewDirector.currentScreen, .camp, "Move to camp")
        XCTAssertEqual(vm.showScreen, .camp, "Move to camp view")
        
        vm.swapToOutsideView()
        XCTAssertEqual(game.viewDirector.currentScreen, .outsideTutorial, "Enter outside tutorial")
        XCTAssertEqual(vm.showScreen, .tutorial, "Return to Tutorial View")
        XCTAssertTrue(vm.shouldShowSkip())
        
        vm.skipTutorial()
        XCTAssertEqual(game.viewDirector.currentScreen, .outside, "enter outside")
        XCTAssertEqual(vm.showScreen, .outside, "move to outside view")
        
        vm.leaveOutsideView()
        XCTAssertEqual(game.viewDirector.currentScreen, .camp, "Return to camp")
        XCTAssertEqual(vm.showScreen, .camp, "Return to camp view")
        
        XCTAssertFalse(vm.shouldShowSkip())
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
