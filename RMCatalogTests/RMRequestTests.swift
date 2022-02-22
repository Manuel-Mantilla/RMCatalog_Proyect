//
//  RMRequestTests.swift
//  RMCatalogUnitTests
//
//  Created by Horacio Guzman Parra on 19/02/22.
//

import XCTest
@testable import RMCatalog

class RMRequestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
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
            XCTAssertEqual(error.localizedDescription, "The page must be grater than 0")
        }
    }
    
}
