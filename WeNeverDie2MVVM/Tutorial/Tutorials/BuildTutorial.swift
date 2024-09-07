//
//  BuildTutorial.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 9/11/23.
//

import SwiftUI

struct BuildTutorial: View {
    var startConstruction = """
Welcome to the build tutorial.

Tap on \"Start construction\" to start construction of that building.

It will show up in the camp.

Tap the i to get info about the building.

Make the cure to win! Good luck!
"""
    var body: some View {
        ScrollView{
            Text(startConstruction)
            Link("Like this game, have suggestions, have bugs? Join the discord", destination: URL(string: "https://discord.gg/ZbAMAjfghk")!).font(.title)
        }
    }
}

struct BuildTutorial_Previews: PreviewProvider {
    static var previews: some View {
        BuildTutorial()
    }
}
