//
//  OutsidePhaseTutorial.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 7/20/23.
//

import SwiftUI

struct OutsidePhaseTutorial: View {
    var body: some View {
        VStack{
            Text(welcome)
            Navigating_the_Outside()
            Those_Who_Never_Die()
            Defending_Yourself()
            Map_Tiles_Explained()
            escapeTile()
            goodLuckMessageView()
//            Link("Like this game, have suggestions, have bugs? Join the discord", destination: URL(string: "https://discord.gg/ZbAMAjfghk")!).font(.title)
        }
    }
    var welcome = """
Welcome outside.

Gather supplies and recruit people.

TO RETURN HOME, GO TO THE VAN.

THE UNDEAD WILL GROW IN NUMBER WHEN NIGHT COMES.

If we wait out the night, we will have to run come sunrise.

If too many zombies are left if that happen, we will have use five food to distract them or risk our lives.

The rest of this tutorial will teach you :
How to move, attack, search for supplies, and recruit.
Who your enimies are.
The effects of each terrain.
"""
    
    var defending = """
    When you select on one of your survivors, you will see a red indicator on who that survivor can attack. Each attack costs 1 stamina. Same applies for your enimies.
    
    Do not be worried about the infection if one of your people get hit. Do worry still about being mauled to death.
    """
    
    var growing = """
This is another survivor, who is not part of your group and has been living by themself. You will see a green indicator when your survivor is in range to start to convince them to leave their hiding spot and join you. Each talk will take 1 stamina.
"""
    
    var survivorDescrip = "This is one of your people. Color may vary depending on whether you are on standard or alternative vision."
    
    var moving = "You tap to select them. The white circles will indicate where they can try to go. The instant you tap on one of these circles your person will move to that tile at the cost of 1 stamina point, unless it is a piece of difficult terrain."
    
    var staminaAndHP = """
The number on the top left stands for the hit points an entity has before it dies, while the green ticks represents the stamina points an entity still has on this turn. Stamina points dictate how many actions can be performed per turn. You do not have to use all of them. Actions such as moving, searching, talking, and attacking will cost stamina points.

The only way you can replenish your people's stamina points is to tap \"Next turn,\" but be careful since that is when your enemies will move.
"""
    
    var shambler = """
Above is a Shuffler. They are a common but very weak and very stupid zombie that has a view range of about 3.

Like most zombies, they are nocturnal; however, you may still see some wandering about during the day.
"""
    
    var grassfield = "This is a grass field."
    
    var forest = "This is a forest, when you stand in them, the undead lose your scent. There is a decent amount of materials here in a form of small logs. Since it is considered difficult terrain, it costs 2 stamina to enter the tile."
    
    var searching = """
To search, select a survivor who has stamina left and hit the \"Search Location\" button to search the tile for usable food and materials. Do not worry about your carry capacity. You will hear a certain sound to indicate to you when there is nothing left to find on the tile.
"""
    var buildingText = """
This is an abandoned building. It tends to have a good amount of food and a decent amount of building materials in the form of loose planks.
"""
    
    var water = "This is a body of water. It tends to be rich in food due to the fish. Like the forest, it is considered difficult terrain; therefore, it costs 2 stamina to enter the tile."
    var playerStart = "This is where your people will start. It provides concealment like a forest but is NOT difficult terrain."
    var zombieSpawner = "If you see this, this will tell you where zombies will spawn."
    var escape = """
This is our van. Make sure to pan around to find it. We start a good bit away from it though, since it does attract a lot of attention.

Once you are satisfied with your haul or if things get too dicey, get your survivors to it. If everyone on the expedition dies, we obviously don't get the stuff, but we do find the van though.
"""
    
    func Defending_Yourself() -> some View {
        VStack {
            Text("Defending Yourself").font(.title)
            Text(defending)
            Image("NewOutsideExample").resizable().frame(width: 300, height: 300)
            Text("Those Who Never Die").font(.title)
            Text(shambler)
            Image("AgroZombie").resizable().frame(width: 350, height: 200).padding()
            
        }
    }

    func Navigating_the_Outside() -> some View {
        VStack {
            Text("The Basics").font(.title)
            Text(survivorDescrip)
            Image("SurvivorY").resizable().frame(width: 350, height: 200)
            Text(moving)
            Image("NewOutsideExample").resizable().frame(width: 300, height: 300)
            Text(staminaAndHP)
        }
    }
    func Purpose() -> some View {
        VStack {
            Text("Your Purpose Out Here").font(.title)
            Text(searching)
            Image("SurvivorW").resizable().frame(width: 350, height: 200)
            Text(growing)
            Image("NewOutsideExample").resizable().frame(width: 300, height: 300)
        }
    }
   
    func Those_Who_Never_Die() -> some View {
        VStack {
            
        }
    }
    func Map_Tiles_Explained() -> some View {
        VStack {
            Text("Tiles and How to Return Home").font(.title)
            Image("grass").resizable().frame(width: 300, height: 300).padding()
            Text(grassfield)
          //  TileView(image: "forest", tileLocation: Coord(), optionalColor: .brown).frame(width: 300, height: 300).padding()
            Text(forest)
            Image("building").resizable().frame(width: 300, height: 300).padding()
            Text(buildingText)
            Image("water").resizable().frame(width: 300, height: 300).padding()
            Text(water)
            newTiles()
           
        }
    }
    func newTiles()-> some View {
        VStack{
         //   TileView(image: "forest", tileLocation: Coord(), optionalColor: .blue).frame(width: 300, height: 300).padding()
            Text(playerStart)
         //   TileView(image: "forest", tileLocation: Coord(), optionalColor: .black).frame(width: 300, height: 300).padding()
            Text(zombieSpawner)
            
        }
    }
    func escapeTile()-> some View {
        VStack{
//            TileView(image: "grass", tileLocation: Coord(), image2: "escape").frame(width: 300, height: 300).padding()
            Text(escape)
        }
    }
    func goodLuckMessageView() -> some View {
        Text("That is all, Survivor. Good luck out there to you and your friends. I highly reccommend you check out the other tutorials.")
    }
    
}

struct OutsidePhaseTutorial_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView{
            OutsidePhaseTutorial()
        }
    }
}
