//
//  FavoritList.swift
//  GitHub
//
//  Created by Abdalah Omar on 9/30/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

class FavoritList: GFDataLoadingVC  {
    
    let tableView = UITableView()
    var favoites: [Follower] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        title                = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        
        tableView.frame      = view.bounds
        tableView.rowHeight  = 80
        tableView.delegate   = self
        tableView.dataSource = self
        
        tableView.removeExcessCell()
        tableView.register(FavoriteCell.self , forCellReuseIdentifier: FavoriteCell.resueID)
    }
    
    func getFavorites(){
        PersistenceManger.retrieveFavorites { [weak self]result in
            
            guard let self = self else{return}
            switch result{
                
            case .success(let favoites):
                self.updateUI(with: favoites)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func updateUI(with favoites :[Follower]) {
        if favoites.isEmpty{
            self.showEmptyStateView(with: "No Favorites?\nAdd one one the follower screen. ", in: self.view)
        }
        self.favoites = favoites
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.bringSubviewToFront(self.tableView)
        }
    }
}



extension FavoritList:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell     = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.resueID) as! FavoriteCell
        let favorite = favoites[indexPath.row]
        cell.set(favorit: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite  = favoites[indexPath.row]
        let destVC    = FollowersListVC(username: favorite.login)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else{return}
        
        PersistenceManger.updateWith(favorite: favoites[indexPath.row], actionType: .remove) {[weak self] error in
            guard let self = self else{return}
            
            guard let error = error else{
                self.favoites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return}
            
            self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "OK")
        }
        
    }
}
