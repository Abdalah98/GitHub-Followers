//
//  Constant.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/19/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

enum SFSymbols{
    static let location                 = UIImage(systemName:"mappin.and.ellipse")
    static let repos                    = UIImage(systemName:"folder")
    static let gists                    = UIImage(systemName:"text.alignleft")
    static let followers                = UIImage(systemName:"heart")
    static let following                = UIImage(systemName:"person.2")
}


enum Images{
    static let  ghLogo                   = UIImage(named: "gh-logo-dark")
    static let  placeHolder              = UIImage(named: "avatar-placeholder")
    static let  emptyState               = UIImage(named: "empty-state-logo")
}


enum ScreenSize{
    static let width                      = UIScreen.main.bounds.size.width
    static let height                     = UIScreen.main.bounds.size.height
    static let maxLenght                  = max(ScreenSize.width,ScreenSize.height)
    static let minLenght                  = min(ScreenSize.width,ScreenSize.height)
    }


enum DeviceTypes{
        static let idiom                  = UIDevice.current.userInterfaceIdiom
        static let nativeScale            = UIScreen.main.nativeScale
        static let scale                  = UIScreen.main.scale

   		static let isiPhoneSE             = idiom == .phone && ScreenSize.maxLenght == 568.0
   		static let isiPhone8Standaed      = idiom == .phone && ScreenSize.maxLenght == 667.0 && nativeScale == scale
   		static let isiPhone8Zoomed        = idiom == .phone && ScreenSize.maxLenght == 667.0 && nativeScale  > scale
   		static let isiPhone8PlusStandaed  = idiom == .phone && ScreenSize.maxLenght == 736.0
   		static let isiPhone8PlusZoomed    = idiom == .phone && ScreenSize.maxLenght == 736.0 && nativeScale < scale
   		static let isiPhoneX              = idiom == .phone && ScreenSize.maxLenght == 812.0
   		static let isiPhoneXMaxAndXr      = idiom == .phone && ScreenSize.maxLenght == 869.0
   		static let isiPad                 = idiom == .pad && ScreenSize.maxLenght >= 1024.0
   		
   		static func isiPhoneXAspectRatio()->Bool{
   		    return isiPhoneX || isiPhoneXMaxAndXr
   		}
}
