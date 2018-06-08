//
//  ViewController.swift
//  Listview Task
//
//  Created by Aakash patel on 07/06/18.
//  Copyright © 2018 aakash patel. All rights reserved.
//

import UIKit
import KRPullLoader

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var Tbl: UITableView!
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshView = KRPullLoadView()
        refreshView.delegate = self
        Tbl.addPullLoadableView(refreshView, type: .refresh)
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        Tbl.addPullLoadableView(loadMoreView, type: .loadMore)
        
        Tbl.contentInset.top = 0
        Tbl.contentInset.bottom = 0


        viewModel.fetchProducts {
            DispatchQueue.main.async {
            self.Tbl.reloadData()
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        configureCell(cell: cell, forRowAtIndexpath: indexPath as NSIndexPath)
        return cell
    }
    func configureCell(cell : UITableViewCell, forRowAtIndexpath indexPath: NSIndexPath)
    {
        let dictData = viewModel.titleForItemAtIndexpath(indexpath: indexPath) as NSDictionary
        
        let productImage = cell.contentView.viewWithTag(1) as! UIImageView
        productImage.sd_setImage(with: URL(string: (dictData.object(forKey: "imageUrl")) as! String), placeholderImage: UIImage(named: "placeholder_image"))

        let productName = cell.contentView.viewWithTag(2) as! UILabel
        productName.text = "product" + "\(indexPath.row)"
        
        let productPrice = cell.contentView.viewWithTag(3) as! UILabel
        productPrice.text = (dictData.object(forKey: "price")) as? String

        
    }
}


// MARK: - KRPullLoadView delegate -------------------
extension ViewController: KRPullLoadViewDelegate {
    func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
            switch state {
            case let .loading(completionHandler):
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                    completionHandler()
                    self.viewModel.fetchProducts {
                        DispatchQueue.main.async {
                            self.Tbl.reloadData()
                        }
                    }
                }
            default: break
            }
            return
        }
        
        switch state {
        case .none:
            pullLoadView.messageLabel.text = ""
            
        case let .pulling(offset, threshould):
            if offset.y > threshould {
                pullLoadView.messageLabel.text = ""
            } else {
                pullLoadView.messageLabel.text = ""
            }
            
        case let .loading(completionHandler):
            pullLoadView.messageLabel.text = "Updating..."
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                completionHandler()
                self.viewModel.fetchProducts {
                    DispatchQueue.main.async {
                        self.Tbl.reloadData()
                    }
                }
            }
        }
    }
}

