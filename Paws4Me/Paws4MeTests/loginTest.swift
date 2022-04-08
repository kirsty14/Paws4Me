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
    private var mockViewModelDelegate: MockViewModelDelegate!

    override func setUp() {
        super.setUp()
        mockViewModelDelegate = MockViewModelDelegate()
        self.signInViewModel = SignInViewModel(delegate: MockViewModelDelegate())
    }

    func testFailingLoginEmptyFail() {
        signInViewModel.loginUser(username: "", password: "")
        mockViewModelDelegate.showError(errorMessage: "Please fill in your username and password")
        XCTAssertFalse(mockViewModelDelegate.isSuccesRouting)
        XCTAssertTrue(mockViewModelDelegate.isError)
    }

    func testFailingWrongUsernameFail() {
        signInViewModel.loginUser(username: "a", password: "TestPass123")
        mockViewModelDelegate.showError(errorMessage: "Login Error")
        XCTAssertFalse(mockViewModelDelegate.isSuccesRouting)
        XCTAssertTrue(mockViewModelDelegate.isError)
    }

    func testFailingWrongPasswrdFail() {
        signInViewModel.loginUser(username: "Admin", password: "t")
        mockViewModelDelegate.showError(errorMessage: "Login Error")
        XCTAssertFalse(mockViewModelDelegate.isSuccesRouting)
        XCTAssertTrue(mockViewModelDelegate.isError)
    }

    func testLoginWrongUsernamePasswordFail() {
        signInViewModel.loginUser(username: "a", password: "t")
        mockViewModelDelegate.showError(errorMessage: "Login Error")
        XCTAssertFalse(mockViewModelDelegate.isSuccesRouting)
        XCTAssertTrue(mockViewModelDelegate.isError)
    }

    func testLoginCorrectUsernamePasswordPass() {
        signInViewModel.loginUser(username: "Admin", password: "TestPass123")
        mockViewModelDelegate.successRouting()
        XCTAssert(mockViewModelDelegate.isSuccesRouting)
        XCTAssertFalse(mockViewModelDelegate.isError)
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
