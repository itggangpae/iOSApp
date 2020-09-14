//
//  ViewController.swift
//  MapKitUse
//
//  Created by Munseok Park on 2020/09/13.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchText: UITextField!
    
    //위치 정보 사용을 위한 인스턴스 생성
    var locationManager: CLLocationManager = CLLocationManager()
    //영역에 대한 정보를 저장할 인스턴스
    var region : CLCircularRegion!
    //쿠폰을 보여줄 이미지 뷰
    var couponView:UIImageView!

    var matchingItems: [MKMapItem] = [MKMapItem]()
    
    func performSearch() {
        // 배열 값 삭제
        matchingItems.removeAll()
        let request = MKLocalSearch.Request()
        // 텍스트 필드의 값으로 초기화된 MKLocalSearchRequest 인스턴스를 생성
        request.naturalLanguageQuery = searchText.text
        request.region = mapView.region
        // 검색 요청 인스턴스에 대한 참조체로 초기화
        let search = MKLocalSearch(request: request)
        // MKLocalSearchCompletionHandler 메서드가 호출되면서 검색이 시작
        search.start(completionHandler: {(response: MKLocalSearch.Response!, error: Error!) in
            if error != nil {
                print("Error occured in search: \(error.localizedDescription)")
            } else if response.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("Matches found")
                for item in response.mapItems as [MKMapItem] {
                    if item.name != nil {
                        print("Name = \(item.name!)")
                    }
                    if item.phoneNumber != nil {
                        print("Phone = \(item.phoneNumber!)")
                    }
                    
                    self.matchingItems.append(item as MKMapItem)
                    print("Matching items = \(self.matchingItems.count)")
                    // 맵에 표시할 어노테이션 생성
                    let annotation = MKPointAnnotation()
                    // 위치에 어노테이션을 표시
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    annotation.subtitle = item.phoneNumber
                    self.mapView.addAnnotation(annotation)
                    
                }
                let destination =
                    self.storyboard?.instantiateViewController(identifier: "ResultsListVC") as!
                ResultsListVC
                
                destination.mapItems = self.matchingItems
                
                self.navigationController?.pushViewController(destination, animated: true)
            }
        })
        
        

    }
    
    @IBAction func textFieldReturn(_ sender: Any) {
        searchText.resignFirstResponder()
        mapView.removeAnnotations(mapView.annotations)
        self.performSearch()

    }
    
    @IBAction func zoomIn(_ sender: Any) {
        let userLocation = mapView.userLocation
        // 현재위치의 좌표, 남/북 2000미터인 스팬으로 구성된 MKCoordinateRegion 객체를 생성
        let region = MKCoordinateRegion.init(center:userLocation.location!.coordinate,
                                             latitudinalMeters:3000, longitudinalMeters:3000)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func changeMapType(_ sender: Any) {
        if mapView.mapType == MKMapType.standard {
            mapView.mapType = MKMapType.satellite
        } else {
            mapView.mapType = MKMapType.standard
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        
        let request = MKDirections.Request()
        
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.748384, longitude: -73.985479), addressDictionary: [:]))
        request.source!.name = "엠파이어 스테이트 빌딩"
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.643351, longitude: -73.788969), addressDictionary: [:]))
        request.destination!.name = "JFK 공항"
        request.transportType = MKDirectionsTransportType.transit
        
        let directions = MKDirections(request: request)
        directions.calculateETA { (response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            print(response!.expectedTravelTime)
        }
        
        mapView.delegate = self
        
        
        let center = CLLocationCoordinate2D(latitude: 37.5690886, longitude: 126.984652)
        let maxDistance = 1000.0
        region = CLCircularRegion(center: center,
                     radius: maxDistance, identifier: "종로")
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        locationManager.startMonitoring(for: region)
        
        couponView = UIImageView(image: UIImage(named: "coupon.png"))
        couponView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)

    }
}

extension ViewController:MKMapViewDelegate, CLLocationManagerDelegate{
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        mapView.addSubview(couponView)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        couponView.removeFromSuperview()
    }

}
