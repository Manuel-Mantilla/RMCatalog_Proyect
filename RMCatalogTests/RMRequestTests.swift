//
//  RMRequestTests.swift
//  RMCatalogUnitTests
//
//  Created by Horacio Guzman Parra on 19/02/22.
//

import XCTest
@testable import RMCatalog

class RMRequestTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_RMRequest_allCharactersSucced() {
        // Given
        let expectedPage = 3
        let allCharactersRequest = RMRequest.allCharacters(expectedPage)
        // When
        let expectedDomain = try! allCharactersRequest.endpoint()
        // Then
        XCTAssertEqual(expectedDomain, "character/?page=\(expectedPage)")
    }
    
    func test_RMRequest_allCharactersError() {
        // Given
        let expectedPage = -1
        let allCharactersRequest = RMRequest.allCharacters(expectedPage)
        // When
        do {
            let _ = try allCharactersRequest.endpoint()
        } catch {
            //Then
            XCTAssertEqual(error.localizedDescription, "The page must be grater than 0")
        }
    }
    
    func test_RMRequest_characterSucced() {
        //Given
        let expectedId = 2
        let characterRequest = RMRequest.character(expectedId)
        //When
        let expectedDomain = try! characterRequest.endpoint()
        //Then
        XCTAssertEqual(expectedDomain, "character/\(expectedId)")
    }
    
    func test_RMRequest_characterError() {
        //Given
        let expectedID = -1
        let characterRequest = RMRequest.character(expectedID)
        //When
        do {
            let _ = try characterRequest.endpoint()
        } catch {
            //Then
            XCTAssertEqual(error.localizedDescription, "The id must be greater than 0")
        }
    }
    
    func test_RMRequest_multipleCharacterSucced() {
        //Given
        let expectedArray = [1,2,3]
        let multipleCharacterRequest = RMRequest.multipleCharacter(expectedArray)
        //When
        let expectedDomain = try! multipleCharacterRequest.endpoint()
        //Then
        XCTAssertEqual(expectedDomain, "character/\(expectedArray)")
    }
    
    func test_RMRequest_multipleCharacterError() {
        //Given
        let expectedArray: [Int] = []
        let multipleCharacterRequest = RMRequest.multipleCharacter(expectedArray)
        //When
        do {
            _ = try multipleCharacterRequest.endpoint()
        } catch {
            //Then
            XCTAssertEqual(error.localizedDescription, "The array must not be empty")
        }
    }
    
    func test_RMRequest_filterCharacterError() {
        //Given
        let expectedDictionary = [RMCharacterFilterKey: String]()
        let filterCharacterRequest = RMRequest.filterCharactes(expectedDictionary)
        //When
        do {
            let _ = try filterCharacterRequest.endpoint()
        } catch {
            //Then
            XCTAssertEqual(error.localizedDescription, "The dictionary must not be empty")
        }
    }
    
    func test_RMRequest_filterCharacterInvalidKey() {
        //Given
        let expectedDictionary = [RMCharacterFilterKey.status: "Not dead"]
        let filterCharacterRequest = RMRequest.filterCharactes(expectedDictionary)
        //When
        do {
            let _ = try filterCharacterRequest.endpoint()
        } catch {
            //Then
            XCTAssertEqual(error.localizedDescription, "The value for gender must be ,female,male,genderless,unknown")
        }
    }
    
    func test_RMRequest_filterCharacterGender() {
        //Given
        let expectedDictionary = [RMCharacterFilterKey.status: "Alive"]
        let filterCharacterRequest = RMRequest.filterCharactes(expectedDictionary)
        //When
        let expectedDomain = try! filterCharacterRequest.endpoint()
        //Then
        XCTAssertEqual(expectedDomain, "")
    }
    
}
