//
//  UIViewController+Ext.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/3/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController{
    
    func presentGFAlertOnMainThread(title:String,message:String,buttonTitle:String){
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    
    func presntSafariVC(with url: URL){
        let safariVC = SFSafariViewController(url: url )
              safariVC.preferredControlTintColor = .systemGreen
              present(safariVC,animated: true)
    }
}
