//
//  dairyViewController.swift
//  kenkou2
//
//  Created by TomokoTakahashi on 2016/12/23.
//  Copyright © 2016年 高橋知子. All rights reserved.
//

import UIKit
import RealmSwift



class dairyViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var syokujiimage: UIImageView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var goukei: UILabel!
    //@IBOutlet weak var dateLabel: UILabel!
    
    
    
    
    var syokuhins: [String] = []
    var karoris: [String] = []
    var date: String!
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

        return realm.objects(Syokuji.self).filter("hiduke >=%d" , dayBegin()).filter("hiduke <=%d" ,dayFinishi()).first ?? Syokuji()
        
    }()
    
    weak var delegate: PageViewControllerDelegate?
    
    
    let imagePickerController = UIImagePickerController()
    
    let saveData = UserDefaults.standard
    
    let viewData = UserDefaults.standard
    
    let realm = try! Realm()
    
    
    var karori = 0
    
    @IBAction func saveButtonPushed(_ sender: UIButton) {
        
        
        
        
        //画面遷移して前の画面に戻る
        self.dismiss(animated: true, completion: nil)
        
    }
    
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        table.dataSource = self
        table.delegate = self
        table.registerCell(type: hozonnCell.self)
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "1"{
            
            let controller = segue.destination as! hozonnViewController
            controller.atai = 1
            
    }
            }
    
    override func viewWillAppear(_ animated: Bool) {
            var sum: Int = 0
            for obj in syokuji.asa{
                sum = sum + obj.calory
        }
            goukei.text = String(sum)
        
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
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            let imagePickerController = UIImagePickerController()
//            imagePickerController.delegate = self
//            imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
//            delegate?.presentImagePicker(sourceType: .camera, index: 0)
//            
//            self.present(imagePickerController, animated: true, completion: nil)
//        } else {
//            print("カメラ許可をしていない時の処理")
//        }
        delegate?.presentImagePicker(sourceType: .camera, index: 0)
    }
    
    private func selectFromLibrary() {
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//            imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
//            imagePickerController.allowsEditing = true
//            self.present(imagePickerController, animated: true, completion: nil)
//        } else {
//            print("カメラロール許可をしていない時の処理")
//        }
         delegate?.presentImagePicker(sourceType: .photoLibrary, index: 0)
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//                syokujiimage.image = image
//               self.dismiss(animated: true, completion: {
//                   self.performSegue(withIdentifier: "back", sender: nil)
//                   self.dismiss(animated: true, completion: nil)
//                
//               })
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//        syokujiimage.image = image
//        
//        self.dismiss(animated: true, completion: {
//            //self.performSegue(withIdentifier: "back", sender: nil)
//            self.dismiss(animated: true, completion: nil)
//            
//        })
//    }
    
    
    
    @IBAction func library() {
        selectFromLibrary()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return syokuji.asa.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: hozonnCell.self, indexPath: (indexPath ) )!
        cell.karorilabel.text =  String(syokuji.asa[indexPath.row].calory)
        cell.syokuhinlabel.text =  syokuji.asa[indexPath.row].name
        cell.backgroundColor = UIColor.clear
        
        print(syokuhins)
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @IBAction func kanryou(){
        delegate?.dismiss()
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
