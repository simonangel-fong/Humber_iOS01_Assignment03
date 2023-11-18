//
//  AddViewController.swift
//  Ass03
//
//  Created by Simon Fong on 15/11/2023.
//

import UIKit

protocol AddImageDelegate {
    func addNewImage(newImage:Image)
    func viewDidCancel()
}

class AddViewController: UIViewController {
    
    /// a reference of protocol
    var delegator:AddImageDelegate?
    
    @IBOutlet weak var titleTxt: UITextField!
    
    @IBOutlet weak var urlTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// action when the add button is clicked.
    @IBAction func addClick(_ sender: Any) {

        if let goodTitle = titleTxt.text {
            if let goodUrl = urlTxt.text {
                if !goodTitle.isEmpty && !goodUrl.isEmpty {
                    let newImage = Image(title: goodTitle, url: goodUrl)
                    // call the add new image function
                    delegator?.addNewImage(newImage: newImage)
                    dismiss(animated: true)
                }else{
                    // If the title and url both or either is empty string, display the alert
                    addClickAlert(title: "Warning", msg: "Image title and url are required.")
                }
            }
        }
    }
    
    /// When the cancel button is clicked
    @IBAction func cancelClick(_ sender: Any) {
        
        if let goodTitle = titleTxt.text {
            if let goodUrl = urlTxt.text {
                if goodTitle.isEmpty && goodUrl.isEmpty {
                    /// call the cancel function
                    delegator!.viewDidCancel()
                    dismiss(animated: true)
                }else{
                    /// if either the title or the url is empty
                    cancelClickAlert(title:"Warning",msg:"Do you want to discard \n\(goodTitle)?")
                }
            }
        }
    }
    
    /// --- helping function ----
    
    /// A function to display alert when click add button
    func addClickAlert(title:String,msg:String) {
        // Creates alert controller object.
        let alert = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: .alert
        )
        
        // Creates an alert action
        let actionOK = UIAlertAction(title: "OK", style: .default)
        
        // bind action with alert controller.
        alert.addAction(actionOK)
        
        // present alert component with animatioin.
        present(alert, animated: true)
    }
    
    /// A function to display alert when click cancel button
    func cancelClickAlert(title:String,msg:String) {
        
        // Creates alert controller object.
        let alert = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: .alert
        )
        
        // Creates an alert action
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        let actionDiscard = UIAlertAction(title: "Discard", style: .destructive){_ in
            self.delegator!.viewDidCancel()
            self.dismiss(animated: true)
        }
        
        // bind action with alert controller.
        alert.addAction(actionCancel)
        alert.addAction(actionDiscard)
        
        // present alert component with animatioin.
        present(alert, animated: true)
    }
}
