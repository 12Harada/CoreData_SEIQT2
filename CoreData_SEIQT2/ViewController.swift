//
//  ViewController.swift
//  CoreData_SEIQT2
//
//  Created by Harada Hiroaki on 2019/02/03.
//  Copyright © 2019 Harada Hiroaki. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDelegate.managedObjectContext
        
        //読み込む
        /*
        let fetchRequest:NSFetchRequest<Seiqt> = Seiqt.fetchRequest()
        var shrky_noList:Array<String> = []
        let fetchData = try! context.fetch(fetchRequest)
        if(!fetchData.isEmpty){
           // print(fetchData)
            for i in 0..<fetchData.count{
                print(fetchData[i].shrky_no)
                shrky_noList.append(fetchData[i].shrky_no!)
            }
        }*/
        
        //読み込む
        print("読み込む")
        let fetchRequest:NSFetchRequest<Seiqt> = Seiqt.fetchRequest()
        var seiqtList:Array<Seiqt> = []
        let fetchData = try! context.fetch(fetchRequest)
        if(!fetchData.isEmpty){
            for i in 0..<fetchData.count{
                let entity = NSEntityDescription.entity(forEntityName: "Seiqt", in: context)
                let seiqt = NSManagedObject(entity:entity!,insertInto:context) as! Seiqt
                seiqt.shrky_no = fetchData[i].shrky_no
                seiqt.seiq_gk = fetchData[i].seiq_gk
                seiqt.rkn_hsse_ymd = fetchData[i].rkn_hsse_ymd
                seiqtList.append(seiqt)
                print("fetchした数：",seiqtList.count)
                print("fetchした支払い契約番号",seiqtList[0].shrky_no)
            }
        }else{
            //セーブする
            print("セーブする")
            let entity = NSEntityDescription.entity(forEntityName: "Seiqt", in: context)
             let seiqt = NSManagedObject(entity:entity!,insertInto:context) as! Seiqt
             seiqt.shrky_no = "20000000001"
             seiqt.rkn_hsse_ymd = Date() as NSDate
             seiqt.seiq_gk = 1000
             do{
             try context.save()
             }catch{
             print(error)
             }
        }
        
        //検索する
        print("検索する")
        let fetchRequestSearch:NSFetchRequest<Seiqt> = Seiqt.fetchRequest()
        let predicate = NSPredicate(format:"%K = %@","shrky_no","20000000001")
        fetchRequestSearch.predicate = predicate
        
        let fetchData2 = try! context.fetch(fetchRequestSearch)
        if(!fetchData2.isEmpty){
            print("検索結果あり")
            for i in 0..<fetchData2.count{
                print("\(fetchData2[i].shrky_no!)の請求金額は\(fetchData2[i].seiq_gk)円です")
                //更新する
                print("更新する")
                fetchData2[i].seiq_gk = 100
                print("\(fetchData2[i].shrky_no!)の請求金額は\(fetchData2[i].seiq_gk)円です")
                
            }
            do{
                print("更新結果の保存")
                try context.save()
            }catch{
                print(error)
            }
        }
            
            //更新結果を確認
            print("更新結果を確認")
            var seiqtList2:Array<Seiqt> = []
            let fetchData3 = try! context.fetch(fetchRequest)
            if(!fetchData3.isEmpty){
                for i in 0..<fetchData3.count{
                    print("fetch結果あり")
                    let entity = NSEntityDescription.entity(forEntityName: "Seiqt", in: context)
                    let seiqt = NSManagedObject(entity:entity!,insertInto:context) as! Seiqt
                    seiqt.shrky_no = fetchData3[i].shrky_no
                    seiqt.seiq_gk = fetchData3[i].seiq_gk
                    seiqt.rkn_hsse_ymd = fetchData3[i].rkn_hsse_ymd
                    seiqtList2.append(seiqt)
                    print("fetchした数：",seiqtList2.count)
                    print("fetchした金額",seiqtList2[i].shrky_no,"fetchした請求金額",seiqtList2[i].seiq_gk)
                }
                
            }
            
            //削除する
            print("削除する")
            let fetchRequest2:NSFetchRequest<Seiqt> = Seiqt.fetchRequest()
            let predicate2 = NSPredicate(format:"%K = %@","shrky_no","20000000001")
            fetchRequest2.predicate = predicate2
            let fetchData4 = try! context.fetch(fetchRequest2)
            if(!fetchData4.isEmpty){
                print("削除処理の実行")
                for i in 0..<fetchData4.count{
                    let deleteObject = fetchData4[i] as Seiqt
                    context.delete(deleteObject)
                }
                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }
        
        //削除結果の確認
        print("削除結果の確認")
        let fetchRequest4:NSFetchRequest<Seiqt> = Seiqt.fetchRequest()
        let fetchData5 = try! context.fetch(fetchRequest4)
        if(fetchData5.isEmpty){
            print("fetchできなかったことを確認")
        }else{
            print("fetch結果があるので、削除できていない")
        }
        
        
    }


}

