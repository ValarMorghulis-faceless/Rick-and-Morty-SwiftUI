//
//  CharacterListTests.swift
//  Rick and MortyTests
//
//  Created by Giorgi Samkharadze on 14.02.24.
//

import XCTest
@testable import Rick_and_Morty

final class CharacterListTests: XCTestCase {
    
    var sut: RemoteCharacterListDataSource?
    var characterListData: Data?

    override func setUpWithError() throws {
        if let url = Bundle.main.url(forResource: "CharacterList", withExtension: "json") {
            do {
                characterListData = try Data(contentsOf: url)
            } catch {
                print("Error reading data")
            }
        } else {
            print("JSON file not found in the main Bundle.")
        }
        sut = RemoteCharacterListDataSource(requester: NetworkRequesterFactory.default)
    }

    override func tearDownWithError() throws {
        sut = nil
        characterListData = nil
    }

    func testDecodeCharacterListInfo()  {
        guard let characterList = characterListData else { return }
       let result = sut?.mapResponse(from: characterList)
        switch result {
        case .success(let data):
            XCTAssertTrue(data.info.count == 826)
        case .failure(let error):
            XCTFail("Expected a failure result, but got \(String(describing: result))")
        default:
            break
        }
    }
    
    func testDecodedCharacterInfo() {
        guard let characterList = characterListData else { return }
        let result = sut?.mapResponse(from: characterList)
        switch result {
        case .success(let data):
            XCTAssertTrue(data.results[0].id == 21)
        case .failure(let error):
            XCTFail("Expected a failure result, but got \(String(describing: result))")
        default: break
        }
    }

}

