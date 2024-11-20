//
//  Camp.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 10/17/24.
//
import Foundation
struct CampModel {
    var workables : [any Workable] = [GoingScavenging(), WorkingAtWorkshop()]
    var onGoingProjects : [any Completable] = [BuildingWorkshop()]
    var encampedCharacters : [Person] = Person.example
    func canLeave()->Bool{
        for person in encampedCharacters {
            guard person.activity == .goingOut else {
                continue
            }
            return true
        }
        return false
    }
    mutating func confirm(new : [any Workable]){
        workables = new
    }
    func getLeavers()->[Person]{
        var peopleLeaving : [Person] = []
            for person in encampedCharacters {
                guard person.activity == .goingOut else {
                    continue
                }
                peopleLeaving.append(person)
               
            }
        
        return peopleLeaving
    }
}
