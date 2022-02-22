//
//  RMRequest.swift
//  RMCatalog
//
//  Created by Horacio Guzman Parra on 19/02/22.
//

import Foundation

enum RMRequest {
    
    case allCharacters(Int)
    case character(Int)
    case multipleCharacter([Int])
    case filterCharactes([RMCharacterFilterKey: String])
    
    func endpoint() throws -> String {
        switch self {
            case .allCharacters(let page):
                guard page > 0 else {
                    throw RMError.endpointBadRequest("The page must be grater than 0")
                }
                return "character/?page=\(page)"
            case .character(let id):
                guard id > 0 else {
                    throw RMError.endpointBadRequest("The id must be greater than 0")
                }
                return "character/\(id)"
            case .multipleCharacter(let array):
                guard !array.isEmpty else {
                    throw RMError.endpointBadRequest("The array must not be empty")
                }
                return "character/\(array)"
            case .filterCharactes(let dictionary):
                guard !dictionary.isEmpty else {
                    throw RMError.endpointBadRequest("The dictionary must not be empty")
                }
                for key in dictionary.keys {
                    guard key == .gender,
                          let value = dictionary[key],
                          let _ = RMCharacterGender(rawValue: value) else {
                              let cases = RMCharacterGender.allCases.reduce("") { partialResult, gender in
                                  return partialResult + "," + gender.rawValue
                              }
                              throw RMError.endpointBadRequest("The value for gender must be \(cases)")
                          }
                    guard key == .status,
                          let value = dictionary[key],
                          let _ = RMCharacterStatus(rawValue: value) else {
                              let cases = RMCharacterStatus.allCases.reduce("") { partialResult, status in
                                  return partialResult + "," + status.rawValue
                              }
                              throw RMError.endpointBadRequest("The value for status must be \(cases)")
                          }
                    guard (key == .name || key == .type || key == .species),
                          let value = dictionary[key],
                          !value.isEmpty else {
                              throw RMError.endpointBadRequest("The \(key.rawValue) must not be empty")
                          }
                }
                return "TODO"
        }
    }
}
