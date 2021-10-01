//
//  GameViewController.swift
//  PictureGuess
//
//  Created by Rakolcza Peter on 2021. 09. 30..
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var pictureView: UIImageView!
    
    private var correctAnswer = -1
    private var baseImage: UIImage?
    var difficultyFactor: CGFloat = 1
    
    override func viewDidLoad() {
      super.viewDidLoad()

      let pictureManager = (UIApplication.shared.delegate as? AppDelegate)?.pictureManager
      var titles = [String]()

      pictureManager?.getRandomPicture(&baseImage, titles: &titles, pictureTitleIndex: &correctAnswer)

      for index in 1...titles.count {
        let button = view.viewWithTag(index) as? UIButton
        button?.setTitle(titles[index - 1], for: .normal)
      }

      if let baseImage = baseImage {
        let cropSize = CGSize(width: 300 / difficultyFactor, height: 200 / difficultyFactor)
        let cropRect = CGRect(x:CGFloat(Int(arc4random()) % Int(baseImage.size.width - cropSize.width)),
                              y:CGFloat(Int(arc4random()) % Int(baseImage.size.height - cropSize.height)),
                              width:cropSize.width * baseImage.scale,
                              height:cropSize.height * baseImage.scale)
        let croppedImageRef = baseImage.cgImage!.cropping(to: cropRect)
        let croppedImage = UIImage(cgImage: croppedImageRef!, scale: baseImage.scale, orientation: baseImage.imageOrientation)
        pictureView.image = croppedImage
      }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let button = sender as? UIButton {

        let resultViewController = segue.destination as! ResultsViewController
        resultViewController.picture = baseImage
          let pictureManager = (UIApplication.shared.delegate as? AppDelegate)?.pictureManager

        if button.tag - 1 == correctAnswer {
          resultViewController.caption = "Talált! Ez egy \(button.titleLabel!.text!.lowercased())."
            pictureManager?.correctAnswerCount += 1
        }
        else {
          let correctButton = view.viewWithTag(correctAnswer + 1) as! UIButton
          resultViewController.caption = "Sajnos nem talált! Ez egy \(correctButton.titleLabel!.text!.lowercased())."
            pictureManager?.wrongAnswerCount += 1
        }
      }
    }
}
