//
//  NewsfeedViewController.swift
//  G4_VolunteerTracker
//
//  Created by som on 21/05/22.
//

import UIKit

class NewsfeedViewController: UIViewController {
    
    //get the coreDb singleton
    private let dbHelper = CoreDbHelper.getInstance()
    
    //MARK: User Defaults
    var defaults: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Add signout to nav bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(
          title: "Sign Out", style: .plain, target: self, action: #selector(signOutPressed))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc private func signOutPressed() {
      //set remember me to false
      self.defaults.set(false, forKey: "KEY_REMEMBER_USER")

      // go to log in screen
      // - try to get a reference to the next screen
      guard let nextScreen = storyboard?.instantiateViewController(identifier: "loginScreen") else {
        print("Cannot find next screen")
        return
      }
      nextScreen.modalPresentationStyle = .fullScreen  //changing next screen to full screen here

      // - navigate to the next screen
      self.present(nextScreen, animated: true, completion: nil)
    }

}
