//
//  ViewController.swift
//  Authorization
//
//  Created by Dastan Mambetaliev on 16/4/21.
//
import Firebase
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func logoutAction(_ sender: Any) {
        do{
            try Auth.auth().signOut()
        }catch{
            print(error)
        }
        
    }
    
}

