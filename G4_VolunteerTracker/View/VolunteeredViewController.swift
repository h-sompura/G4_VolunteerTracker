//
//  VolunteeredViewController.swift
//  G4_VolunteerTracker
//
//  Created by Sadaf Asadollahi on 2022-05-23.
//

import UIKit
import CoreLocation

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
    
    var volunteeredEvent: Volunteer = Volunteer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadLables()
    }
    
    func loadLables() {
        lblName.text = volunteeredEvent.event?.name
        lblInfo.text = volunteeredEvent.event?.info
        lblOrganization.text = volunteeredEvent.event?.organization
        lblLocation.text = volunteeredEvent.event?.location
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        lblDate.text = dateFormatter.string(from: (volunteeredEvent.event?.date)!)
        
        dateFormatter.timeStyle = .short
        lblStartTime.text = dateFormatter.string(from: (volunteeredEvent.event?.start_time)!)
        
        dateFormatter.timeStyle = .short
        lblFinishTime.text = dateFormatter.string(from: (volunteeredEvent.event?.end_time)!)
        
        let geocoder = CLGeocoder()
        let locationToFind = CLLocation(latitude: volunteeredEvent.latitude, longitude: volunteeredEvent.longitude)
        geocoder.reverseGeocodeLocation(locationToFind) {
            (resultsList, error) in
            if let err = error {
                print("Error during the reverse geocoding")
                return
            } else {
                print("Matching location found: \(resultsList!.count)")
                let locationResult:CLPlacemark = resultsList!.first!
                print(locationResult)

                print("Getting location data:")
                let name = locationResult.name ?? "NA"
                let street = locationResult.thoroughfare ?? "NA"
                let city = locationResult.locality ?? "NA"

                self.lblVolunteerLocation.text = name + ", " + street + ", " + city + ", "
            }
        }
                        

        lblVolunteerHours.text = ("\(volunteeredEvent.hours)")
//        picture
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
