//
//  FollowersCell.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/7/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

class FollowersCell: UICollectionViewCell {
    
    static let resueID = "FollowersCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLable = GFTitleLable(textAlignment: .center, fontSize: 16)
    override init(frame: CGRect) {
        super.init(frame:frame)
        configura()
    }
    
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
     func set(followers :Follower){
         avatarImageView.downloadImage(formURL: followers.avatarUrl)
         usernameLable.text = followers.login
       
     }
      
    
    private func  configura(){
        addSubviews(avatarImageView,usernameLable)
        let padding :CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLable.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding),
            usernameLable.heightAnchor.constraint(equalToConstant: 20)
        
        ])
    }
}
