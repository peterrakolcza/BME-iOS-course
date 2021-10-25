//
//  NameViewController.swift
//  iNames
//
//  Created by Rakolcza Peter on 2021. 10. 23..
//

import UIKit

class NameViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    var nameToDisplay: [NSString: NSString]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if nameToDisplay == nil {
            nameToDisplay = NameHandler.shared.names!.first as? [NSString:NSString]
        }
        let name = nameToDisplay!["name"]
        titleLabel.text = "\(name!) napja van."
        
        let detailsButton = UIBarButtonItem(title: "Tények", style: .plain, target: self, action: #selector(NameViewController.displayFacts(sender:)))
        navigationItem.rightBarButtonItem = detailsButton
    }
    
    @objc func displayFacts(sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let contentViewController = storyboard.instantiateViewController(withIdentifier: "FactsViewController") as! NameFactsViewController
        contentViewController.nameToDisplay = nameToDisplay
        contentViewController.modalPresentationStyle = .popover
        let detailPopover = contentViewController.popoverPresentationController!
        detailPopover.barButtonItem = sender
        detailPopover.permittedArrowDirections = .any
        present(contentViewController, animated: true, completion: nil)
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

extension NameViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
