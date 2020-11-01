//
//  PersistencManger.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/24/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import Foundation

enum PersistenceAction{
    case add,remove
}

enum PersistenceManger {
    
    static private let defults  = UserDefaults.standard
    enum Keys { static let favorites = "favorites" }
    
    
    static func updateWith(favorite:Follower,actionType:PersistenceAction,comleted:@escaping (GFError?)->Void){
        retrieveFavorites { result in
            switch result{
            case .success(var favorites):
                
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        comleted(.alreadyInFavorites)
                        return
                    }
                    
                    favorites.append(favorite)
                    
                case .remove:
                    //$0 all item
                    favorites.removeAll {$0.login == favorite.login}
                }
                comleted(save(favorites: favorites))
                
            case .failure(let error):
                comleted(error)
            }
        }
        
    }
    
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower],GFError>)-> Void){
        guard let favoritesData = defults.object(forKey: Keys.favorites) as? Data else{
            completed(.success([]))
            return
        }
        
        do {
            let decodeable = JSONDecoder()
            let favorites = try decodeable.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        }catch{
            completed(.failure(.unableToFavorite))
        }
    }
    
    
    static func save(favorites:[Follower])->GFError?{
        do{
            let encoder = JSONEncoder()
            let encoderFavorites = try encoder.encode(favorites)
            defults.set(encoderFavorites, forKey: Keys.favorites)
            return nil
        }catch{
            return .unableToFavorite
        }
    }
}
