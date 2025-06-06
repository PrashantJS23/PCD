//
//  Item.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 27/05/25.
//

import Foundation

struct Announcement: Codable, Identifiable {
    var id: Int
    var title: String
    var description: String
    var createdAt: String
    var link: String
    var isActive: Bool
    var type: String
}
