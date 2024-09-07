//
//  SkipTutorialButton.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/11/23.
//

import SwiftUI

struct SkipTutorialButton: View {
    @ObservedObject var vm : ViewDirectorVM
    
  
    var body: some View {
        VStack{
            HStack{
                Button("Skip to game"){
                    vm.skipTutorial()
                }.buttonStyle(.bordered)
            }
        }.padding()
    }
}

struct firstTutorialSetup_Previews: PreviewProvider {
    static var previews: some View {
        SkipTutorialButton(vm: ViewDirectorVM())
    }
}
