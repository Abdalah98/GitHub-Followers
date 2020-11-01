//
//  GFSecondaryTitleLable.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/18/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

class GFSecondaryTitleLable: UILabel {

      override init(frame: CGRect) {
          super.init(frame: frame)
          configure()
      }
      
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    
   convenience init(fountSize:CGFloat) {
          self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fountSize, weight: .medium)
          
      }
      
      private func configure(){
          //.lable it drak wihte and light black
          textColor                 = .secondaryLabel
          adjustsFontSizeToFitWidth = true
          minimumScaleFactor        = 0.90
          lineBreakMode             = .byTruncatingTail
          translatesAutoresizingMaskIntoConstraints = false
          
      }

}
