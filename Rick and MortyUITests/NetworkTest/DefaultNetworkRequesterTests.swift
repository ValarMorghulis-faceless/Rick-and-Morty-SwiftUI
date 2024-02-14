//
//  DefaultNetworkRequesterTests.swift
//  Rick and MortyTests
//
//  Created by Giorgi Samkharadze on 14.02.24.
//

import XCTest
@testable import Rick_and_Morty

class DefaultNetworkRequesterTests: XCTestCase {
    var networkRequester: DefaultNetworkRequester!
    var mockSession: MockURLSession!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockSession = MockURLSession()
        networkRequester = DefaultNetworkRequester(session: mockSession)
    }

    override func tearDownWithError() throws {
        mockSession = nil
        networkRequester = nil
        try super.tearDownWithError()
    }

    func testSuccessfulRequest() async throws {
        // Given
        let responseData = Data("Test data".utf8)
        let urlResponse = HTTPURLResponse(url: .mockCharacterURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
        mockSession.stubbedDataResult = (responseData, urlResponse)

        // When
        let target = URLNetworkTargetType(url: URL(string: "https://example.com")!)
        let result = try await networkRequester.request(targetType: target)

        // Then
        XCTAssertEqual(result, responseData)
    }

//    func testUnsuccessfulRequest() async {
//        // Given
//        let urlResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
//        mockSession.stubbedDataResult = (Data(), urlResponse)
//
//        let error = await networkRequester.request(targetType: URLNetworkTargetType(url: .mockCharacterURL))
//
//        XCTAssertThrowsError(error)
//        // When/Then
//
//    }
}

class MockURLSession: URLSessionProtocol {
    var stubbedDataResult: (Data, URLResponse)?
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        guard let stubbedDataResult = stubbedDataResult else {
            throw NetworkRequestError.error
        }
        return stubbedDataResult
    }
}
