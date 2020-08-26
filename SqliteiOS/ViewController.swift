//
//  ViewController.swift
//  SqliteiOS
//
//  Created by Munseok Park on 2020/08/26.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dbPath = self.getDBPath()
        self.dbExecute(dbPath: dbPath)
    }
    
    func getDBPath() -> String {
        // 앱 내 문서 디렉터리 경로에서 SQLite DB 파일을 찾는다.
        let fileMgr = FileManager()
        /*
         //앱의 도큐먼트 디렉토리에 생성
        let docPathURL = fileMgr.urls(for: .documentDirectory,
                                      in: .userDomainMask).first!
        let dbPath = docPathURL.appendingPathComponent("db.sqlite").path
         */
        
        let dbPath = "/Users/adam/Documents/db.sqlite"
        // dbPath 경로에 db.sqlite 파일이 없다면 앱 번들에 만들어 둔 db.sqlite를 가져와 복사
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "db", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        return dbPath
    }
    
    func dbExecute(dbPath: String) {
        var db : OpaquePointer? = nil // SQLite 연결 정보를 담을 변수
        guard sqlite3_open(dbPath, &db) == SQLITE_OK else {
            NSLog("데이터베이스 연결 실패")
            return
        }
        
        // 데이터베이스 연결 종료
        defer {
            NSLog("데이터베이스 연결 성공")
            sqlite3_close(db)
        }
        
        var stmt : OpaquePointer? = nil // 컴파일된 SQL 정보를 담을 변수
        let sql = "CREATE TABLE IF NOT EXISTS sample(num INTEGER)"
        guard sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK else {
            NSLog("SQL 실행 변수 생성 실패")
            return
        }
        
        //함수의 영역을 벗어나면 실행
        defer {
            NSLog("SQL 실행 변수 해제")
            sqlite3_finalize(stmt)
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("테이블 생성 성공")
        }
    }
}

