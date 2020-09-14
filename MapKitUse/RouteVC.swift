//
//  RouteVC.swift
//  MapKitUse
//
//  Created by Munseok Park on 2020/09/13.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit
import MapKit

class RouteVC: UIViewController {
    var destination: MKMapItem?
    
    var locationManager: CLLocationManager = CLLocationManager()
    var userLocation: CLLocation?
    
    let distance: CLLocationDistance = 650
    let pitch: CGFloat = 65
    let heading = 0.0
    var camera: MKMapCamera?


    @IBOutlet weak var routeMap: MKMapView!
    
    @IBAction func animateCamera(_ sender: Any) {
        UIView.animate(withDuration: 20, animations: {
        self.camera!.heading += 100
        self.camera!.pitch = 25
        self.routeMap.camera = self.camera!
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routeMap.delegate = self
        routeMap.showsUserLocation = true
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestLocation()
        
        routeMap.mapType = .hybridFlyover
        
        var coordinate : CLLocationCoordinate2D?
        if userLocation != nil{
            coordinate = userLocation!.coordinate
        }else{
            coordinate = CLLocationCoordinate2D.init(latitude: 37.4, longitude: 127.027621)
        }
        
        camera = MKMapCamera.init(lookingAtCenter: coordinate!, fromDistance: distance, pitch: pitch, heading: heading)
        routeMap.camera = camera!

        
    }
    
}

extension RouteVC : MKMapViewDelegate,CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        userLocation = locations[0]
        self.getDirections()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor
        overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }
    func showRoute(_ response: MKDirections.Response) {
        for route in response.routes {
            routeMap.addOverlay(route.polyline,
                                level: MKOverlayLevel.aboveRoads)
            for step in route.steps {
                print(step.instructions)
            }
        }
        
        if let coordinate = userLocation?.coordinate {
            let region =
                MKCoordinateRegion(center:coordinate,
                                   latitudinalMeters:2000, longitudinalMeters:2000)
            routeMap.setRegion(region, animated: true)
        }
    }
    func getDirections() {
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        
        if let destination = destination {
            request.destination = destination
        }
        
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        directions.calculate(completionHandler: {(response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let response = response {
                    self.showRoute(response)
                }
            }
        })
    }
}
