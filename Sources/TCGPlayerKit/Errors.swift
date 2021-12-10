//
//  File.swift
//  
//
//  Created by Jacob Hearst on 12/10/21.
//

import Foundation

enum TCGPlayerKitError: Error, CustomStringConvertible {
    case networkingError(String)
    case emptyIds

    var description: String {
        switch self {
        case .networkingError(let description):
            return "Networking error: \(description)"
        case .emptyIds:
            return "Received an empty list of ids to get data for"
        }
    }
}
