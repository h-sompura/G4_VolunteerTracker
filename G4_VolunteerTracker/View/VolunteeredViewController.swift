//
//  VolunteeredViewController.swift
//  G4_VolunteerTracker
//
//  Created by Sadaf Asadollahi on 2022-05-23.
//

import UIKit

class VolunteeredViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblOrganization: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblFinishTime: UILabel!
    @IBOutlet weak var lblVolunteerLocation: UILabel!
    @IBOutlet weak var lblVolunteerHours: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var eventIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
