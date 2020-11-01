//
//  User.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/5/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import Foundation
struct User :Codable{
    let login :String
    let avatarUrl:String
    var name:String?
    var location:String?
    var bio:String?
    let publicRepos:Int
    let publicGists:Int
    let htmlUrl:String
    let followers:Int
    let following: Int
    let createdAt:Date
}
