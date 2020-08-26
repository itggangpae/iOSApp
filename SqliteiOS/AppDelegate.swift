//
//  AppDelegate.swift
//  SqliteiOS
//
//  Created by Munseok Park on 2020/08/26.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let filemgr = FileManager.default
                let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                
        let docsDir = dirPaths[0] as String
                
        let databasePath: String! = docsDir.appending("/phonebook.sqlite")
        // 데이터베이스 파일이 존재하지 않으면 데이터베이스 파일 생성
        if !filemgr.fileExists(atPath: databasePath!) {
            let contactDB = FMDatabase(path: databasePath)
            // 데이터베이스를 열고 contacts 테이블을 생성한다.
            if contactDB.open() {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS phonebook (num INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT, addr TEXT)"
                if !contactDB.executeStatements(sql_stmt) {
                    NSLog("Error \(contactDB.lastErrorMessage())")
                }
                else{
                    NSLog("테이블 생성 성공")
                }
                contactDB.close()
            } else {
                NSLog("Error \(contactDB.lastErrorMessage())")
            }
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

