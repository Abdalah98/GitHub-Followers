//
//  UIView+Ext.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/30/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

extension UIView{
    
    func pinToEdge(of subview : UIView){
        translatesAutoresizingMaskIntoConstraints  = false
        
        NSLayoutConstraint.activate([
        topAnchor.constraint(equalTo: subview.topAnchor),
        leadingAnchor.constraint(equalTo: subview.leadingAnchor),
        trailingAnchor.constraint(equalTo: subview.trailingAnchor),
        bottomAnchor.constraint(equalTo: subview.bottomAnchor)
        ])
    }
    
    //uiview.... pass any nub of views add in subviews
    func addSubviews(_ views:UIView...){
        for view in views{addSubview(view)}
    }
}
