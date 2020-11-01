//
//  Date+Ext.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/20/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import Foundation

extension Date{
    
    func convertToMonthYearFormat()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
        
    }
    
    
}
