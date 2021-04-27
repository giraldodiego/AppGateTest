import XCTest
@testable import AppGate

final class AppGateTests: XCTestCase {
    func testAppGate() {
        let appGate = AppGate()
        
        // User creation
        let user = User(username: "diegoagg95@gmail.com", password: "12345")
        appGate.createUser(user)
        
        // Username and password string validations
        XCTAssertTrue(user.isValidEmail())
        XCTAssertFalse(user.isValidPassword())
        
        // User validation, it will always come false in tests because there aren't Keychain entitlements
        XCTAssertFalse(UserManager().validateUser(user: user, date: Date()))
        
        // Get validations from CoreData
        print(appGate.getValidations(user.username) ?? "")
    }

    static var allTests = [
        ("testAppGate", testAppGate),
    ]
}
