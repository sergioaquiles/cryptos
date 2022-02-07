//
//  HapticManager.swift
//  HapticManager
//
//  Created by Sergio Cardoso on 29/08/21.
//

import Foundation
import SwiftUI


class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}

