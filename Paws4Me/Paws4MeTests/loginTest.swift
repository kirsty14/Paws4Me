//
//  Paws4MeTests.swift
//  Paws4MeTests
//
//  Created by Kirsty-Lee Walker on 2022/02/23.
//

import XCTest
@testable import Paws4Me

class LoginTest: XCTestCase {

    private var signInViewModel: SignInViewModel!
    private weak var mockViewModelDelegate: MockViewModelDelegate!

    override func setUp() {
        super.setUp()
        self.signInViewModel = SignInViewModel(delegate: MockViewModelDelegate())
    }

    func testPassingLogin() {
        XCTAssertTrue(signInViewModel.isValidCredentials(username: "Admin", password: "TestPass123"))
    }

    func testFailingLoginUsername() {
        let result = signInViewModel.isValidCredentials(username: "a", password: "TestPass123")
        XCTAssertEqual(result, false)
    }

    func testFailingLoginPassword() {
        let result = signInViewModel.isValidCredentials(username: "Admin", password: "t")
        XCTAssertEqual(result, false)
    }

    func testFailingLoginEmpty() {
        let result = signInViewModel.isValidCredentials(username: "", password: "")
        XCTAssertEqual(result, false)
    }
}

class MockViewModelDelegate: SignInViewModelDelegate {
    func successRouting() {
    }
    func showError(errorMessage error: String) {
    }
}
