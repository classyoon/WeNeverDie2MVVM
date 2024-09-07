//
//  CampPhaseTutorial.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 7/20/23.
//

import SwiftUI

struct CampPhaseTutorial: View {
    var body: some View {
        VStack{
            tutorialView()
            campIntro()
            Text(resources)
            missionSending()
            buildingTutor()
            goodLuckMessageView()
        }
    }
    func tutorialView() -> some View {
        Text("Hello Survivor, \nWelcome to the tutorial! \nSociety is gone, but you’re still alive with two friends. Your mission is to survive and even thrive in the wake of a zombie apocalypse as you rebuild society by cautiously sifting through its remains. With the knowledge I will bestow, may thy ventures be successful.\n")
    }
    
    func goodLuckMessageView() -> some View {
        Text("That is all, Survivor. Good luck out there to you and your friends. I highly reccommend you check out the other tutorials")
    }
    
    
    var camp = """
Below represents your camp. Here your survivors live their lives, safe from the undead, and get healed from their wounds, fully healed on the next day.
"""
    
    var resources = """
Here you are safe. Mostly. You can still starve to death if you run out of food for too long.

There are currently two resources you should keep track of :
Food - For eating (1 per person), Building Material - For building
"""
 
    var buildButton = """
Your job though isn't just to survive but to rebuild along side it. Buildings will help you achieve that goal. It is also where you can make the cure to win.

Tap the button with a hammer to open the build menu. Once there, tap on the question mark there for a tutorial.
"""

    var goOnMission = """
You can't just stay here though, at least at the beginning. You need to gather resources and people, and to do that in the early stages you need to send out expeditions.

Tap on one of the people to select them for an expedition. You will select everyone to the left (or right depending on your settings). If you do not like the order your people are in, you can tap on a person's name to open up a menu and have that person swap places. You can tap on the i next to their names to learn more about them.

Either of the below buttons to progress to the next day. If the button is a van, it means that you will also be starting a mission.

Once there tap the question mark to see the tutorial for there.
"""
    func campIntro()-> some View {
        VStack{
            Text("Home Sweet Home").font(.title)
            Text(camp)
            Image("Campground").resizable().frame(height: 400)
        }
    }
    
    func buildingTutor()-> some View {
        VStack{
            Text("Making Progress").font(.title2)
            Text(buildButton)
            HStack{
                
                Image("Hammer").resizable().frame(width: 100, height: 100)
                Image("Hammer Complete").resizable().frame(width: 100, height: 100)
                Text("This means a building is complete")
                Image("Hammer Issue").resizable().frame(width: 100, height: 100)
                Text("This means a building did not have enough to function for the day.")
            }
        }
    }
    
    func missionSending()->some View {
        VStack{
            Text("Taking a Turn/Making Expeditions").font(.title2)
            Text(goOnMission)
            HStack{
            Image("Bus").resizable().frame(width: 100, height: 100)
                Image("Clock").resizable().frame(width: 100, height: 100)
            }
        }
    }
}

struct CampPhaseTutorial_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView{
            CampPhaseTutorial()
        }
    }
}
