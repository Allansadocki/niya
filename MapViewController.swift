//
//  MapViewController.swift
//  NiyaApp
//
//  Created by Allan Sadocki on 27/03/2022.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    private var locationManager: CLLocationManager!
    private var geocoder: CLGeocoder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
    }
    
    @IBAction func didTapLocalisation(_ sender: Any) {
        guard let userLocation = mapView?.userLocation.location else {
            return
        }
        geocoder = CLGeocoder()
        geocoder?.reverseGeocodeLocation(userLocation) { result, error in
            guard let placemark = result?.first else {
                return
            }
            self.presentAdressViewController(placemark: placemark)
        }
    }
    
    private func presentAdressViewController(placemark: CLPlacemark) {
        guard
            let viewController = storyboard?.instantiateViewController(withIdentifier: "AdressViewController"),
            let adressViewController = viewController as? AdressViewController
        else {
            return
        }
        adressViewController.model = placemark
        present(adressViewController, animated: true)
    }
    
}
