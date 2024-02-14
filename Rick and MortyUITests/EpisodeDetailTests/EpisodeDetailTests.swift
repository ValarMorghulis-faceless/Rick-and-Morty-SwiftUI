//
//  EpisodeDetailTests.swift
//  Rick and MortyTests
//
//  Created by Giorgi Samkharadze on 14.02.24.
//

import XCTest
@testable import Rick_and_Morty

final class EpisodeDetailTests: XCTestCase {
    
    var sut: RemoteEpisodeListDataSource?
    var episodeListData: Data?

    override func setUpWithError() throws {
        if let url = Bundle.main.url(forResource: "CharacterList", withExtension: "json") {
            do {
                episodeListData = try Data(contentsOf: url)
            } catch {
                print("Error reading data")
            }
        } else {
            print("JSON file not found in the main Bundle.")
        }
        
        sut = RemoteEpisodeListDataSource(requester: NetworkRequesterFactory.default)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        episodeListData = nil 
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEpisodeListInfoDecodeExample() throws {
        guard let episodeData = episodeListData else { return }
        let result = sut?.mapResponse(from: episodeData)
        switch result {
        case .success(let data):
            XCTAssertTrue(data.info.count == 51)
        case .failure(let error):
            XCTFail("Failed to decode json to EpisodeListInfoData")
        default:
            break
        }
    }

    func testEpisodeDetailDecodeExample() throws {
        guard let episodeData = episodeListData else { return }
        let result = sut?.mapResponse(from: episodeData)
        switch result {
        case .success(let data):
            XCTAssertTrue(data.results[0].episode == "S01E01")
        case .failure(let error):
            XCTFail("Failed to decode json to EpisodeListInfoData")
        default:
            break
        }
    }

}
