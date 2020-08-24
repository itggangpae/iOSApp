import Foundation
import UIKit

struct MovieVO {
    var movieid: Int? //영화 ID
    var title: String? // 영화 제목
    var genre: String? // 영화 장르
    var link:String? //영화 상세정보 링크
    var rating: Double? // 평점
    var thumbnail: String? // 영화 섬네일 이미지 주소

    var image:UIImage? //이미지
}
