//
//  PathFind.m
//  MapKitCoreLocation
//
//  Created by nguyenvantu on 1/15/16.
//  Copyright © 2015 nguyenvantu. All rights reserved.
//

import MapKit
import AddressBookUI
import UIKit
class PathFind: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate {
    @IBOutlet weak var mapView: MKMapView!// hiển thị bản đồ
    var fromLocation: CLLocation? // lưu toạ độ của một địa điểm với độ chính xác cao.
    let locationManager = CLLocationManager()//NSLocationWhenInUseUsageDescription
    //class này là một lớp rất quan trọng cung cấp các tham số để cấu hình phục vụ cho việc cập nhật toạ độ người dùng...
    var overlay: MKOverlay? //vẽ đường đi
    var direction: MKDirections? // cung cấp tuyến đường đi từ Apple service
    var foundPlace: CLPlacemark? // đại diện cho dữ liệu của một địa điểm có thể bao gồm tên quốc gia, thành phố, tên đường....
    var geoCoder: CLGeocoder? //thực hiện chuyển đổi kiển string sang kiểu CLPlacemark để lưu thông tin về địa điểm
    
    var foundIndicator: UIImageView?
    
    var toAnnotation: LocationAnnotation? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge()
        self.navigationController!.navigationBar.shadowImage = nil
        self.navigationController!.navigationBar.isTranslucent = false
        self.mapView.delegate = self
        self.foundIndicator = UIImageView(image: UIImage(named: "red"))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.foundIndicator!)
        
        self.geoCoder = CLGeocoder()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest //thông tin chính xác về địa điểm người dùng càng chi tiết thì càng tốn tài nguyên của máy bạn
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
//        self.mapView.showsUserLocation = true
        
    }
    
    //Delegate uitextfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (overlay != nil)
        {
            self.mapView.remove(overlay!)
            self.mapView.removeAnnotation(toAnnotation!)
        }
        lookForAddress(textField.text! as NSString)
        return true
    }
    func lookForAddress(_ addressString: NSString)
    {
        if (addressString == "")
        {
            return
        }
        self.geoCoder?.geocodeAddressString(addressString as String, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                self.updateFoundIndicator(false)
            }
            else {
                self.foundPlace = placemarks!.first
                self.updateFoundIndicator(true)
                let toPlace: MKPlacemark = MKPlacemark(placemark: self.foundPlace!)
                self.routePath(MKPlacemark(coordinate: self.fromLocation!.coordinate, addressDictionary: nil), toLocation: toPlace)
            }
        })
    }
    
    // MARK: - Location Delegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        self.locationManager.stopUpdatingLocation()
        let location = locations.last
        self.fromLocation = location
        self.updateRegion(2.0)
        
        //add annotation
        let annotation = LocationAnnotation(coordinate: location!.coordinate,
                                            title: "Techmaster",
                                            image: "green")
        
        self.mapView.addAnnotation(annotation)
    }
    func updateRegion(_ scale: Float) {
        let size: CGSize = self.mapView.bounds.size
        let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(fromLocation!.coordinate, Double(Float(size.height) * scale), Double(Float(size.width) * scale))
        self.mapView.setRegion(region, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error: " + error.localizedDescription)
    }
    
    func updateFoundIndicator(_ found: Bool) {
        if found {
            self.foundIndicator!.image = UIImage(named: "green")
        }
        else {
            self.foundIndicator!.image = UIImage(named: "red")
        }
    }
    
    
    func routePath(_ fromPlace: MKPlacemark, toLocation toPlace: MKPlacemark) {
        let request: MKDirectionsRequest = MKDirectionsRequest()
        let fromMapItem: MKMapItem = MKMapItem(placemark: fromPlace)
        request.source = fromMapItem
        let toMapItem: MKMapItem = MKMapItem(placemark: toPlace)
        request.destination = toMapItem
        self.direction = MKDirections(request: request)
        self.direction!.calculate { (response, error) -> Void in
            if (error != nil) {
                NSLog("Error %@", error!.localizedDescription)
            }
            else {
                self.mapSetRegion(fromPlace.coordinate, and: toPlace.coordinate)
                self.showRoute(response!)
            }
        }
    }
    func showRoute(_ response: MKDirectionsResponse) {
        toAnnotation = LocationAnnotation(coordinate: foundPlace!.location!.coordinate,
                                          title: "Tên khách sạn",
                                          image: "green")
        
        self.mapView.addAnnotation(toAnnotation!)
        for route: MKRoute in response.routes {
            self.overlay = route.polyline
            self.mapView.add(overlay!, level: .aboveRoads)
            for step: MKRouteStep in route.steps {
                NSLog("%@", step.instructions)
            }
        }
    }
    func mapSetRegion(_ fromPoint: CLLocationCoordinate2D, and toPoint: CLLocationCoordinate2D) {
        let centerPoint: CLLocationCoordinate2D = CLLocationCoordinate2DMake((fromPoint.latitude + toPoint.latitude) / 2.0, (fromPoint.longitude + toPoint.longitude) / 2.0)
        let latitudeDelta: Double = abs(fromPoint.latitude - toPoint.latitude) * 1.5
        let longtitudeDelta: Double = abs(fromPoint.longitude - toPoint.longitude) * 1.5
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longtitudeDelta)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(centerPoint, span)
        self.mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer: MKPolylineRenderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
        }
        
        
        annotationView?.annotation = annotation
        
        let viewDetail = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        let labelName = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        labelName.numberOfLines = 0
        labelName.text = "Lập trình viên IOS"
        labelName.textAlignment = .center
        let imgView = UIImageView(frame: CGRect(x: 0, y: 20, width: 200, height: 180))
        imgView.image = UIImage(named: "img1.png")
        viewDetail.addSubview(labelName)
        viewDetail.addSubview(imgView)
        
        
        
        let widthConstraint = NSLayoutConstraint(item: viewDetail, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        viewDetail.addConstraint(widthConstraint)
        
        let heightConstraint = NSLayoutConstraint(item: viewDetail, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        viewDetail.addConstraint(heightConstraint)
        
        annotationView?.detailCalloutAccessoryView = viewDetail
        annotationView!.image = UIImage(named:"logo")
        annotationView?.canShowCallout = true
        return annotationView
    }
}
