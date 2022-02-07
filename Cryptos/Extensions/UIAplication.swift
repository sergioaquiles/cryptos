//
//  UIAplication.swift
//  UIAplication
//
//  Created by Sergio Cardoso on 24/08/21.
//

import Foundation
import SwiftUI


extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
    }
    
    
}
