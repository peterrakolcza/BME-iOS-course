//
//  ResultViewController.swift
//  PictureGuess
//
//  Created by Rakolcza Peter on 2021. 09. 30..
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    
    var caption: String?
    var picture: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultLabel.text = caption
        pictureView.image = picture
        
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
