//
//  SignInViewController.swift
//  FakeSnapChat
//
//  Created by Michael Zhou on 2018-07-04.
//  Copyright © 2018 Michael Zhou. All rights reserved.
//

import UIKit
import Firebase


class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWdTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func loginButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passWdTextField.text!) { (user, error) in
            print("Attempting to sign in..")
            if error != nil {
                print("Error signing in!")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passWdTextField.text!, completion: { (user, error) in
                    print("Tried to create user!")
                        if error != nil {
                        print("We have an error!")
                        } else {
                        print("Created user successfully")
                        self.performSegue(withIdentifier: "signInSegue", sender: nil)
                    }
                })
            } else {
                print("Signed in!")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

