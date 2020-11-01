//
//  UITableView+Ext.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/31/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

extension UITableView{
    
    func reloadDataOnMainThread(){
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    
    func removeExcessCell(){
        tableFooterView = UIView(frame: .zero)
        
    }
}
