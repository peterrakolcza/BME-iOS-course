//
//  LoginViewController.swift
//  labor4
//
//  Created by iOS Student on 2021. 10. 14..
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var saveUsernameSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        saveUsernameSwitch.setOn(UserDefaults.standard.bool(forKey:"usernameSaved"), animated: false)
        if saveUsernameSwitch.isOn {
            usernameTextField.text = UserDefaults.standard.value(forKey:"username") as? String
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Successful login!",message: "Congratulation!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler:nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
        
        UserDefaults.standard.set(saveUsernameSwitch.isOn, forKey:"usernameSaved")
        if saveUsernameSwitch.isOn {
            UserDefaults.standard.set(usernameTextField.text, forKey: "username")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let userInfo = notification.userInfo,
           let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
            if passwordTextField.frame.maxY > (view.frame.height - keyboardSize.height) {
                UIView.animate(withDuration: duration, animations: {
                    self.imageViewTopConstraint.constant = -1 * (self.passwordTextField.frame.maxY - (self.view.frame.height - keyboardSize.height))
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        if let userInfo = notification.userInfo,
           let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
            UIView.animate(withDuration: duration) {
                self.imageViewTopConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func editingDidEndOnExit(_ sender: UITextField) {
        sender.resignFirstResponder()
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
