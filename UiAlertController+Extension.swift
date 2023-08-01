//
//  UiAlertController+Extension.swift
//  Demo Project
//
//  Created by Apple on 09/07/22.
//

import Foundation
import UIKit

extension UIViewController{
    
    // Global Alert
    // Define Your number of buttons, styles and completion
    public func openAlert(title: String,
                          message: String,
                          alertStyle:UIAlertController.Style,
                          actionTitles:[String],
                          actionStyles:[UIAlertAction.Style],
                          actions: [((UIAlertAction) -> Void)]){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated(){
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
    //https://stackoverflow.com/a/56579842/8201581
    
//    
//    func showAlert(_ message: String, title: String = "kAppName", type: GCAlertViewController.alertType = .none ,btnTitle: String = "OK" ,completion: ((Bool) -> Void)? = nil) {
//        let alert = UIStoryboard.viewController().alertView()
//        alert.descriptionStr = message
//        alert.titleStr = kAppName //title
//        alert.type = type
//        alert.completion = completion
////        alert.rightBtn.setTitle("Ok", for: .normal)
//        self.present(alert, animated: true, completion: nil)
//        alert.btnTitle = btnTitle
//       
//    }
//    
    
    
}
