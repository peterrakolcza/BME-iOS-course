//
//  ViewController.swift
//  iCalculator
//
//  Created by Rakolcza Peter on 2021. 09. 23..
//

import UIKit


class ViewController: UIViewController {
    enum OperationType {
      case add
      case multiply
      case divide
    }
    
    private var operationType = OperationType.add
    
    @IBOutlet weak var inputA: UITextField!
    @IBOutlet weak var inputB: UITextField!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var historyView: UITextView!
    @IBOutlet weak var operationSelector: UISegmentedControl!
    @IBAction func calculateButtonTouchUpInside(_ sender: Any) {
        if let textA = inputA.text, let textB = inputB.text, let a = NumberFormatter().number(from: textA)?.doubleValue,
           let b = Double(textB) {
            switch operationType {
            case .add:
                result.text = "\(a+b)"
                break
            case .multiply:
                result.text = "\(a*b)"
                break
            case .divide:
                result.text = "\(a/b)"
                break
            }
        }
        
        if let position = historyView.textRange(from: historyView.beginningOfDocument, to: historyView.beginningOfDocument) {
            historyView.replace(position, withText: "\(inputA.text!) \(operationSelector.titleForSegment(at: operationSelector.selectedSegmentIndex)!) \(inputB.text!) = \(result.text!)\n")
        }
        
        //inputA.resignFirstResponder()
        //inputB.resignFirstResponder()
        
        view.endEditing(true)
    }
    @IBAction func backgroundTouchUpInside(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func operationSelectorValueChanged(_ sender: Any) {
        switch operationSelector.selectedSegmentIndex {
          case 0:
            operationType = .add
          case 1:
            operationType = .multiply
          case 2:
            operationType = .divide
          default:
            return
          }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        operationSelector.selectedSegmentIndex = 0
        historyView.text = ""
    }


}

