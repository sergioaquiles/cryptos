//
//  String.swift
//  String
//
//  Created by Sergio Cardoso on 07/09/21.
//

import Foundation


extension String {
    
    var removingHTMLOcurrences: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    
}
