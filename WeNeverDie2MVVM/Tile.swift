//
//  Tile.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 12/19/22.
//

import SwiftUI



//
struct TileData {
    var loot = Int.random(in: 0...1)
    var rawMaterials = 0
    var movePenalty = 0
    var damageProtection = 0
    var providesConcealment = false
    var playerSpawn = false
    var friendlySpawn = false
    var soundFile : SFXTag
}
//
//class TileViewModel {
//    func playTile(tile : TileData){
//        AudioManager.shared.playSFX(tile.soundFile)
//    }
//    func getFoodStats(tile : TileData)->String{
//        return "\(tile.loot)"
//    }
//}
//
//
//struct TileView: View {
//    var image: String
//    var difference = 1.0
//    var tileLocation: Coord
//    var image2: String = ""
//    var optionalColor = Color.clear
//    @ViewBuilder
//    var body: some View {
//        ZStack{
//            Rectangle()
//                .fill(optionalColor)
//                .border(Color.white, width: difference)
//            Image(image)
//                .resizable()
//                .padding(difference)
//            image2 != "" ? Image(image2).resizable() : nil
//        }
//    }
//}
//struct Tile_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack{
//            VStack{
//                ForEach(0..<3, id: \.self) { row in
//                    HStack{
//                        ForEach(0..<3, id: \.self) { col in
//                            TileView(image: "building", tileLocation: Coord()).frame(width: 100.0, height: 100.0).padding(0)
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//struct TilePieceDisplay: View {//This is the building block of everything.
//    let row, col : Int
//    @ObservedObject var outside : Outside
//    @ObservedObject var gameData : GameManager
//    @ViewBuilder
//    func getTileAppearance(row : Int, col : Int)-> some View{//Gets apperance, but not effect game.
//        switch outside.terrainOutside[row][col].name{//Really all the same but diff pics, could be streamlined with dictionary
//        case "h":
//            TileView(image: "building", tileLocation: Coord(row, col))
//        case "t":
//            TileView(image: "forest", tileLocation: Coord(row, col), optionalColor: Color.brown)
//        case "w":
//            TileView(image: "water", tileLocation: Coord(row, col))
//        case "X":
//            TileView(image: "grass", tileLocation: Coord(row, col), image2: "escape")
//        case "p":
//            TileView(image: "forest", tileLocation: Coord(row, col), optionalColor: Color.blue)
//        case "b":
//            TileView(image: "", tileLocation: Coord(row, col), optionalColor: Color.gray)
//        case "z":
//            TileView(image: "forest", tileLocation: Coord(row, col), optionalColor: Color.black)
//        default:
//            TileView(image: "grass", tileLocation: Coord(row, col))
//        }
//    }
//    
//    func getSelectionAppearance()-> some View {
//        Group {
//            if let loc = outside.tappedSquare, loc.col == col && loc.row == row {
//                RoundedRectangle(cornerRadius: 30).fill(Color.blue.opacity(0.3)).padding()
//            }
//            if outside.isPossibleLoc(row: row, col: col) && outside.unitWasSelected {
//                Circle().fill(Color.white.opacity(0.3)).padding()
//            }
//            if outside.isPossibleLoc(row: row, col: col) && outside.unitWasSelected {
//                if let piece = outside.pieces[Coord(row, col)] {
//                    if piece.team == .undead {
//                        Circle().fill(Color.red.opacity(0.5)).padding()
//                    }
//                    if piece.team == .neutral {
//                        Circle().fill(Color.green.opacity(0.5)).padding()
//                    }
//                }
//            }
//        }
//    }
//    private func handleTapGesture(){
//        withAnimation {
//            outside.handleTap(tapRow: row, tapCol: col)
//        }
//    }
//
//    var body: some View {
//        ZStack {
//            getTileAppearance(row: row, col: col)
//            getSelectionAppearance()
//            if let piece = outside.pieces[Coord(row, col)]{
//                if !outside.isSquareEmpty(Coord(row, col)){
//                    PieceDisplay(gameData: gameData, piece: piece)
//                }
//            }
//        }
//        .aspectRatio(1, contentMode: .fit)
//        .onTapGesture {
//            handleTapGesture()//This is how the user interacts
//        }
//    }
//}
//
