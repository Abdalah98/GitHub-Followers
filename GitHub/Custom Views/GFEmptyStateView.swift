//
//  GFEmptyStateView.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/14/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLable = GFTitleLable(textAlignment: .center, fontSize: 28)
    let imageLogoView  = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience  init(message:String) {
        self.init(frame:.zero)
        messageLable.text = message
        
    }
    
    
    private func configure(){
        addSubviews(messageLable,imageLogoView)
        configureLogoImage()
        configureMessageLabel()
    }
    
    
    private func configureMessageLabel(){
        messageLable.numberOfLines  = 3
        messageLable.textColor     = .secondaryLabel
        
        let lableCenterConstraint :CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -150
        
        NSLayoutConstraint.activate([
            messageLable.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: lableCenterConstraint),
            messageLable.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: -150),
            messageLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLable.heightAnchor.constraint(equalToConstant: 200) ])
        
    }
    
    private func configureLogoImage(){
        imageLogoView.image = Images.emptyState
        imageLogoView.translatesAutoresizingMaskIntoConstraints = false
        
        let logoBottomContant :CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40
       
        NSLayoutConstraint.activate([
            imageLogoView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageLogoView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageLogoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            imageLogoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:  logoBottomContant)
        ])
    }
    
}
