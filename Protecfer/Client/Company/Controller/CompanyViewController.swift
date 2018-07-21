//
//  CompanyViewController.swift
//  Protecfer
//
//  Created by cyrine on 13/02/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CompanyViewController: UIViewController {

    var companyRepository = CompanyRepository()
    var geocoder = CLGeocoder()
    
    @IBOutlet weak var viewOpenDay: BorderView!
    @IBOutlet weak var adressMapKit: MKMapView!
    var company =  Company()
    
    @IBOutlet weak var openHourView: BorderView!
    @IBOutlet weak var telephoneView: BorderView!
    @IBOutlet weak var addressView: BorderView!
    
    @IBOutlet weak var hourOpenLabel: UILabel!
    @IBOutlet weak var openDayLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var telephoneNumberLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.openHourView.addBorders(edges: [.left,.right,.top], color: .gray)
         self.telephoneView.addBorders(edges: [.right,.top], color: .gray)
         self.viewOpenDay.addBorders(edges: [.left,.top], color: .gray)
         self.addressView.addBorders(edges: [.all], color: .gray)
        
        companyRepository.getCompany {
            company in
            self.company = company
            self.setInformationCompanyView()
            //let address = "Tunisie," + (self.company.address?.city)! + "," + (self.company.address?.street)!
            
            /*self.geocoder.geocodeAddressString(address) {
                placemarks, error in
                let placemark = placemarks?.first
                let lat = placemark?.location?.coordinate.latitude
                let lon = placemark?.location?.coordinate.longitude
                
                if let longitude = lon, let latitude = lat
                {*/
            self.SetPointAnnotation(latitude: (self.company.address?.latitude)!, longitude: (self.company.address?.longitude!)!)
                   
                /*}
               
            }*/
           
            
        }
    }
    
    func setInformationCompanyView() {
        hourOpenLabel.text = "De " + company.openTime!  + " à " + company.closeTime!
        openDayLabel.text =  "De " + company.beginOpenDay! + " à " + company.endOpenDay!
        telephoneNumberLabel.text = company.telephoneNumber
        adressLabel.text = company.address?.city
    }
    
    func SetPointAnnotation (latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocationCoordinate2D(latitude: latitude,
                                              longitude: longitude)
        // 2
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        self.adressMapKit.setRegion(region, animated: true)
        //3
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Protecfer"
        self.adressMapKit.addAnnotation(annotation)
    }

   



}
