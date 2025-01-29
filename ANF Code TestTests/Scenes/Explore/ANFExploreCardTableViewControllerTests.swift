//
//  ANF_Code_TestTests.swift
//  ANF Code TestTests
//

import XCTest
@testable import ANF_Code_Test

class ANFExploreCardTableViewControllerTests: XCTestCase {

    var testInstance: ANFExploreCardTableViewController!
    var mockViewModel: MockExploreViewModel!
    let mockData = [
        Explore(
            title: "Test Title",
            backgroundImage: "test_image",
            content: [Content(elementType: "link", target: "test_target", title: "Test Content")],
            promoMessage: "Test Promo Message",
            topDescription: "Test Top Description",
            bottomDescription: "Test Bottom Description"
        )
    ]
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Explore", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ANFExploreCardTableViewController") as? ANFExploreCardTableViewController else {
            XCTFail("Could not instantiate ANFExploreCardTableViewController from storyboard")
            return
        }
        
        testInstance = viewController
        viewController.loadViewIfNeeded()
        
        mockViewModel = MockExploreViewModel()
        mockViewModel.mockExploreData = mockData
        testInstance.viewModel = mockViewModel
        
        testInstance.viewDidLoad()
    }

    func test_numberOfSections_ShouldBeOne() {
        let numberOfSections = testInstance.numberOfSections(in: testInstance.tableView)
        XCTAssert(numberOfSections == 1, "table view should have 1 section")
    }
    
    func test_numberOfRows_ShouldMatchExploreDataCount() {
        testInstance.viewDidLoad()
        
        RunLoop.main.run(until: Date())
        
        let numberOfRows = testInstance.tableView(testInstance.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, mockData.count, "table view should have same number of rows as exploreData items")
    }
    
    func test_cellForRowAtIndexPath_titleText_shouldMatchExploreData() {
        let firstCell = testInstance.tableView(testInstance.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let title = firstCell.viewWithTag(1) as? UILabel
        XCTAssertEqual(title?.text, "Test Title", "title should match explore data")
    }
    
    func test_cellForRowAtIndexPath_ImageViewImage_shouldCallGetImage() {
        let firstCell = testInstance.tableView(testInstance.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        _ = firstCell.viewWithTag(2) as? UIImageView
        XCTAssertTrue(mockViewModel.getImageCalled, "getImage should be called")
    }
    
    func test_viewDidLoad_shouldCallViewModelViewDidLoad() {
        testInstance.viewDidLoad()
        XCTAssertTrue(mockViewModel.viewDidLoadCalled, "viewDidLoad should be called on viewModel")
    }
}

class MockExploreViewModel: ExploreViewmodeling {
    var updateData: (([Explore]) -> Void)?
    var onRequestError: ((String) -> Void)?
    var getImageCalled = false
    var viewDidLoadCalled = false
    var mockExploreData: [Explore] = []
    
    func viewDidLoad() {
        viewDidLoadCalled = true

        if let update = updateData {
            update(mockExploreData)
        }
    }
    
    func getImage(urlString: String, completion: @escaping (UIImage) -> Void) {
        getImageCalled = true
        completion(UIImage())
    }
}
