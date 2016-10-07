//
//  PathFind.swift
//  MapKipSimple
//
//  Created by Tuuu on 8/22/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit
import MapKit
class PathFind: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var fromLocation: CLLocation!
    var locationManager = CLLocationManager() // NSLocationWhenInUseUsageDescription
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        self.fromLocation = locations.last
        self.updateRegion(2.0)
    }
    
    func updateRegion(_ scale: CGFloat)
    {
        let size: CGSize = self.mapView.bounds.size
        let region = MKCoordinateRegionMakeWithDistance(fromLocation!.coordinate, Double(size.height * scale), Double(size.width * scale))
        self.mapView.setRegion(region, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    

}
