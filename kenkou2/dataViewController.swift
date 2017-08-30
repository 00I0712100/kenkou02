//
//  dataViewController.swift
//  kenkou2
//
//  Created by TomokoTakahashi on 2017/08/28.
//  Copyright © 2017年 高橋知子. All rights reserved.
//

import UIKit
import RealmSwift

class dataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet var label: UILabel!
    

    var data = AllData()
    
    var displayTextArray: [AllData] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        table.dataSource = self
        table.registerCell(type: hosuCellTableViewCell.self)
        // Do any additional setup after loading the view.
    }
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayTextArray.count
    }
    //各セルの要素を設定する
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // tableCell の ID で UITableViewCell のインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "tableCell")
        // cell?.textLabel?.text = "テスト"
        data = displayTextArray[indexPath.row]
        cell?.textLabel?.text = data.hosuData
        
        
        
        return cell!
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let realm = try! Realm()
        
        let savedAllDataArray = Array(realm.objects(AllData.self))
        displayTextArray = savedAllDataArray as [AllData]
        
        table.reloadData()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
