//
//  VendorInstructions.swift
//  PCD
//
//  Created by Prashant Janardhan Shejwal on 06/06/25.
//

import Foundation

struct VendorInstruction: Codable, Identifiable {
    var id = UUID()
    var title: String
    var urlString: String? = nil
}

let vendorInstructions: [VendorInstruction] = [
    .init(title: "Please enter your Vendor or External User ID exactly as provided."),
    .init(title: "Use the temporary password: Rules@1234 to log in for the first time."),
    .init(title: "If you encounter an error such as 'Information was not recognized' or 'Account was locked', kindly contact support at ssdproc@gmail.com."),
    .init(title: "If you have forgotten your password, please click the link below to reset it.", urlString:  "https://www.google.com")
]
