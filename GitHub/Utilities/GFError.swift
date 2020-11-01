//
//  GFError.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/17/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import Foundation
enum GFError :String,Error{
    
    case invaldUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this user . please try again."
    case alreadyInFavorites = "You `ve already favorited this user. you must REALLY Like them!"
}
