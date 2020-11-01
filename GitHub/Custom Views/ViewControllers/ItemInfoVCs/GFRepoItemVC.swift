//
//  GFRepoItemVC.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/20/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

protocol GFRepoItemVCDelegate: class {
    func didTapGitHubProfile(for user :User)
}

class GFRepoItemVC: GFItemInfoVC{
    
     weak  var delegate: GFRepoItemVCDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
         configureItems()
    }
    
    
    init(user: User,delegate: GFRepoItemVCDelegate) {
        super.init(user: user)
        self.delegate    = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    
    
    override func  actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
