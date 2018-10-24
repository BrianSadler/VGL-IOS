//
//  GameManager.swift
//  VGL-IOS
//
//  Created by Brian Sadler on 10/21/18.
//  Copyright © 2018 Brian Sadler. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit



class GameManager {
    //Shared instance of the GameManager class
    static let sharedInstance = GameManager()
    
    //We are creating a private initializer so that no instances of this class can be made anywhere else
    private init() {
        gameArray = realm.objects(VideoGame.self)
    }
    
    //Results container for storing our Games.
    private  var gameArray: Results<VideoGame>!
    
    //Refrence to the local Realm database
    let realm = try! Realm()
    
    //Function to get the number of games we have
    func getGameCount() -> Int {
        return gameArray.count
    }
    
    //Function to return a game at a specific index
    func getGame(at index: Int) -> VideoGame {
        return gameArray[index]
    }
    
    //Function to add a game to the game library
    func addGame(game: VideoGame) {
        try! realm.write {
            realm.add(game)
        }
    }
    
    //Function to remove a game from the game library
    func removeGame(at index: Int) {
        try! realm.write {
            realm.delete(getGame(at: index))
        }
    }
    
    //Function to check in or out a game
    func checkGameInOrOut(at index: Int) {
        
        let gameForIndex = gameArray[index]
        try! realm.write {
            gameForIndex.checkedIn = !gameForIndex.checkedIn
            if gameForIndex.checkedIn {
                //Remove any existing due date
                gameForIndex.dueDate = nil
            } else {
                //Add a new due date, since the game has just been checked out
                gameForIndex.dueDate = Calendar.current.date(byAdding: .day, value: 14, to: Date())
                
                
            }
        }
    }
}
