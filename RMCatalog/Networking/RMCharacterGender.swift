//
//  RMCharacterGender.swift
//  RMCatalog
//
//  Created by Horacio Guzman Parra on 19/02/22.
//

import Foundation

enum RMCharacterGender: String, Decodable, CaseIterable {
    case female
    case male
    case genderless
    case unknown
}
