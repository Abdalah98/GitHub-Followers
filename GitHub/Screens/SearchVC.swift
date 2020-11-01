//
//  SearchVC.swift
//  GitHub
//
//  Created by Abdalah Omar on 9/30/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUsernameEntered:Bool{return !usernameTextField.text!.isEmpty}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView,usernameTextField,callToActionButton)
        configureLogoImageView()
        configureTextField()
        configureCallActionButton()
        creatDismissKeyBoardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // navigationController?.isNavigationBarHidden = true
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func creatDismissKeyBoardTapGesture(){
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }
    
    // that call whem i cilck in keyboard go or button getFollowers
    @objc func pushFollowersListVC(){
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter asuername . we need to khow who to look for 😀.", buttonTitle: "Ok")
            return}
        usernameTextField.resignFirstResponder()
        let followersListVC      = FollowersListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followersListVC, animated: true)
    }
    
    
    //MARK: - Layout Constraint
    func configureLogoImageView(){
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        let topConstraintConstant:CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
     
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: topConstraintConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
    
    func configureTextField(){
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureCallActionButton(){
        callToActionButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
            
            
            
        ])
        
    }
}

//MARK: - extension TextField
extension SearchVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListVC()
        
        return true
    }
}
