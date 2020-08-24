//
//  AlamofireMovieListViewController.swift
//  AlamofireMovie
//
//  Created by Munseok Park on 2020/08/24.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit
import Alamofire
import Nuke
class AlamofireMovieListViewController: UITableViewController {
    //페이지 번호를 저장할 프로퍼티
    var page = 1
    // 테이블 뷰를 구성할 리스트 데이터
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        return datalist
    }()
    
    func downloadData(){
        //다운로드 받을 URL 만들기
        let url = "http://cyberadam.cafe24.com/movie/list?page=\(page)"
        
        let request = AF.request(url, method: .get, encoding: JSONEncoding.default, headers:[:])
        
        request.responseJSON{
            response in
            //print(response.result.value!)
            if let jsonObject = response.value as? [String : Any]{
                let list = jsonObject["list"] as! NSArray
                for index in 0...(list.count-1){
                    let item = list[index] as! NSDictionary
                    var movie = MovieVO()
                    // movie 배열의 각 데이터를 mvo 상수의 속성에 대입
                    movie.movieid = ((item["movieid"] as! NSNumber).intValue)
                    movie.title = item["title"] as? String
                    movie.genre = item["genre"] as? String
                    movie.thumbnail = item["thumbnail"] as? String
                    movie.link = item["link"] as? String
                    movie.rating = ((item["rating"] as! NSNumber).doubleValue)
                    
                    // 웹상에 있는 이미지를 읽어와 UIImage 객체로 생성
                    let url: URL! = URL(string: "http://cyberadam.cafe24.com/movieimage/\(movie.thumbnail!)")
                    //let imageData = try! Data(contentsOf: url)
                    //movie.image = UIImage(data:imageData)
                    
                    // list 배열에 추가
                    self.list.append(movie)
                    
                    
                }
                // 전체 데이터 카운트를 얻는다.
                let totalCount = (jsonObject["count"] as! NSNumber).intValue
                
                // totalCount가 읽어온 데이터 크기와 같거나 클 경우리프레시 컨트롤을 숨김
                if (self.list.count >= totalCount) {
                    self.refreshControl?.isHidden = true
                }
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        //페이지 번호에 1을 추가한다.
        self.page += self.page + 1
        self.downloadData()
        refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "영화정보"
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action:
            #selector(AlamofireMovieListViewController.handleRefresh(_:)),
                                       for:.valueChanged)
        self.refreshControl!.tintColor = UIColor.red
        self.downloadData()
    }
    
    
    
    //섹션의 개수를 설정하는 메소드
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //섹션 별 행의 개수를 설정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    //셀을 만들어서 출력하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 주어진 행에 맞는 데이터 소스를 읽어온다.
        let row = self.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlamofireMovieCell") as! AlamofireMovieCell
        
        // 데이터 소스에 저장된 값을 각 아울렛 변수에 할당
        cell.lblTitle?.text = row.title
        cell.lblGenre?.text =  row.genre
        cell.lblRating?.text = "\(row.rating!)"
        DispatchQueue.main.async(execute: {
            // 인자값으로 받은 인덱스를 기반으로 해당하는 배열에서 데이터를 읽어옴
            let movie = self.list[indexPath.row]
            let url: URL! = URL(string: "http://cyberadam.cafe24.com/movieimage/\(movie.thumbnail!)")
            let options = ImageLoadingOptions(
                placeholder: UIImage(named: "placeholder"),
                transition: .fadeIn(duration: 2)
            )
            Nuke.loadImage(with: url, options: options, into: cell.imgThumbnail)
        })
        
        return cell
    }
    
    
    //셀의 높이를 설정하는 메소드
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView,
                               didSelectRowAt indexPath: IndexPath){
           let movieDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetailViewController.title = list[indexPath.row].title
        movieDetailViewController.link = list[indexPath.row].link
           
           self.navigationController?.pushViewController(movieDetailViewController, animated: true)
       }

}
