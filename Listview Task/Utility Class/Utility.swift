//
//  Utility.swift
//  Listview Task
//
//  Created by Aakash patel on 07/06/18.
//  Copyright © 2018 aakash patel. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    
    //MARK: Action_Alert
    public func showAlert( message: String) {
        let alertController = UIAlertController(title:  "Message", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        alertController.addAction(okAction)
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        topVC?.present(alertController, animated: true, completion: nil)
    }

    //MARK: Validate_Textfields
    func validateTxtfield(value: String, alertmsg: String) -> Bool {
        let valid = !value.isEmpty
        if !valid{
            self.showAlert(message: "Please enter \(alertmsg.lowercased())")
        }
        return valid
    }

}
