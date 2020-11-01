//
//  GFTitleLable.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/3/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

class GFTitleLable: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
  convenience init(textAlignment:NSTextAlignment,fontSize:CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        
    }
    
    
    private func configure(){
        //.lable it drak wihte and light black
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
