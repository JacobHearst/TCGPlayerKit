//
//  File.swift
//  
//
//  Created by Jacob Hearst on 11/30/21.
//

import Foundation

public struct TCGPlayerDeveloperCreds {
    public let appID: Int
    public let publicKey: String
    public let privateKey: String
    public let userAgentHeader: String

    public init(appID: Int, publicKey: String, privateKey: String, userAgentHeader: String) {
        self.appID = appID
        self.publicKey = publicKey
        self.privateKey = privateKey
        self.userAgentHeader = userAgentHeader
    }
}
