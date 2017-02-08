//
//  diaryViewController2.swift
//  kenkou2
//
//  Created by TomokoTakahashi on 2017/02/01.
//  Copyright © 2017年 高橋知子. All rights reserved.
//

import UIKit

class diaryViewController2: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var syokujiimage: UIImageView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var goukei: UILabel!
    
    var syokuhins: [String] = []
    var karoris: [String] = []
    
    let imagePickerController = UIImagePickerController()
    
    let saveData = UserDefaults.standard
    
    let viewData = UserDefaults.standard
    
    var karori = 0
    


    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        table.dataSource = self
        table.delegate = self
        table.registerCell(type: hozonnCell.self)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if let syoku = saveData.array(forKey: "syokuhins") as? [String] {
            syokuhins = syoku
            
        }
        
        if let karo = saveData.array(forKey: "karoris") as? [String] {
            karoris = karo
            
            for c in karoris {
                karori = karori + Int(c)!
            }
            goukei.text = String(karori)
        }
        
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
