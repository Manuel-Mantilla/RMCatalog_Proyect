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
                    guard let value = dictionary[key] else {
                        fatalError("There is no value for that key")
                    }
                    guard key == .gender,
                          let _ = RMCharacterGender(rawValue: value) else {
                              let cases = RMCharacterGender.allCases.reduce("") { partialResult, gender in
                                  return partialResult + "," + gender.rawValue
                              }
                              throw RMError.endpointBadRequest("The value for gender must be \(cases)")
                          }
                    guard key == .status,
                          let _ = RMCharacterStatus(rawValue: value) else {
                              let cases = RMCharacterStatus.allCases.reduce("") { partialResult, status in
                                  return partialResult + "," + status.rawValue
                              }
                              throw RMError.endpointBadRequest("The value for status must be \(cases)")
                          }
                    guard (key == .name || key == .type || key == .species),
                          !value.isEmpty else {
                              throw RMError.endpointBadRequest("The \(key.rawValue) must not be empty")
                          }
                    //Falta un return para los Key?
                }
                var components = URLComponents()
                
                let items = dictionary.map { URLQueryItem(name: $0.rawValue, value: $1) }
                components.queryItems = items
                
                guard let query = components.query else {
                    fatalError("Something weird happend")
                }
                
                return "character/?\(query)"
        }
    }
}
