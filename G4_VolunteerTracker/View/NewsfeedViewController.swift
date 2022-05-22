//
//  NewsfeedViewController.swift
//  G4_VolunteerTracker
//
//  Created by som on 21/05/22.
//

import UIKit

class NewsfeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //get the coreDb singleton
    private let dbHelper = CoreDbHelper.getInstance()
    private var eventList : [Event] = [Event]()
    
    //MARK: User Defaults
    var defaults: UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var eventsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        eventsTable.delegate = self
        eventsTable.dataSource = self
        
        //Add signout to nav bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(
          title: "Sign Out", style: .plain, target: self, action: #selector(signOutPressed))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventsTable.dequeueReusableCell(withIdentifier: "newEventCell", for: indexPath) as! EventTableViewCell
        
        let event = eventList[indexPath.row]
        cell.lblName.text = event.name
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        cell.lblDate.text = dateFormatter.string(from: event.date!)
        
        dateFormatter.timeStyle = .short
        cell.lblTime.text = dateFormatter.string(from: event.start_time!)
        
        cell.lblLocation.text = event.location
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
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
