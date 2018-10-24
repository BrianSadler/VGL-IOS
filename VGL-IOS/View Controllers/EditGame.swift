//
//  EditGame.swift
//  VGL-IOS
//
//  Created by Brian Sadler on 10/21/18.
//  Copyright © 2018 Brian Sadler. All rights reserved.
//

import UIKit
import RealmSwift

class EditGame: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Outlets
    @IBOutlet weak var editGameTitle: UITextField!
    
    @IBOutlet weak var editGameDescription: UITextView!
    
    @IBOutlet weak var editGameGenre: UIPickerView!
    
    @IBOutlet weak var editGameRating: UISegmentedControl!
    
    // Variables and constants
    var gameToEdit: VideoGame!
    var rating = ""
    let editPickerData: [String] = ["Shooter", "RPG", "Strategy"]
    


    override func viewDidLoad() {
        super.viewDidLoad()
      
        //pull the title of the game you selected
        editGameTitle.text = gameToEdit.title
        
        //pull the description of the game that they selected
        editGameDescription.text = gameToEdit.gameDescription
        
        
        //select the rating of the game selected to edit
        switch gameToEdit.rating {
        case "E":
            editGameRating.selectedSegmentIndex = 0
        case "E10+":
            editGameRating.selectedSegmentIndex = 1
        case "T":
            editGameRating.selectedSegmentIndex = 2
        case "M":
            editGameRating.selectedSegmentIndex = 3
        case "AO":
            editGameRating.selectedSegmentIndex = 4
        default:
            editGameRating.selectedSegmentIndex = 0
        }
        
        //select the genre of the game selected game to edit
        switch gameToEdit.genre {
        case "Shooter":
            editGameGenre.selectRow(0, inComponent: 0, animated: false)
        case "RPG":
            editGameGenre.selectRow(1, inComponent: 0, animated: false)
        case "Strategy":
            editGameGenre.selectRow(2, inComponent: 0, animated: false)
        default:
            editGameGenre.selectRow(0, inComponent: 0, animated: false)
        }
        // Do any additional setup after loading the view.
    }
    
    //this function is for the number of rows in your picker view. example is a date would have 3 rows.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //this puts your genre array in the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return editPickerData.count
    }
    
    //this chooses the specific row you want to use
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return editPickerData[row]
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        //this checks to make sure there is data in the text fields
        guard let title = editGameTitle.text,
            title.trimmingCharacters(in: .whitespacesAndNewlines) != "",
            let gameDescription = editGameDescription.text,
            gameDescription.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {
                //show an error and return
                errors()
                return
                
                
                
        }
     
        
        let realm = try! Realm()
        
        try! realm.write {
            gameToEdit.title = title
            gameToEdit.gameDescription = gameDescription
            gameToEdit.genre = editPickerData[editGameGenre.selectedRow(inComponent: 0)]
            
            //The rating for the edited game
            let editedRating = editGameRating.selectedSegmentIndex
            
            switch editedRating {
            case 0:
                gameToEdit.rating = "E"
            case 1:
                gameToEdit.rating = "E10+"
            case 2:
                gameToEdit.rating = "T"
            case 3:
                gameToEdit.rating = "M"
            case 4:
                gameToEdit.rating = "AO"
            default:
                gameToEdit.rating = "E"
            }
        
        }
        edited()
    
    }
    
    func errors() {
        //UIAlert controller
        let errorAlert = UIAlertController(title: "Error", message: "All Fields not filled out. Please fill out all of the fields to edit this game.", preferredStyle: .alert)
        
        //UIAlertAction
        let closeAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        
        //add the action in the alert controller
        errorAlert.addAction(closeAction)
        
        //present alert controller
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    //when submit button tapped it will take you back to the main screen.
    func edited() {
        //UIAlertController
        let editedAlert = UIAlertController(title: "Edited Game", message: "You edited \(gameToEdit.title)", preferredStyle: .alert)
        
        //UIAlertAction
        let closeAction2 = UIAlertAction(title: "Close", style: .default) { _ in
            //segue back to home 
            self.performSegue(withIdentifier: "unwindToGameLIst", sender: self)
        }
        
        //add action in the alert controller
        editedAlert.addAction(closeAction2)
        
        //present alert controller
        self.present(editedAlert, animated: true, completion: nil)
    }
    
   
  
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


