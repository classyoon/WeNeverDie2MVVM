//
//  TutorialSectionView.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 11/8/24.
//

import SwiftUI

struct TutorialSectionView: View {
    var section: TutorialSection
    
    var body: some View {
        VStack {
            Text(section.title)
                .font(.title)
            Text(section.content)
            ForEach(section.images, id: \.self) { imageName in
                Image(imageName.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
            Text(section.bottomContent)
        }
        .padding()
    }
}



#Preview {
    TutorialSectionView(section: campTutorial[1])
}
struct TutorialSection {
    var title: String
    var content: String
    var images: [FramedImage] // List of image names to display
    var bottomContent : String
    init(title: String = "", _ content: String, images: [FramedImage] = [], b bottomContent : String = "") {
        self.title = title
        self.content = content
        self.images = images
        self.bottomContent = bottomContent
    }
}

let exampleTutorialSection : TutorialSection = TutorialSection(title: "BILLY", "AIDFIASDF ANSDO ADSFN ADIS A ", images: [FramedImage("SurivivorW")])


let exploreTutorial : [TutorialSection] = [
    exampleTutorialSection,
    exampleTutorialSection
]
let campTutorial : [TutorialSection] = [
    TutorialSection("Hello Survivor, \nWelcome to the tutorial! \nSociety is gone, but you’re still alive with two friends. Your mission is to survive and even thrive in the wake of a zombie apocalypse as you rebuild society by cautiously sifting through its remains. With the knowledge I will bestow, may thy ventures be successful.\n"),
//    TutorialSection(title: "Home Sweet Home","""
//                    Below represents your camp. Here your survivors live their lives, safe from the undead, and get healed from their wounds, fully healed on the next day.
//                    """, images: ["SurvivorW"])
]

enum RelativeImageSize {
    case large, small, medium
}
struct FramedImage : Hashable{
    var name : String
    var caption : String?
    var size : RelativeImageSize
    init(_ name: String, _ caption: String? = nil, _ size : RelativeImageSize = .medium) {
        self.name = name
        self.caption = caption
        self.size = size
    }
    
}
