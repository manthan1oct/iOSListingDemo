//
//  viewModel.swift
//  Listview Task
//
//  Created by Aakash patel on 07/06/18.
//  Copyright © 2018 aakash patel. All rights reserved.
//

import UIKit

class ViewModel: NSObject {
    
    var utilityClass = Utility()
    var apiCall = ApiCallModel()
    var productsList = NSMutableArray()
    
    func fetchProducts(completion: @escaping () -> ())
    {
        apiCall.fetchProductsapi() { response in
            let statusCheck = (response as AnyObject).object(forKey:"status") as! String
            
            if (statusCheck == "0"){
                let productsArray = (response as AnyObject).object(forKey: "products") as! NSArray
                self.productsList.addObjects(from: productsArray as! [Any])
                
            }else{
                let errorMessage = (response as AnyObject).object(forKey:"errorMessage") as! String
                self.utilityClass.showAlert(message: errorMessage)
            }
            completion()
            
        }
    }
    
    
    func numberOfItemsInSection(section: Int) -> Int
    {
        return self.productsList.count 
    }
    
    
    func titleForItemAtIndexpath(indexpath: NSIndexPath) -> NSDictionary
    {
        return self.productsList[indexpath.row] as! NSDictionary
    }
    
}
