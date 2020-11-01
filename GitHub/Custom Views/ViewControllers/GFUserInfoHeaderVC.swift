//
//  GFUserInfoHeaderVC.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/18/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {

    let avaterImageView = GFAvatarImageView(frame:  .zero)
    let usernameLabel   = GFTitleLable(textAlignment: .left, fontSize: 34)
    let nameLabel       = GFSecondaryTitleLable(fountSize: 18)
    let locationImageView = UIImageView()
    let locationLable  = GFSecondaryTitleLable(fountSize: 18)
    let bioLable      = GFBodyLable(textAlignment: .left)
    
    var user:User!
    
    
    init(user:User){
        super.init(nibName:nil,bundle:nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(avaterImageView,usernameLabel,nameLabel,locationImageView,locationLable,bioLable)
        layoutUI()
        configure()
    }
    

    func configure(){
        avaterImageView.downloadImage(formURL: user.avatarUrl)
        usernameLabel.text          = user.login
        nameLabel.text              = user.name ?? ""
        locationLable.text          = user.location ?? "No ocation"
        bioLable.text               = user.bio ?? "NO bio available"
        bioLable.numberOfLines      = 3
        
        locationImageView.image     =  SFSymbols.location
        locationImageView.tintColor = .secondaryLabel
    }
    

    func layoutUI(){
        let padding :CGFloat   = 20
        let textImagePadding :CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            avaterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avaterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avaterImageView.widthAnchor.constraint(equalToConstant: 90),
            avaterImageView.heightAnchor.constraint(equalToConstant: 90),
            
        
            usernameLabel.topAnchor.constraint(equalTo: avaterImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avaterImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
        
        
            nameLabel.centerYAnchor.constraint(equalTo: avaterImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avaterImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            locationImageView.bottomAnchor.constraint(equalTo: avaterImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avaterImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLable.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLable.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLable.heightAnchor.constraint(equalToConstant: 20),
            
            
            
            bioLable.topAnchor.constraint(equalTo: avaterImageView.bottomAnchor, constant: textImagePadding),
            bioLable.leadingAnchor.constraint(equalTo: avaterImageView.leadingAnchor),
            bioLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLable.heightAnchor.constraint(equalToConstant: 90)
            
        
        ])
    }
}
