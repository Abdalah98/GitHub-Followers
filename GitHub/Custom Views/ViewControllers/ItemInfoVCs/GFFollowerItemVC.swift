//
//  GFFollowerItemVC.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/20/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

protocol GFFollowerItemVCDelegate: class {
    func didTapGitHubFollowers(for user :User)
}

class GFFollowerItemVC: GFItemInfoVC{
    
    weak  var delegate: GFFollowerItemVCDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         configureItems()
    }
    
    
    init(user: User,delegate: GFFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "GitHub Followers")
    }
    override func actionButtonTapped() {
        delegate.didTapGitHubFollowers(for: user)
    }
}
