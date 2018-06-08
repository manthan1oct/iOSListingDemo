//
//  ViewModel.swift
//  Listview Task
//
//  Created by Aakash patel on 07/06/18.
//  Copyright © 2018 aakash patel. All rights reserved.
//

import UIKit
import Alamofire
import KRProgressHUD

class ApiCallModel: NSObject {
    
    
    func fetchProductsapi(completion: @escaping (NSDictionary) -> Void){

        let Url = (BaseUrl as String) + "list"
        KRProgressHUD.show()
        
        Alamofire.request(Url,
                          method: .get,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers:nil)
            .validate()
            .responseJSON { response in
                
                if let json = response.result.value {
                    completion(json as! NSDictionary)
                }
                
                KRProgressHUD.dismiss()
                
        }
    }
    
}
