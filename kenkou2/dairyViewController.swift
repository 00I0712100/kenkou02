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
    var  syokuji: Syokuji!
    
    
    let imagePickerController = UIImagePickerController()
    
    let saveData = UserDefaults.standard
    
    let viewData = UserDefaults.standard
    
    var karori = 0
    
    @IBAction func saveButtonPushed(_ sender: UIButton) {
        
        // STEP.1 Realmを初期化
        let realm = try! Realm()
        
        //STEP.2 保存する要素を書く
        let diary = Diary()
        diary.date = date
        
        
        //STEP.3 Realmに書き込み
        try! realm.write {
            realm.add(diary)
        }
        
        
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

    override func viewWillAppear(_ animated: Bool) {
        
        if let syoku = saveData.array(forKey: "syokuhins") as? [String] {
            syokuhins = syoku
            
          //  dateLabel.text = date
            
            DispatchQueue(label: "background").async {
                let realm = try! Realm()
                
               
                if let date = self.date{
                    if realm.objects(Diary.self).filter("date == '\(date)'").last != nil {
                        //                let context = savedDiary.context
                        //                DispatchQueue.main.async {
                        //                    self.contextTextView.text = context
                        //                }
                    }

                }
                
                            }
            
        }
       

        
//        if let karo = saveData.array(forKey: "karoris") as? [String] {
//            karoris = karo
//            
//            for c in karoris {
//                karori = karori + Int(c)!
//            }
//            goukei.text = String(karori)
//        }
        
        table.reloadData()
        saveData.removeObject(forKey: "syokuhinn")
        saveData.removeObject(forKey: "karori-")
    
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
        return karoris.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: hozonnCell.self, indexPath: indexPath as NSIndexPath)!
        cell.karorilabel.text =  karoris[indexPath.row]
        cell.syokuhinlabel.text =  syokuhins[indexPath.row]
        cell.backgroundColor = UIColor.clear
        
        print(syokuhins)
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
   
    @IBAction func kanryou(){
        viewData.set(syokujiimage.image, forKey:"syokuji" )
        viewData.set(syokuhins, forKey: "syokuhinmei")
        viewData.set(karoris, forKey: "karosi-su")
        viewData.synchronize()
        if let syokuji = self.syokuji{
            let realm = try! Realm()
            try! realm.write{
                realm.add(syokuji,update: true)
            }
        }
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
