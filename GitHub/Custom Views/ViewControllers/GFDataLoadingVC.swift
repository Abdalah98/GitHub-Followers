//
//  GFDataLoadingVC.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/27/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

class GFDataLoadingVC: UIViewController {

  fileprivate var containerView:UIView!

    

      func  showLoadingView(){
          containerView = UIView(frame: view.bounds)
          view.addSubview(containerView)
          
          containerView.backgroundColor  = .systemBackground
          containerView.alpha            = 0
          
          UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
              let activityIndicator = UIActivityIndicatorView(style: .large)
              self.containerView.addSubview(activityIndicator)
              
              activityIndicator.translatesAutoresizingMaskIntoConstraints = false
              
              NSLayoutConstraint.activate([
                  activityIndicator.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
                  activityIndicator.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor)
              
              ])
              activityIndicator.startAnimating()
          }
      }
      func dismissLoadingView(){
          DispatchQueue.main.async {
              self.containerView.removeFromSuperview()
                   self.containerView = nil
          }
        
      }
      
      func showEmptyStateView(with message :String ,in view :UIView){
          
          let emptyStateView = GFEmptyStateView(message: message)
          emptyStateView.frame = view.bounds
          view.addSubview(emptyStateView)
      }

}
