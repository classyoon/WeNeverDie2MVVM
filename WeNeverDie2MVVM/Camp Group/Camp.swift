//
//  Camp.swift
//  WeNeverDie2MVVM
//
//  Created by Conner Yoon on 10/17/24.
//
import Foundation

class CampModel : ObservableObject {
    var totalPeople : Int = 3
    func getPeopleNum()->Int{
        return totalPeople
    }
}


