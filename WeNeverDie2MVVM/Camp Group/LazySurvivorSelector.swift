//
//  LazySurvivorSelector.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 4/5/23.
//

import SwiftUI

class SelectorViewModel : ObservableObject {
    @Published var isExpanded: Bool = true
    var audio : AudioManager = AudioManager.shared
    @Published var task : BasicTask
    
    func tap(index : Int){
        do {
              try task.assignPeople(amount: index) // Try to assign people and handle potential errors
          } catch let error as TaskAssigningError {
              // Handle specific TaskAssigningError cases
              print(error.localizedDescription) // You can also replace this with proper error handling as needed
          } catch {
              // Handle any other unexpected errors
              print("An unexpected error occurred: \(error)")
          }
        
    }
    func getImageName(indexAsked:Int)-> String{
        if task.assignedPeople > indexAsked {
            return "person.fill"
        } else {
            return "person"
        }
    }
    private func selectRangeOfSurvivors(_ audio : AudioManager, leftMostIndex : Int = 0, rightMostIndex : Int) {
        
    }
    func getName()->String{
        "\(task.name) : \((task.assignedPeople))"
    }
    init(isExpanded: Bool = true, audio: AudioManager = AudioManager.shared, task: BasicTask = BasicTask(name: "Test", assignedPeople: 4, assignablePeople: 5)) {
        self.isExpanded = isExpanded
        self.audio = audio
        self.task = task
    }
  
}
struct ButtonGridView : View {
    let columns = [GridItem(.adaptive(minimum: 100))]
    @EnvironmentObject var vm : SelectorViewModel
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(0..<vm.task.assignablePeople, id: \.self) { index in
                    VStack{
                        if vm.isExpanded {
                            SurvivorButtonView(index: index)
                        }
                        HStack{
                            InfoButtonView()
                        }
                    }
                }
            }.environmentObject(vm)
        }
    }
}
struct SurvivorButtonView :View {
    @EnvironmentObject var vm : SelectorViewModel
    var index : Int
    var body: some View {
        Button {
            print("Start")
            vm.tap(index: index)
            vm.audio.playSFX(.campVanDoor)
            print("After")
        } label: {
            Image(systemName: vm.task.assignedPeople > index ? "person.fill" : "person")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .foregroundColor(.white)
        }
    }
}



struct LazySurvivorSelector: View {
    
    @ObservedObject var audio : AudioManager
    @ObservedObject var vm : SelectorViewModel
    
    var body: some View {
        VStack{
            ButtonGridModifierView()
            ButtonGridView()
        }.environmentObject(vm)
        .background(.brown.opacity(0.7))
    }
}



#Preview {
    LazySurvivorSelector(audio: AudioManager(), vm: SelectorViewModel(task: BasicTask(name: "Watering", assignablePeople: 5)))
}

struct ButtonGridModifierView : View {
    @EnvironmentObject var vm : SelectorViewModel
    var body: some View {
        HStack{
            Button(action: {
                vm.isExpanded.toggle()
            }) {
                Text(vm.isExpanded ? "Hide" : "Show")
            }
            Text(vm.getName())
                .padding()
                .foregroundColor(.white)
        }
    }
}
struct InfoButtonView : View {
    var body: some View {
        Button {
            print("Button pressed")
        } label: {
            Image(systemName: "info.circle")
        }.padding(0)
            .foregroundColor(.white)
    }
}
