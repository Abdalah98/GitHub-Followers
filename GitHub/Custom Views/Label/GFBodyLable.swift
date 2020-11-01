//
//  GFBodyLable.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/3/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

class GFBodyLable: UILabel {

  
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(textAlignment:NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        
    }
    
    private func configure(){
        //.lable it drak wihte and light black
        textColor                         = .secondaryLabel
        font                              = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth         = true
        minimumScaleFactor                = 0.75
        lineBreakMode                     = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
