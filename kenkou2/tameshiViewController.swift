//
//  tameshiViewController.swift
//  kenkou2
//
//  Created by TomokoTakahashi on 2017/08/22.
//  Copyright © 2017年 高橋知子. All rights reserved.
//

import UIKit
import RealmSwift

class tameshiViewController: UIViewController {
    
    @IBOutlet weak var scview: UIScrollView! //storyboardでスクロールビューを配置しているので接続
    @IBOutlet weak var hiniti: UILabel!
    @IBOutlet weak var bmi: UILabel!
    

       //nyuryoku = Nyuryoku()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let now = Date() // 現在日時の取得
        let dateFormatter = DateFormatter()
//        let nyuryoku = Nyuryoku()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale! // ロケールの設定
        dateFormatter.dateFormat = "yyyy.MM.dd" // 日付フォーマットの設定
        
        hiniti.text = dateFormatter.string(from: now)
        
        scview.showsVerticalScrollIndicator = false
        scview.showsHorizontalScrollIndicator = false
//        let realm = try! Realm()
//        let nyuryokuDateArray: [Nyuryoku] = Array(realm.objects(Nyuryoku.self))
//        
////        let originGraphPoints = ["2017/8/24", "", "", "", ""]
////        let originGraphDatas = [10, 50, -30,425,-60]
////        var d: [Dictionary<String, AnyObject>] = []
////        
////        for i in 0 ..< originGraphPoints.count{
////            let dict = ["date": originGraphPoints[i], "value": originGraphDatas[i] ]as [String: AnyObject]
////            d.append(dict)
////        }
//       
//        let graphview = Graph(frame: scview.frame, dataArray: nyuryokuDateArray) //グラフを表示するクラス
//        scview.addSubview(graphview) //グラフをスクロールビューに配置
//        graphview.drawLineGraph() //グラフ描画開始
//        
//        scview.contentSize = CGSize(width:graphview.checkWidth()+20, height:graphview.checkHeight()) //スクロールビュー内のコンテンツサイズ設定

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
        
        let realm = try! Realm()
        let nyuryokuDateArray: [Nyuryoku] = Array(realm.objects(Nyuryoku.self))
        
        //        let originGraphPoints = ["2017/8/24", "", "", "", ""]
        //        let originGraphDatas = [10, 50, -30,425,-60]
        //        var d: [Dictionary<String, AnyObject>] = []
        //
        //        for i in 0 ..< originGraphPoints.count{
        //            let dict = ["date": originGraphPoints[i], "value": originGraphDatas[i] ]as [String: AnyObject]
        //            d.append(dict)
        //        }
        
        let graphview = Graph(frame: scview.frame, dataArray: nyuryokuDateArray) //グラフを表示するクラス
        scview.addSubview(graphview) //グラフをスクロールビューに配置
        graphview.drawLineGraph() //グラフ描画開始
        
        scview.contentSize = CGSize(width:graphview.checkWidth(), height:graphview.checkHeight()) //スクロールビュー内のコンテンツサイズ設定

        
    }
    
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


