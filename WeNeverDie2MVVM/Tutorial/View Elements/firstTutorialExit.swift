//
//  firstTutorialExit.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/12/23.
//

import SwiftUI

struct firstTutorialExit: View {
    @EnvironmentObject var vm : ViewDirectorVM

    var body: some View {
        Button(!vm.showBoardTutorial() ? "Begin Game" : "Begin Exploring"){
            vm.skipTutorial()
        }.buttonStyle(.bordered)
            .padding()
    }
}

struct firstTutorialExit_Previews: PreviewProvider {
    static var previews: some View {
        firstTutorialExit().environmentObject(ViewDirectorVM())
    }
}
