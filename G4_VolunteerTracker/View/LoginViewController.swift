//
//  ViewController.swift
//  G4_VolunteerTracker
//
//  Created by som on 21/05/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    //get the coreDb singleton
    private let dbHelper = CoreDbHelper.getInstance()
    
    //MARK: User Defaults
    var defaults: UserDefaults = UserDefaults.standard
    
    //MARK: Variables
    
    //MARK: Outlets
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var txtEmailField: UITextField!
    @IBOutlet weak var txtPasswordField: UITextField!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(#function, "Login Screen Loaded!")
        
        //clearing the error label on load
        lblError.text = ""
    }

    //MARK: Actions
    @IBAction func signupButtonPressed(_ sender: Any) {
        
        print(#function, "Signup Button Pressed!")
        
        //navigate to signup screen
        guard let nextScreen = storyboard?.instantiateViewController(identifier: "signupScreen")
        else {
          print("Cannot find next screen")
          return
        }
        // - navigate to the next screen
        nextScreen.modalPresentationStyle = .fullScreen  //changing to full screen here
        self.present(nextScreen, animated: true, completion: nil)
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        print(#function, "Login Button Pressed!")
        
        //1. Get user email
        guard let emailFromUI = txtEmailField.text, emailFromUI.isEmpty == false
        else {
          lblError.text = "Please enter a valid email"
          lblError.textColor = UIColor.orange
          //before return, clear the field
          txtEmailField.text = ""
          return
        }
        
        //2. Get password
        guard let passwordFromUI = txtPasswordField.text, passwordFromUI.isEmpty == false
        else {
          lblError.text = "Please enter a valid password"
          lblError.textColor = UIColor.orange
          //before return, clear the field
          txtEmailField.text = ""
          txtPasswordField.text = ""
          return
        }
        
        //3. Search/Validate user from the coreData
        let searchUserInCoreData = self.dbHelper.searchUser(email: emailFromUI)
        
        if(searchUserInCoreData == nil){
            //user doesn't exist in our coredata
            //ask them to signup
            lblError.text = "This user doesn't exist, please signup"
            lblError.textColor = UIColor.red
            //before return, clear the field
            txtEmailField.text = ""
            txtPasswordField.text = ""
            return
        } else {
            //user exists
            //check for password combination
            if(searchUserInCoreData?.password == passwordFromUI){
                //password matched
                //go to next screen
                lblError.text = "Successfully logged in!"
                lblError.textColor = UIColor.green
                
                //get remember me switch value
                let isRememberSaved = rememberMeSwitch.isOn
                self.defaults.set(isRememberSaved, forKey: "KEY_REMEMBER_USER")
                
                //move to next screen
                guard let nextScreen = storyboard?.instantiateViewController(identifier: "tabController")
                else {
                  print("Cannot find next screen")
                  return
                }
                
                // - navigate to the next screen
                nextScreen.modalPresentationStyle = .fullScreen  //changing tab controller to full screen here
                self.present(nextScreen, animated: true, completion: nil)
                
            } else {
                //password did not match
                // i.e. incorrect password
                lblError.text = "The email/password combination doesn't match"
                lblError.textColor = UIColor.red
                //before return, clear the field
                txtEmailField.text = ""
                txtPasswordField.text = ""
                return
            }
        }
        
        // lastly we clear all the fields
        txtEmailField.text = ""
        txtPasswordField.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
      print(#function, "Login Screen loaded!")
      //check user login
      let isUserSavedFromUserDefaults: Bool = self.defaults.bool(forKey: "KEY_REMEMBER_USER")
      print("Is user remebered? \(isUserSavedFromUserDefaults)")
      if isUserSavedFromUserDefaults {
        //move onto next screen
        // - try to get a reference to the next screen
        guard let nextScreen = storyboard?.instantiateViewController(identifier: "tabController")
        else {
          print("Cannot find next screen")
          return
        }
        // - navigate to the next screen
        nextScreen.modalPresentationStyle = .fullScreen  //changing tab controller to full screen here

        present(nextScreen, animated: true, completion: nil)
      }
    }
    
}

