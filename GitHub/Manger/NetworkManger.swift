//
//  NetworkManger.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/5/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

class NetworkManger{
     
    static let shared     = NetworkManger()
    private let basURL    = "https://api.github.com/users/"
    let cache             = NSCache<NSString, UIImage>()
    private init(){}
    
    func getFollowers(for username : String , page :Int ,completed: @escaping (Result<[Follower] , GFError>) -> Void){
        let endpoint = basURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string:endpoint) else{
            completed(.failure(.invaldUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse ,response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decodeable = JSONDecoder()
                decodeable.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decodeable.decode([Follower].self, from: data)
                completed(.success(followers))
                
            }catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getUsers(for username : String ,completed: @escaping (Result< User , GFError >) -> Void){
        let endpoint = basURL + "\(username)"
        
        guard let url = URL(string:endpoint) else{
            completed(.failure(.invaldUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse ,response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decodeable                 = JSONDecoder()
                decodeable.keyDecodingStrategy = .convertFromSnakeCase
                decodeable.dateDecodingStrategy = .iso8601
                let user = try decodeable.decode(User.self, from: data)
                completed(.success(user))
                
            }catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func downLoadImage(from urlString:String, completed: @escaping (UIImage?)-> Void){
        let ketString = NSString(string: urlString)
        
        if let image = cache.object(forKey: ketString) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else{
            completed(nil)
            return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self ,
                error == nil ,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data)else{
                    completed(nil)
                    return
                    
            }
            
            self.cache.setObject(image, forKey: ketString)
            completed(image)
        }
        task.resume()
    }
}
