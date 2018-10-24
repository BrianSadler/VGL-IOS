//
//  ViewController.swift
//  VGL-IOS
//
//  Created by Brian Sadler on 10/15/18.
//  Copyright © 2018 Brian Sadler. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var selectedGame: VideoGame!
    
   
    @IBOutlet weak var gameListTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GameManager.sharedInstance.getGameCount()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell") as! GameTableViewCell
        
        let selectedGame = GameManager.sharedInstance.getGame(at: indexPath.row)
        
        cell.gameTitle.text = selectedGame.title
        cell.genreLabel.text = selectedGame.genre
        cell.gameRating.text = selectedGame.rating
        
        //If the current game is checked in, the background color of the status view will be green. Otherwise, it will be red
        if selectedGame.checkedIn {
            cell.checkedIn.backgroundColor = UIColor.green
        } else {
            cell.checkedIn.backgroundColor = UIColor.red
        }
        
        //If the game has a due date, we want to format it into a String and display it on the dueDateLabel
        if let dueDate = selectedGame.dueDate {
            cell.dueDate.text = formatDate(dueDate)
        } else {
            cell.dueDate.text = ""
        }
        
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EditGame {
           
            //We need to pass through the Game that we'll be editing.
            destination.gameToEdit = selectedGame
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        gameListTableView.reloadData()
       
    }
    
    @IBAction func unwindToAddGame(segue: UIStoryboardSegue) {}


    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    // Do any additional setup after loading the view, typically from a nib.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //This allows us to return an array of actions that the row will have (if any)
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, _ in
            //Remove the game at the current index from our game array
            GameManager.sharedInstance.removeGame(at: indexPath.row)
            //Delete the row from the table view at the current index path
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let gameForIndex = GameManager.sharedInstance.getGame(at: indexPath.row)
        let title = gameForIndex.checkedIn ? "Check Out" : "Check In"
        
        let checkOutOrInAction = UITableViewRowAction(style: .normal, title: title) { _, _ in
            GameManager.sharedInstance.checkGameInOrOut(at: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        
        let showEditScreenAction = UITableViewRowAction(style: .normal, title: "Edit") { _, _ in
            self.selectedGame = GameManager.sharedInstance.getGame(at: indexPath.row)
            self.performSegue(withIdentifier: "EditGame", sender: self)
        }
        
        showEditScreenAction.backgroundColor = UIColor.purple
        
        return [deleteAction, checkOutOrInAction, showEditScreenAction]
    }
    
    


}

