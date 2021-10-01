//
//  StatsViewController.swift
//  PictureGuess
//
//  Created by Rakolcza Peter on 2021. 10. 01..
//

import UIKit

class StatsViewController: UIViewController {
    @IBOutlet weak var queriedPicturesCountLabel: UILabel!
    @IBOutlet weak var correctAnswerCountLabel: UILabel!
    @IBOutlet weak var wrongAnswerCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)

      let pictureManager = (UIApplication.shared.delegate as? AppDelegate)?.pictureManager

      queriedPicturesCountLabel.text = "\(pictureManager!.picturesQueriedCount)"
      correctAnswerCountLabel.text = "\(pictureManager!.correctAnswerCount)"
      wrongAnswerCountLabel.text = "\(pictureManager!.wrongAnswerCount)"
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
