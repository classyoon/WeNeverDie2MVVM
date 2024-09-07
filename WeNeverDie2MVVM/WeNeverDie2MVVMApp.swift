//
//  WeNeverDie2MVVMApp.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 9/7/24.
//

import SwiftUI
import SwiftData

@main
struct WeNeverDie2MVVMApp: App {
    var body: some Scene {
        WindowGroup{
            GameView(vm : ViewDirectorVM())
        }
    }
}
