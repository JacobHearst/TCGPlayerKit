//
//  File.swift
//  
//
//  Created by Jacob Hearst on 12/10/21.
//

import Foundation

public struct ProductPriceInfo: Decodable {
    public let productId: Int
    public let lowPrice: Double?
    public let midPrice: Double?
    public let highPrice: Double?
    public let marketPrice: Double?
    public let directLowPrice: Double?
    public let subTypeName: String
}

public struct ProductMarketPriceResponse: Decodable {
    public let success: Bool
    public let errors: [String]
    public let results: [ProductPriceInfo]
}

struct BearerToken: Decodable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let userName: String
    let issued: String
    let expires: String

    enum CodingKeys: String, CodingKey {
        case accessToken, tokenType, expiresIn, userName 
        case issued = ".issued"
        case expires = ".expires"
    }
}
