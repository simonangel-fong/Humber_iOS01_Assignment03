//
//  ViewController.swift
//  Ass03
//
//  Created by Simon Fong on 15/11/2023.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, AddImageDelegate {
    
    /// A reference of a ticket model object.
    var imgModel = (UIApplication.shared.delegate as! AppDelegate).imageModel
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var pickView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /// number Of Rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imgModel.count()
    }
    
    /// define when the row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let imgCount = imgModel.count()
        
        if imgCount > 0 {
            /// get the url
            let imgUrl = imgModel.getImgByIndex(index: row).url
//            print(imgUrl)
            
            /// download the image
            downloadImage(imgUrl: imgUrl)
        }
    }
    
    /// Define the title of each row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imgModel.getImgByIndex(index: row).title
    }
    
    
    /// Protocol functions
    
    // ---- Add new Image ------
    func addNewImage(newImage: Image) {
        let result =  imgModel.addNewImg(newImage:newImage)
        self.pickView.reloadAllComponents() // reload data for picker after the image is added.
    }
    
    func viewDidCancel() {
        
    }
    
    // ---- Helping functions ------
    
    /// Download an image for a given url string
    func downloadImage(imgUrl:String) {
        let queue = DispatchQueue.init(label: "imgQ")
        
        queue.async {
            do{
                let urlObj = URL(string:imgUrl)
                // download data from the url, which taks time
                let imageData = try Data(contentsOf: urlObj!)
                //                print("imageData")
                
                /// access items and send data back to the main thread after the bg thread finished
                DispatchQueue.main.async {
                    //                    print("main thread")
                    self.imgView.image = UIImage(data:imageData)
                }
            }catch {
                DispatchQueue.main.async {
                    //                    print("main thread")
                    self.showAlert(title:"Error",msg:error.localizedDescription)
                }
            }
        }
    }
    
    /// Display alert
    func showAlert(title:String,msg:String) {
        
        // Creates alert controller object.
        let alert = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: .alert
        )
        
        // Creates an alert action
        let actionCancel = UIAlertAction(title: "OK", style: .cancel){_ in
            self.imgView.image = UIImage(systemName: "photo.fill.on.rectangle.fill")
        }
        
        // bind action with alert controller.
        alert.addAction(actionCancel)
        
        // present alert component with animatioin.
        present(alert, animated: true)
        
    }
    
    
    /// prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let targetVC = segue.destination as! AddViewController
        targetVC.delegator = self
    }
}

