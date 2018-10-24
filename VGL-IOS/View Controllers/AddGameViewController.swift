//
//  AddGameViewController.swift
//  VGL-IOS
//
//  Created by Brian Sadler on 10/16/18.
//  Copyright © 2018 Brian Sadler. All rights reserved.
//

import UIKit

class AddGameViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    // Outlets
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var gameTitleTextField: UITextField!
    @IBOutlet weak var gameRatingSelection: UISegmentedControl!
    @IBOutlet weak var genre: UIPickerView!
    @IBOutlet weak var gameDescriptionTextField: UITextField!
   
    //genre array for picker
    let genres = ["Shooter", "RPG", "Strategy"]
    
    func showErrorAlert() {
        let alertController = UIAlertController(title: "Error", message: "You must enter a title and description for the game.", preferredStyle: .actionSheet)
        let closeAction = UIAlertAction(title: "Close", style: .default) { _ in
            self.gameTitleTextField.text = ""
            self.gameDescriptionTextField.text = ""
        }
        alertController.addAction(closeAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let title = gameTitleTextField.text, title.trimmingCharacters(in: .whitespacesAndNewlines) != "", let gameDescription = gameDescriptionTextField.text, gameDescription.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {
            //Show an error and return
            return showErrorAlert()
            
        }
        
        var rating: String!
        
        switch gameRatingSelection.selectedSegmentIndex {
        case 0:
            rating = "E"
        case 1:
            rating = "E10+"
        case 2:
            rating = "T"
        case 3:
            rating = "M"
        case 4:
            rating = "AO"
        default:
            rating = "E"
        }
        
        let genre = genres[self.genre.selectedRow(inComponent: 0)]
       
        // Default init for game class
        let newGame = VideoGame()
        
        //Setting the properties for the new game using dot notation
        newGame.title = title
        newGame.gameDescription = gameDescription
        newGame.genre = genre
        newGame.rating = rating
        GameManager.sharedInstance.addGame(game: newGame)
        
        self.performSegue(withIdentifier: "unwindToAddGame", sender: self)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres[row]
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
        
       
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
