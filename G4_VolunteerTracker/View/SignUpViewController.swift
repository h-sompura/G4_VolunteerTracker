//
//  SignUpViewController.swift
//  G4_VolunteerTracker
//
//  Created by som on 21/05/22.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //get the coreDb singleton
    private let dbHelper = CoreDbHelper.getInstance()
    
    //MARK: Variables
    
    //MARK: Outlets
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var txtNameField: UITextField!
    @IBOutlet weak var txtEmailField: UITextField!
    @IBOutlet weak var txtPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(#function, "Signup Screen Loaded!")
        
        //clearing the error label on load
        lblError.text = ""
    }
    
    //MARK: Actions
    @IBAction func loginButtonPressed(_ sender: Any) {
        print(#function, "Login Button Pressed!")
        
        //navigate to login screen
        guard let nextScreen = storyboard?.instantiateViewController(identifier: "loginScreen")
        else {
          print("Cannot find next screen")
          return
        }
        // - navigate to the next screen
        nextScreen.modalPresentationStyle = .fullScreen  //changing to full screen here
        self.present(nextScreen, animated: true, completion: nil)
    }
    
    @IBAction func signupButtonPressed(_ sender: Any) {
        
        //1. Get user name
        guard let nameFromUI = txtNameField.text, nameFromUI.isEmpty == false
        else {
          lblError.text = "Please enter a valid name"
          lblError.textColor = UIColor.orange
          //before return, clear the field
          txtNameField.text = ""
          return
        }
        
        //2. Get the user email
        guard let emailFromUI = txtEmailField.text, emailFromUI.isEmpty == false
        else {
          lblError.text = "Please enter a valid email"
          lblError.textColor = UIColor.orange
          //before return, clear the field
          txtNameField.text = ""
          txtEmailField.text = ""
          return
        }
        
        //3. Get the password
        guard let passwordFromUI = txtPasswordField.text, passwordFromUI.isEmpty == false
        else {
          lblError.text = "Please enter a valid password"
          lblError.textColor = UIColor.orange
          //before return, clear the field
          txtNameField.text = ""
          txtEmailField.text = ""
          txtPasswordField.text = ""
          return
        }
        
        //if we reached this point, user has entered all the data required for signup
        //Searching if user already exists in coredata
        let searchUserInCoreData = self.dbHelper.searchUser(email: emailFromUI)
        if(searchUserInCoreData == nil){
            //user doesn't exist in our coredata
            //so, we create a user in the coredata
            self.dbHelper.createUser(name: nameFromUI, email: emailFromUI, password: passwordFromUI)
            
            //lastly we can clear all the fields
            txtNameField.text = ""
            txtEmailField.text = ""
            txtPasswordField.text = ""
            lblError.text = "Successfully created a user, logging in!"
            lblError.textColor = UIColor.green
            
            //go to login screen after signup is successful
            //navigate to login screen
            guard let nextScreen = storyboard?.instantiateViewController(identifier: "loginScreen")
            else {
              print("Cannot find next screen")
              return
            }
            // - navigate to the next screen
            nextScreen.modalPresentationStyle = .fullScreen  //changing to full screen here
            self.present(nextScreen, animated: true, completion: nil)
            
        } else {
            //user exists so we can't sign them up
            print(#function,"user already exists")
            // ask them to log in
            txtNameField.text = ""
            txtEmailField.text = ""
            txtPasswordField.text = ""
            lblError.text = "This email already exists, log in!"
            lblError.textColor = UIColor.red
        }   
      
    }
    
}
