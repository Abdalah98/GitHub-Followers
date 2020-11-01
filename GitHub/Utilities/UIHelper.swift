//
//  UIHelper.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/12/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

enum UIHelper{
    
    static  func creatThreeColumnFlowLayout(in view :UIView) ->UICollectionViewFlowLayout{
          let width                      = view.bounds.width
        // هنا ليه عشان فروق السيل
          let padding:CGFloat            = 12
          let minimumItemSpacing:CGFloat = 10
        //هنا
          let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
          let itemWidth                  = availableWidth / 3
          let flowLayout  = UICollectionViewFlowLayout()
          flowLayout.sectionInset   = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
          flowLayout.itemSize      = CGSize(width: itemWidth, height: itemWidth + 40)
          return flowLayout
          
      }
}
