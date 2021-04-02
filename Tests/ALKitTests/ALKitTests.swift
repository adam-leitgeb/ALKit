import XCTest
@testable import ALKit

final class ALKitTests: XCTestCase {
    
    // MARK: - Properties

    static var allTests = [
        ("testLocalizationResource", testLocalizationResource)
    ]
    
    // MARK: - Tests Resources
    
    // We are testing only one action, because all we want is to make sure
    // that Resources are linked properly.
    func testLocalizationResource() {
        XCTAssertEqual(UIAlertController.cameraAccessDenied.title, "Access denied")
        XCTAssertEqual(UIAlertAction.closeAction.title, "Close")
    }
}
