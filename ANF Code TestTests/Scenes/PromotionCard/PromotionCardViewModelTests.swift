//
//  PromotionCardViewModelTests.swift
//  ANF Code Test
//
//  Created by Evens Taian on 29/01/25.
//

import XCTest
@testable import ANF_Code_Test

class PromotionCardViewModelTests: XCTestCase {
    var sut: PromotionCardViewModel!
    var mockService: MockPromotionCardService!
    
    override func setUp() {
        super.setUp()
        mockService = MockPromotionCardService()
        sut = PromotionCardViewModel(service: mockService)
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }
    
    func testGetImage() {
        // Given
        let expectation = XCTestExpectation(description: "Get image completion called")
        let mockImage = UIImage()
        let imageURL = "promotion_banner.jpg"
        mockService.mockImage = mockImage
        
        // When
        sut.getImage(urlString: imageURL) { image in
            // Then
            XCTAssertNotNil(image)
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(mockService.getImageCalled)
        XCTAssertEqual(mockService.mockImageURL, imageURL)
    }
    
    func testConfigureAndGetContent() {
        // Given
        let mockContent = Content(
            elementType: "hyperlink",
            target: "https://www.abercrombie.com/shop/us/mens-new-arrivals",
            title: "Shop Men"
        )
        let mockExplore = Explore(
            title: "TOPS STARTING AT $12",
            backgroundImage: "anf-20160527-app-m-shirts.jpg",
            content: [mockContent],
            promoMessage: "USE CODE: 12345",
            topDescription: "A&F ESSENTIALS",
            bottomDescription: "*In stores & online. Exclusions apply."
        )
        
        // When
        sut.configure(with: mockExplore)
        let retrievedContent = sut.getContent(at: 0)
        
        // Then
        XCTAssertNotNil(retrievedContent)
        XCTAssertEqual(retrievedContent?.elementType, "hyperlink")
        XCTAssertEqual(retrievedContent?.target, "https://www.abercrombie.com/shop/us/mens-new-arrivals")
        XCTAssertEqual(retrievedContent?.title, "Shop Men")
    }
    
    func testGetContentWithInvalidIndex() {
        // Given
        let mockContent = Content(
            elementType: "hyperlink",
            target: "https://www.abercrombie.com/shop/us/mens-new-arrivals",
            title: "Shop Men"
        )
        let mockExplore = Explore(
            title: "TOPS STARTING AT $12",
            backgroundImage: "anf-20160527-app-m-shirts.jpg",
            content: [mockContent],
            promoMessage: nil,
            topDescription: nil,
            bottomDescription: nil
        )
        sut.configure(with: mockExplore)
        
        // When & Then
        XCTAssertNil(sut.getContent(at: -1), "Should return nil for negative index")
        XCTAssertNil(sut.getContent(at: 1), "Should return nil for out of bounds index")
    }
    
    func testGetContentWithoutConfiguration() {
        // When & Then
        XCTAssertNil(sut.getContent(at: 0), "Should return nil when explore is not configured")
    }
}

class MockPromotionCardService: PromotionCardServicing {
    var API: APIRequesting = MockApiRequests()
    
    var getImageCalled = false
    var mockImage: UIImage?
    var mockImageURL: String?
    
    func getImage(url: String, completion: @escaping (UIImage) -> Void) {
        getImageCalled = true
        mockImageURL = url
        if let image = mockImage {
            completion(image)
        }
    }
}
