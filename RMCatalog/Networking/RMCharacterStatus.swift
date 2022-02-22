//
//  RMCharacterStatus.swift
//  RMCatalog
//
//  Created by Horacio Guzman Parra on 19/02/22.
//

import Foundation

enum RMCharacterStatus: String, Decodable, CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
