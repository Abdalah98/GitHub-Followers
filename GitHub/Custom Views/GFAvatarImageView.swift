//
//  GFAvatarImageView.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/7/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache = NetworkManger.shared.cache
    let placeholderImage = Images.placeHolder

    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    func downloadImage(formURL url:String){
          NetworkManger.shared.downLoadImage(from:url) { [weak self] iamge in
              guard let self = self else{return  }
              DispatchQueue.main.async {
                  self.image = iamge
              }
          }
      }
      
    
}
