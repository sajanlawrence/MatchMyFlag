//
//  HomeViewModel.swift
//  MatchMyFlag
//
//  Created by Sajan Lawrence on 13/11/25.
//

import SwiftUI

@Observable
@MainActor class HomeViewModel{
    let allCountries = ["Germany", "UK", "France", "Italy", "Ireland", "Nigeria", "Russia", "Spain", "US", "Poland"]
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    var countries: [Country] = []
    var firstItem: Country?
    var secondItem: Country?
    var matchedItems: [Country] = []
    var isCompletedCheck: Bool = false
    var shouldWait = false
    var totalTries: Int = 0
    let key = "bestScore"
    
    init(){
        let defaults = UserDefaults.standard
        if defaults.object(forKey: key) == nil {
            defaults.set(0, forKey: key)
        }
    }
    
    func saveLatestScore(){
        let defaults = UserDefaults.standard
        let currentTopScore = defaults.integer(forKey: key)
        if totalTries < currentTopScore{
            defaults.set(totalTries, forKey: key)
        }
    }
    
    func getHighestScore() -> Int{
        return UserDefaults.standard.integer(forKey: key)
    }
    
    func getRandomCountries() {
        var arr = Array(allCountries.shuffled().prefix(5))
        arr.append(contentsOf: arr)
        //arr.shuffle()
        countries = arr.map({ Country(name: $0) })
    }
    
    func didSelectCard(with country: Country){
        isCompletedCheck = false
        if firstItem == nil{
            firstItem = country
        }else if secondItem == nil{
            totalTries += 1
            secondItem = country
            shouldWait = true
            if firstItem == secondItem{
                matchedItems.append(country)
                reset()
            }else{
                reset()
            }
        }else{
            reset()
        }
    }
    
    func restartGame(){
        matchedItems = []
        countries = []
        firstItem = nil
        secondItem = nil
        isCompletedCheck = false
        totalTries = 0
        shouldWait = false
        getRandomCountries()
    }
    
    func reset(){
        firstItem = nil
        secondItem = nil
        isCompletedCheck = true
    }
    
    func shouldOpenCard() -> Bool {
        if firstItem == nil || secondItem == nil{
            return true
        }else if isCompletedCheck{
            return true
        }
        return false
    }
}
