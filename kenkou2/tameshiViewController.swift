//
//  tameshiViewController.swift
//  kenkou2
//
//  Created by TomokoTakahashi on 2017/08/22.
//  Copyright © 2017年 高橋知子. All rights reserved.
//

import UIKit

class tameshiViewController: UIViewController {
    
    @IBOutlet weak var scview: UIScrollView! //storyboardでスクロールビューを配置しているので接続
    @IBOutlet weak var hiniti: UILabel!
    @IBOutlet weak var bmi: UILabel!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let now = Date() // 現在日時の取得
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale! // ロケールの設定
        dateFormatter.dateFormat = "yyyy.MM.dd" // 日付フォーマットの設定
        
        hiniti.text = dateFormatter.string(from: now)
       
        let graphview = Graph() //グラフを表示するクラス
        scview.addSubview(graphview) //グラフをスクロールビューに配置
        graphview.drawLineGraph() //グラフ描画開始
        
        scview.contentSize = CGSize(width:graphview.checkWidth()+20, height:graphview.checkHeight()) //スクロールビュー内のコンテンツサイズ設定

        // Do any additional setup after loading the view.
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


