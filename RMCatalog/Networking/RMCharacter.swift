//
//  RMCharacter.swift
//  RMCatalog
//
//  Created by Horacio Guzman Parra on 19/02/22.
//

import Foundation

struct RMCharacter: Decodable {
    var id: Int
    var name: String
    var status: RMCharacterStatus
    var species: String
}
