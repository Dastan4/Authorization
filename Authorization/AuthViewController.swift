//
//  AuthViewController.swift
//  Authorization
//
//  Created by Dastan Mambetaliev on 17/4/21.
//
import Firebase
import UIKit

class AuthViewController: UIViewController {

    var signup: Bool = true {
        willSet {
            if newValue {
                titleLabel.text = "Registration"
                nameField.isHidden = false
                enterButton.setTitle("Sign in", for: .normal)
            }else{
                titleLabel.text = "Login"
                nameField.isHidden = true
                enterButton.setTitle("Registration", for: .normal)
            }
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
    }

    @IBAction func switchLogin(_ sender: Any) {
        signup = !signup
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Ошибка", message: "Все поля должны быть заполнены", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension AuthViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let name = nameField.text!
        let email = emailField.text!
        let password = passwordField.text!
        
        if(signup){
            if(!name.isEmpty && !email.isEmpty && !password.isEmpty){
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if error == nil{
                        if let result = result{
                            print(result.user.uid)
//                            добавление в базу Realtime Database
                            let ref = Database.database().reference().child("users")
                            ref.child(result.user.uid).updateChildValues(["name" : name, "email": email])
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }else{
                showAlert()
            }
        }else{
            if(!email.isEmpty && !password.isEmpty){
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    if error == nil{
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }else{
                showAlert()
            }
        }
            
        
        return true
    }
}
