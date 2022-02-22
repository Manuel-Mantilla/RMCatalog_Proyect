//
//  RMError.swift
//  RMCatalog
//
//  Created by Horacio Guzman Parra on 19/02/22.
//

import Foundation

enum RMError: Error {
    case endpointBadRequest(String)
}

extension RMError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
            case .endpointBadRequest(let description):
                return description
        }
    }
}
