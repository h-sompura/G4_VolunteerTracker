//
//  HistoryViewController.swift
//  G4_VolunteerTracker
//
//  Created by som on 21/05/22.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //get the coreDb singleton
    private let dbHelper = CoreDbHelper.getInstance()
    private var volunteerList : [Volunteer] = [Volunteer]()
    
    //MARK: User Defaults
    var defaults: UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var historyTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        historyTable.delegate = self
        historyTable.dataSource = self
        
//        self.fetchAllVolunteers()
        
        //Add signout to nav bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(
          title: "Sign Out", style: .plain, target: self, action: #selector(signOutPressed))
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

//    need to have user
//    private func fetchAllVolunteers(){
//        let data = self.dbHelper.getAllRelatedVolunteers(user: <#T##User#>)()
//        if (data != nil) {
//            self.volunteerList = data!
//            self.historyTable.reloadData()
//        }else{
//            print(#function, "No data received from DB")
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return volunteerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTable.dequeueReusableCell(withIdentifier: "volunteerCell", for: indexPath) as! HistoryTableViewCell
        
        let event = volunteerList[indexPath.row]
        cell.lblName.text = event.event?.name
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        cell.lblDate.text = dateFormatter.string(from: (event.event?.date)!)
        
        cell.lblHours.text = "\(event.hours)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let volunteeredView = storyboard?.instantiateViewController(identifier: "volunteeredView") as? VolunteeredViewController else {
            print("Cannot find next screen")
            return
        }
        
        volunteeredView.volunteeredEvent = volunteerList[indexPath.row]
        self.navigationController?.pushViewController(volunteeredView, animated: true)
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
