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
        XCTAssertFalse(signInViewModel.isValidCredentials(username: "a", password: "TestPass123"))
    }

    func testFailingLoginPassword() {
            XCTAssertFalse(signInViewModel.isValidCredentials(username: "a", password: "TestPass123"))
    }

    func testFailingLoginEmpty() {
                XCTAssertFalse(signInViewModel.isValidCredentials(username: "", password: ""))
    }

    func testLoginPass() {
        signInViewModel.loginUser(username: "Admin", password: "TestPass123")
    }

    func testLoginFail() {
        signInViewModel.loginUser(username: "a", password: "t")
    }
}

class MockViewModelDelegate: SignInViewModelDelegate {
    var isSuccesRouting = false
    var isError = false

    func successRouting() {
        isSuccesRouting = true
    }
    func showError(errorMessage error: String) {
        isError = true
    }
}
