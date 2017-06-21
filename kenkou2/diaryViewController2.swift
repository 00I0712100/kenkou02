//
//  diaryViewController2.swift
//  kenkou2
//
//  Created by TomokoTakahashi on 2017/02/01.
//  Copyright © 2017年 高橋知子. All rights reserved.
//

import UIKit
import RealmSwift

class diaryViewController2: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var syokujiimage: UIImageView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var goukei: UILabel!
    
    var syokuhins: [String] = []
    var karoris: [String] = []
    
    let imagePickerController = UIImagePickerController()
    
    let saveData = UserDefaults.standard
    
    let viewData = UserDefaults.standard
    let realm = try! Realm()
    
    var karori = 0
    var  syokuji: Syokuji = { () -> Syokuji in
        
        let realm = try! Realm()
        
        func dayBegin() -> NSDate {
            let date = Date()
            let calendar = Calendar.current
            let component = calendar.dateComponents([.year, .day, .month], from: date)
            let year = component.year!
            let month = String(format: "%02d", component.month!)
            let day = String(format: "%02d", component.day!)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
            formatter.locale = Locale(identifier: "ja_JP")
            return formatter.date(from: "\(year)/\(month)/\(day) 00:00:00")! as NSDate
        }
        func dayFinishi() -> NSDate {
            let date = Date()
            let calendar = Calendar.current
            let component = calendar.dateComponents([.year, .day, .month], from: date)
            let year = component.year!
            let month = String(format: "%02d", component.month!)
            let day = String(format: "%02d", component.day!)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
            formatter.locale = Locale(identifier: "ja_JP")
            return formatter.date(from: "\(year)/\(month)/\(day) 23:59:59")! as NSDate
        }

        return realm.objects(Syokuji.self).filter("hiduke >=%d" , dayBegin()).filter("hiduke <=%d" ,dayFinishi()).first!
        
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        table.dataSource = self
        table.delegate = self
        table.registerCell(type: hozonnCell.self)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        var sum: Int = 0
        for obj in syokuji.hiru{
            sum = sum + obj.calory
        }
        goukei.text = String(sum)
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "2" {
            
            let cntroller = segue.destination as! hozonnViewController
            cntroller.atai = 2
            
        }
    }
    
    @IBAction func select(){
        selectImage()
    }
    
    private func selectImage() {
        let alertController = UIAlertController(title: "画像を選択", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "カメラを起動", style: .default) { (UIAlertAction) -> Void in
            self.selectFromCamera()
        }
        let libraryAction = UIAlertAction(title: "カメラロールから選択", style: .default) { (UIAlertAction) -> Void in
            self.selectFromLibrary()
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (UIAlertAction) -> Void in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cameraAction)
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func selectFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
            
            
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            print("カメラ許可をしていない時の処理")
        }
    }
    
    private func selectFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            print("カメラロール許可をしていない時の処理")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        syokujiimage.image = image
        
        self.dismiss(animated: true, completion: {
            //self.performSegue(withIdentifier: "back", sender: nil)
            self.dismiss(animated: true, completion: nil)
            
        })
    }
    
    
    @IBAction func library() {
        selectFromLibrary()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return syokuji.hiru.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: hozonnCell.self, indexPath: indexPath as NSIndexPath)!
        cell.karorilabel.text =  String(syokuji.hiru[indexPath.row].calory)
        cell.syokuhinlabel.text =  syokuji.hiru[indexPath.row].name
        cell.backgroundColor = UIColor.clear
        
        print(syokuhins)
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @IBAction func kanryou(){
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
