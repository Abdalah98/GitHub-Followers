//
//  UserInfoVC.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/16/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didRequestFollowers(for username:String)
}

class UserInfoVC: GFDataLoadingVC {
    
    let scrollView          = UIScrollView()
    let contentView         = UIView()
    
    let headerView          = UIView()
    let itemViewOne         = UIView()
    let itemViewTwo         = UIView()
    let dateLable           = GFBodyLable(textAlignment: .center)
    var itemViews :[UIView] = []
    
    var username :String!
    weak var deleagte:UserInfoVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        getUserInfo()
        layoutUI()
    }
    
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector (dismssVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    func configureScrollView(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdge(of: view)
        contentView.pinToEdge(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
        
    }
    
    func getUserInfo(){
        NetworkManger.shared.getUsers(for: username) { [weak self] result in
            guard let self = self else{return}
            
            switch result{
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user )
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went worng", message: error.rawValue, buttonTitle: "OK")
            }
            
        }
    }
    
    
    func configureUIElements(with user :User){
        
        self.add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
        self.add(childVC: GFFollowerItemVC(user: user, delegate: self ), to: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLable.text  = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    
    func layoutUI(){
        let padding:CGFloat = 20
        let itemHeight:CGFloat = 140
        
        itemViews = [headerView,itemViewOne,itemViewTwo,dateLable]
        
        for itemView in itemViews{
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLable.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLable.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func add(childVC:UIViewController , to containerView:UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    @objc  func dismssVC(){
        dismiss(animated: true)
    }
}


extension UserInfoVC:GFRepoItemVCDelegate{
    
    func didTapGitHubProfile(for user: User) {
        // show safari view controller
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "OK")
            return
        }
        presntSafariVC(with: url)
    }
}
extension UserInfoVC:GFFollowerItemVCDelegate{
    
    func didTapGitHubFollowers(for user: User) {
        //dismiss
        //tell follower list screen the new user
        guard user.followers != 0 else{
            presentGFAlertOnMainThread(title: "No Followers", message: "This user no has followers", buttonTitle: "so sad")
            return
        }
        deleagte.didRequestFollowers(for: user.login)
        dismssVC()
    }
}

