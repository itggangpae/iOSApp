//
//  ViewController.swift
//  Classification
//
//  Created by Munseok Park on 2020/08/18.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    //사람이름을 가지고 있을 배열
    var data:Array<String> = []
    //각 섹션에 해당하는 데이터
    var sectionData:Array<Dictionary<String, Any>>=[]
    //인덱스 항목을 가지고 있을 변수
    var indexes:Array<String> = []
    
    @IBOutlet weak var tableView: UITableView!
    
    //검색바 객체 생성
    let searchController = UISearchController(searchResultsController: nil)
    //검색된 결과를 저장할 리스트 생성
    var filteredPlayers = [String]()
    //검색 입력 란에 아무 내용도 없는지 확인할 메소드
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    //검색 입력 란에 내용을 입력하면 호출되는 메소드
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredPlayers = data.filter({(player : String) -> Bool in
            return player.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    //검색 입력 란의 상태를 리턴하는 메소드
    func isFiltering() -> Bool {
      return searchController.isActive && !searchBarIsEmpty()
    }
    
    
    //이름을 넘겨주면 자음을 리턴해주는 메소드
    func subtract(data:String) -> String{
        var result = data.compare("나")
        if  result == ComparisonResult.orderedAscending{
            return "ㄱ"
        }
        result = data.compare("다")
        if  result == ComparisonResult.orderedAscending{
            return "ㄴ"
        }
        result = data.compare("라")
        if  result == ComparisonResult.orderedAscending{
            return "ㄷ"
        }
        result = data.compare("마")
        if  result == ComparisonResult.orderedAscending{
            return "ㄹ"
        }
        result = data.compare("바")
        if  result == ComparisonResult.orderedAscending{
            return "ㅁ"
        }
        result = data.compare("사")
        if  result == ComparisonResult.orderedAscending{
            return "ㅂ"
        }
        result = data.compare("아")
        if  result == ComparisonResult.orderedAscending{
            return "ㅅ"
        }
        result = data.compare("자")
        if  result == ComparisonResult.orderedAscending{
            return "ㅇ"
        }
        result = data.compare("차")
        if  result == ComparisonResult.orderedAscending{
            return "ㅈ"
        }
        result = data.compare("카")
        if  result == ComparisonResult.orderedAscending{
            return "ㅊ"
        }
        result = data.compare("타")
        if  result == ComparisonResult.orderedAscending{
            return "ㅋ"
        }
        result = data.compare("파")
        if  result == ComparisonResult.orderedAscending{
            return "ㅌ"
        }
        result = data.compare("하")
        if  result == ComparisonResult.orderedAscending{
            return "ㅍ"
        }
        return "ㅎ"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //이름들로 data 배열 초기화
        data = ["윤석민", "류현진", "이대호", "김태균", "이용규", "김광현","강민호","최희섭","김상현","양현종","봉중근","김현수","홍성흔","정근우", "황재균","강정호"];
        
        //index 배열 초기화(ㄱ - ㅎ)
        indexes = ["ㄱ", "ㄴ", "ㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
        
        var temp : [[String]] = Array(repeating: Array(),count: 14)
        
        //index에 있는 한글 자음들과 data에 있는 이름들의 첫 글자를 비교해서
        //동일한 글자이면 temp[index번째]에 이름을 저장
        var i = 0
        while i < indexes.count
        {
            let firstName = indexes[i]
            var j = 0
            while j < data.count
            {
                let str = data[j]
                if firstName == self.subtract(data: str)
                {
                    temp[i].append(str)
                }
                j = j + 1
            }
            i = i + 1
        }
        
        i = 0
        while i < temp.count
        {
            if temp[i].count >= 2{
                temp[i].sort()
            }
            i = i + 1
        }
        
        //데이터가 있는 temp 배열만 추출해서
        //section_name이라는 키로 한글 자음을 저장하고
        //data라는 키로 이름 배열을 저장해서 디셔너리를 생성한 후
        //이 디셔너리들을 setionData에 추가
        i = 0
        while i < indexes.count
        {
            if temp[i].count > 0
            {
                var dic : Dictionary<String, Any> = [:]
                dic["section_name"] = indexes[i]
                dic["data"] = temp[i]
                sectionData.append(dic)
            }
            i = i + 1
        }
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Player"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering() {
            return 1
        }
        return sectionData.count
    }
    
   
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isFiltering(){
            return "검색결과"
        }
        //섹션 번호에 해당하는 디셔너리를 sectionData에서 가져오기
        let dic = sectionData[section]
        //가져온 디셔너리에서 section_name이라는 키의 데이터를 가져오기
        let sectionName = (dic["section_name"] as! NSString) as String
        return sectionName;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if isFiltering(){
            return filteredPlayers.count
        }
        //섹션 번호에 해당하는 디셔너리를 sectionData에서 가져오기
        let dic = sectionData[section]
        //가져온 디셔너리에서 section_name이라는 키의 데이터를 가져오기
        let ar = (dic["data"] as! NSArray) as Array
        return ar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell";
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if (cell == nil)
        {
            cell = UITableViewCell(style:UITableViewCell.CellStyle.default,reuseIdentifier:cellIdentifier)
        }
        
        if isFiltering() {
          cell!.textLabel!.text = (filteredPlayers[indexPath.row] as NSString) as String
        }
        else{
        //섹션 번호에 해당하는 디셔너리를 sectionData에서 가져오기
        let dic = sectionData[indexPath.section]
        //가져온 디셔너리에서 section_name이라는 키의 데이터를 가져오기
        let ar = (dic["data"] as! NSArray) as Array
        cell!.textLabel!.text = (ar[indexPath.row] as! NSString) as String
        }
        return cell!
    }
    
    //테이블 뷰의 오른쪽에 인덱스를 생성해주는 메서드
    //리턴하는 배열의 내용을 인덱스로 만들어서 출력을 해줍니다.
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return indexes
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        //분류된 데이터 배열에서 한글자음을 가지고 와서
        //누른 문자열과 비교한 후 일치하면 그 인덱스로 이동
        for i in 0..<sectionData.count{
            
            let dic = sectionData[i]
            let sectionName = dic["section_name"] as! String;
            if sectionName == title
            {
                return i;
            }
        }
        //동일한 인덱스를 찾지 못하면 아무것도 하지 않음
        return -1;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
