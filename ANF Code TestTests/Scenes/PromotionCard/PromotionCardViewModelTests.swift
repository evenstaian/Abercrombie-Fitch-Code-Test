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
