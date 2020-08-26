//
//  ToDoViewController.swift
//  ToDo
//
//  Created by Munseok Park on 2020/08/26.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit
import CoreData

class ToDoViewController: UITableViewController {
    //데이터 소스 역할을 할 배열 변수
    lazy var list: [NSManagedObject] = {
        return self.fetch()
    }()
    
    func fetch() -> [NSManagedObject] {
        // 1. 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 2. 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        // 3. 요청 객체 생성
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ToDo")
        
        // 정렬 속성 설정
        let sort = NSSortDescriptor(key: "runtime", ascending: false)
        fetchRequest.sortDescriptors = [sort]

        
        // 4. 데이터 가져오기
        let result = try! context.fetch(fetchRequest)
        return result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "To Do List"
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
        self.navigationItem.rightBarButtonItem = addBtn
        self.navigationItem.leftBarButtonItem = self.editButtonItem // 편집 버튼 추가


    }
    
    @objc func add(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let toDoInputViewController = storyboard.instantiateViewController(withIdentifier: "ToDoInputViewController") as! ToDoInputViewController
        toDoInputViewController.mode = "삽입"
        self.present(toDoInputViewController, animated: false)
    }
    
    func delete(object: NSManagedObject) -> Bool{
            // 1. 앱 델리게이트 객체 참조
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            // 2. 관리 객체 컨텍스트 참조
            let context = appDelegate.persistentContainer.viewContext
            
            // 3. 컨텍스트로부터 해당 객체 삭제
            context.delete(object)
            
            // 4. 영구 저장소에 커밋한다.
            do {
                try context.save()
                return true
            } catch {
                context.rollback()
                return false
            }
    }
    
    func save(title: String, contents: String, runtime: Date) -> Bool {
        // 1. 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 2. 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        // 3. 관리 객체 생성 & 값을 설정
        let object = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: context)
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(runtime, forKey: "runtime")
        
        
        // 4. 영구 저장소에 커밋되고 나면 list 프로퍼티에 추가한다.
        do {
            try context.save()
            //self.list.append(object)
            self.list.insert(object, at: 0)
            self.list = self.fetch()
            
             let logObject = NSEntityDescription.insertNewObject(forEntityName: "Log", into: context) as! LogMO
             logObject.regdate = Date()
             logObject.type = LogType.create.rawValue
            
             (object as! ToDoMO).addToLogs(logObject)

            
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    func edit(object: NSManagedObject, title: String, contents: String, runtime:Date) -> Bool {
        // 1. 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 2. 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        // 3. 관리 객체의 값을 수정
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "runtime")
        
        
        // 영구 저장소에 반영한다.
        do {
            try context.save()
            self.list = self.fetch() // 추가된 부분) list 배열을 갱신한다.
            
            let logObject = NSEntityDescription.insertNewObject(forEntityName: "Log", into: context) as! LogMO
            logObject.regdate = Date()
            logObject.type = LogType.edit.rawValue
            
            (object as! ToDoMO).addToLogs(logObject)

            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tv: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 해당하는 데이터 가져오기
        let record = self.list[indexPath.row]
        let title = record.value(forKey: "title") as? String
        let contents = record.value(forKey: "contents") as? String
        
        // 셀을 생성하고, 값을 대입한다.
        let cell = tv.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = contents
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return .delete
    }
        
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            let object = self.list[indexPath.row] // 삭제할 대상 객체
            if self.delete(object: object) {
                // 코어 데이터에서 삭제되고 나면 배열 목록과 테이블 뷰의 행도 삭제한다.
                self.list.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // 1. 선택된 행에 해당하는 데이터 가져오기
            let object = self.list[indexPath.row]
            
            let title = object.value(forKey: "title") as? String
            let contents = object.value(forKey: "contents") as? String
            let runtime = object.value(forKey: "runtime") as? Date
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let toDoInputViewController = storyboard.instantiateViewController(withIdentifier: "ToDoInputViewController") as! ToDoInputViewController
    
            toDoInputViewController.t = title!
            toDoInputViewController.c = contents!
            toDoInputViewController.r = runtime!
            toDoInputViewController.object = object
            
            toDoInputViewController.mode = "수정"
            
            self.present(toDoInputViewController, animated: false)
            
        }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
            let object = self.list[indexPath.row]
            let uvc = self.storyboard?.instantiateViewController(withIdentifier: "LogViewController") as! LogViewController
            uvc.toDo = object as? ToDoMO
            
            self.show(uvc, sender: self)
    }

}
