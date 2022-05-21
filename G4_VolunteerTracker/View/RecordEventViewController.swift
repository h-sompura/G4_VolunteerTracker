//
//  RecordEventViewController.swift
//  G4_VolunteerTracker
//
//  Created by som on 21/05/22.
//

import UIKit
import CoreLocation

class RecordEventViewController: UIViewController, CLLocationManagerDelegate {
    
    //get the coreDb singleton
    private let dbHelper = CoreDbHelper.getInstance()
    
    //MARK: User Defaults
    var defaults: UserDefaults = UserDefaults.standard
    
    //MARK: Variables
    var locationManager: CLLocationManager!
    
    //MARK: Outlets
    @IBOutlet weak var btnGetCurrentLocation: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        //Add signout to nav bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(
          title: "Sign Out", style: .plain, target: self, action: #selector(signOutPressed))
    }
    
    @IBAction func getUserLocationPressed(_ sender: Any) {
        // request the user's location
        self.locationManager.startUpdatingLocation()
        print("Getting user locations....")
        // TODO: Disable the button so it can't be pressed again
        
        btnGetCurrentLocation.isEnabled = false
    }
    
    
    // this function wil run EVERY time the user location changes/update
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Received a location!")
        
        if let lastKnownLocation =  locations.first {
            let lat = lastKnownLocation.coordinate.latitude
            let lng = lastKnownLocation.coordinate.longitude
            print("Current location: \(lat), \(lng), current speed: \(lastKnownLocation.speed)")
        }
    }
    
    
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
