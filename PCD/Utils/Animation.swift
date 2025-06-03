//
//  Animation.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 03/06/25.
//

import SwiftUI

enum AppAnimation {
    static let base = Animation.easeOut(duration: 0.6)
    static func delayed(_ delay: Double) -> Animation {
        .easeOut(duration: 0.6).delay(delay)
    }
}


