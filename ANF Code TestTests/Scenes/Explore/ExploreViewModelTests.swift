//
//  ExploreViewModelTests.swift
//  ANF Code Test
//
//  Created by Evens Taian on 29/01/25.
//

import XCTest
@testable import ANF_Code_Test

class ExploreViewModelTests: XCTestCase {
    var sut: ExploreViewModel!
    var mockService: MockExploreService!
    
    override func setUp() {
        super.setUp()
        mockService = MockExploreService()
        sut = ExploreViewModel(service: mockService)
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }
    
    func testViewDidLoadCallsGetExploreData() {
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockService.getExploreDataCalled)
    }
    
    func testGetExploreDataSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Update data called")
        let mockContent = [
            Content(elementType: "button",
                   target: "store",
                   title: "Shop Now")
        ]
        let mockData = [
            Explore(title: "Summer Collection",
                   backgroundImage: "summer.jpg",
                   content: mockContent,
                   promoMessage: "30% OFF",
                   topDescription: "New Arrivals",
                   bottomDescription: "Limited Time")
        ]
        mockService.mockExploreData = .success(mockData)
        
        sut.updateData = { data in
            // Then
            XCTAssertEqual(data.count, 1)
            XCTAssertEqual(data.first?.title, "Summer Collection")
            XCTAssertEqual(data.first?.backgroundImage, "summer.jpg")
            XCTAssertEqual(data.first?.promoMessage, "30% OFF")
            XCTAssertEqual(data.first?.topDescription, "New Arrivals")
            XCTAssertEqual(data.first?.bottomDescription, "Limited Time")
            
            // Verify content
            XCTAssertEqual(data.first?.content?.count, 1)
            XCTAssertEqual(data.first?.content?.first?.elementType, "button")
            XCTAssertEqual(data.first?.content?.first?.target, "store")
            XCTAssertEqual(data.first?.content?.first?.title, "Shop Now")
            
            expectation.fulfill()
        }
        
        // When
        sut.viewDidLoad()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetExploreDataFailureNoConnection() {
        // Given
        let expectation = XCTestExpectation(description: "Error callback called")
        mockService.mockExploreData = .failure(.noConnection)
        
        sut.onRequestError = { error in
            XCTAssertEqual(error, "No internet connection. Please check your network and try again.")
            expectation.fulfill()
        }
        
        // When
        sut.viewDidLoad()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetExploreDataFailureNotFound() {
        // Given
        let expectation = XCTestExpectation(description: "Error callback called")
        mockService.mockExploreData = .failure(.notFound)
        
        sut.onRequestError = { error in
            XCTAssertEqual(error, "Explore data not found. Please try again later.")
            expectation.fulfill()
        }
        
        // When
        sut.viewDidLoad()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetImage() {
        // Given
        let expectation = XCTestExpectation(description: "Get image completion called")
        let mockImage = UIImage()
        mockService.mockImage = mockImage
        
        // When
        sut.getImage(urlString: "test.jpg") { image in
            // Then
            XCTAssertNotNil(image)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(mockService.getImageCalled)
    }
}

class MockExploreService: ExploreServicing {
    var API: APIRequesting = MockApiRequests()
    
    var getExploreDataCalled = false
    var getImageCalled = false
    var mockExploreData: Result<[Explore], NetworkErrors>?
    var mockImage: UIImage?
    
    func getExploreData(completion: @escaping (Result<[Explore], NetworkErrors>) -> Void) {
        getExploreDataCalled = true
        if let mockResult = mockExploreData {
            completion(mockResult)
        }
    }
    
    func getImage(url: String, completion: @escaping (UIImage) -> Void) {
        getImageCalled = true
        if let image = mockImage {
            completion(image)
        }
    }
}

