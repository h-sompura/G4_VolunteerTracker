//
//  RegisterViewController.swift
//  G4_VolunteerTracker
//
//  Created by Sadaf Asadollahi on 2022-05-22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //get the coreDb singleton
    private let dbHelper = CoreDbHelper.getInstance()
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblOrganization: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblFinishTime: UILabel!
    
    var event: Event = Event()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadLbls()
    }
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        // should have user
        // create new volunteer with event and user
//        dbHelper.createVolunteer(user: <#T##User#>, event: <#T##Event#>)
//        needs to go back to the Newsfeed Screen
    }

    private func loadLbls() {
        lblName.text = event.name
        lblInfo.text = event.info
        lblOrganization.text = event.organization
        lblLocation.text = event.location
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        lblDate.text = dateFormatter.string(from: event.date!)
        
        dateFormatter.timeStyle = .short
        lblStartTime.text = dateFormatter.string(from: event.start_time!)
        
        dateFormatter.timeStyle = .short
        lblFinishTime.text = dateFormatter.string(from: event.end_time!)
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
