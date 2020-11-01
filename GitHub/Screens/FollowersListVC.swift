//
//  FollowersListVC.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/3/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

class FollowersListVC: GFDataLoadingVC {
    // numb of section
    enum Section {
        case main
    }
    
    var username:String!
    var followers:[Follower]           = []
    var filteredFollowers : [Follower] = []
    var page:Int                       = 1
    var hasMoreFollowers               = true
    var isSearching                    = false
    var isLoadingFollowers             = false
    
    var collectioView :UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<Section,Follower>!
    
    
    init(username:String){
        super.init(nibName: nil, bundle: nil)
        self.username    = username
        title            = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureSearchController()
        getFollowers(username: username,page: page)
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //  navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector (addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    func configureCollectionView(){
        collectioView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.creatThreeColumnFlowLayout(in: view))
        view.addSubview(collectioView)
        collectioView.delegate = self
        collectioView.backgroundColor = .systemBackground
        collectioView.register(FollowersCell.self, forCellWithReuseIdentifier: FollowersCell.resueID)
    }
    
    
    func configureSearchController() {
        let searchController  = UISearchController()
        searchController.searchResultsUpdater     = self
        searchController.searchBar.placeholder    = "Search foe a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController           = searchController
    }
    
    
    func getFollowers(username:String , page :Int){
        showLoadingView()
        isLoadingFollowers = true
        
        NetworkManger.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else{return}
            self.dismissLoadingView()
            
            switch result{
            case .success(let followers):
                self.updateUI(with: followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff Happend", message: error.rawValue, buttonTitle: "OK")
            }
            self.isLoadingFollowers = false
        }
    }
    
    
    func updateUI(with followers :[Follower]) {
        if followers.count < 100{self.hasMoreFollowers = false}
        self.followers.append(contentsOf: followers )
        
        if self.followers.isEmpty{
            let message = "This User doesn`t have any followers. Go follow them 😔"
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)
                return
            }
        }
        
        self.updataData(on: self.followers)
    }
    
    ////////
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectioView, cellProvider: { (collectioView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectioView.dequeueReusableCell(withReuseIdentifier: FollowersCell.resueID, for: indexPath) as! FollowersCell
            cell.set(followers: follower)
            
            return cell
        })
    }
    
    
    func updataData(on followers:[Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    @objc func addButtonTapped(){
        showLoadingView()
        
        NetworkManger.shared.getUsers(for: username) {[weak self]result in
            guard let self = self else {return}
            self.dismissLoadingView()
            
            switch result{
            case .success(let user):
                self.addUsertoFavorites(user: user)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Some thing worng", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    
    
    func addUsertoFavorites(user:User){
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistenceManger.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else {return}
            guard let error = error else{
                self.presentGFAlertOnMainThread(title: "Success!", message: "You have successfully favorite this user 🎉", buttonTitle: "Hooray!")
                return
            }
            self.presentGFAlertOnMainThread(title: "Some thing worng", message: error.rawValue, buttonTitle: "OK")
        }
    }
}


extension FollowersListVC:UICollectionViewDelegate{
    ////
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY      = scrollView.contentOffset.y
        let contenHight  = scrollView.contentSize.height
        let hight        = scrollView.frame.size.height
        
        if offsetY > contenHight - hight {
            guard hasMoreFollowers ,!isLoadingFollowers else {
                return
            }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destVS = UserInfoVC()
        destVS.username = follower.login
        destVS.deleagte = self
        let navController = UINavigationController(rootViewController: destVS)
        present(navController, animated: true)
    }
}


extension FollowersListVC : UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else{
            
            filteredFollowers.removeAll()
            updataData(on: followers)
            isSearching = false
            return
        }
        
        isSearching = true
        filteredFollowers = followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        updataData(on: filteredFollowers)
    }
}


extension FollowersListVC: UserInfoVCDelegate{
    
    func didRequestFollowers(for username: String) {
        self.username     = username
        title             = username
        page              = 1
        
        followers.removeAll()
        filteredFollowers.removeAll()
        collectioView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
}
