//
//  ViewController.swift
//  GeoCoding
//
//  Created by Munseok Park on 2020/09/12.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

import Contacts
import MapKit
import CoreLocation
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var address: UITextField!

    
    @IBAction func getDirection(_ sender: Any) {
        //Kakao REST API Key
        let appkey = "06fab290c9f4eb6f130c09796d57bc30"
        //입력한 문자열이 존재한다면
        if let addressString = address.text,
            let cityString = city.text,
            let stateString = state.text{
            //입력한 문자열을 하나로 만들어서 인코딩
            let addr = "\(stateString) \(cityString) \(addressString)"
            let query = addr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            
            //요청 생성
            let request = AF.request("https://dapi.kakao.com/v2/local/search/address.json?query=\(query)", method: .get, encoding: JSONEncoding.default, headers:["Authorization":"KakaoAK \(appkey)"])
            //결과 사용
            request.responseJSON{response in
                if let jsonObject = response.value as? [String : Any]{
                    //검색된 데이터 개수 파악
                    let meta = jsonObject["meta"] as! NSDictionary
                    let totalCount = ((meta["total_count"] as! NSNumber).intValue)
                    NSLog(meta.description)
                    if totalCount != 0 {
                        //데이터 배열 가져오기
                        let documents = jsonObject["documents"] as! NSArray
                        
                        //첫번째 데이터를 이용해서 위도와 경도 가져오기
                        let first = documents[0] as! NSDictionary
                        let latitude = Double(first["x"] as! String)
                        let longitude = Double(first["y"] as! String)
                        
                        let addressDict =
                        [CNPostalAddressStreetKey: addressString,
                         CNPostalAddressCityKey: cityString,
                         CNPostalAddressStateKey: stateString]

                        
                        //가져온 위도와 경도를 이용해서 지도 앱 실행
                        let place = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!), addressDictionary: addressDict)
                        
                        NSLog(place.description)
                        let mapItem = MKMapItem(placemark: place)
                        NSLog(mapItem.description)
                       
                        let options = [MKLaunchOptionsDirectionsModeKey:
                            MKLaunchOptionsDirectionsModeDriving]
                        
                        mapItem.openInMaps(launchOptions: options)
                        
                    }else{
                        let alert = UIAlertController(title: "지도 출력", message: "없는 주소입니다.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default))
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

