//
//  GameSelectorViewController.swift
//  PictureGuess
//
//  Created by Rakolcza Peter on 2021. 09. 30..
//

import UIKit

class GameSelectorViewController: UIViewController {
    override func viewDidLoad() {
      super.viewDidLoad()
    }
    @IBAction func unwindToGameSelector(_ segue: UIStoryboardSegue)  {}
    @IBOutlet weak var difficultySegmentedControl: UISegmentedControl!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let gameViewController = segue.destination as? GameViewController
      gameViewController?.difficultyFactor = CGFloat(difficultySegmentedControl.selectedSegmentIndex + 1)
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
