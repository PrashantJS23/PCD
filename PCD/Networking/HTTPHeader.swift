//
//  HTTPHeader.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 05/06/25.
//

import Foundation

struct HTTPHeader {
    static let contentType = "Content-Type"
    static let accept = "Accept"
    static let authorization = "Authorization"

    struct Value {
        static let json = "application/json"
        static let xml = "application/xml"
        static let formURLEncoded = "application/x-www-form-urlencoded"
    }
}
