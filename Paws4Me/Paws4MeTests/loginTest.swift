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
        mockViewModelDelegate = MockViewModelDelegate()
        self.signInViewModel = SignInViewModel(delegate: mockViewModelDelegate)
    }

    func testFailingLoginEmptyFail() {
        signInViewModel.loginUser(username: "", password: "")
        XCTAssertFalse(mockViewModelDelegate.isSuccesRouting)
        XCTAssertTrue(mockViewModelDelegate.isError)
    }

    func testFailingWrongUsernameFail() {
        signInViewModel.loginUser(username: "a", password: "TestPass123")
        XCTAssertFalse(mockViewModelDelegate.isSuccesRouting)
        XCTAssertTrue(mockViewModelDelegate.isError)
    }

    func testFailingWrongPasswrdFail() {
        signInViewModel.loginUser(username: "Admin", password: "t")
        XCTAssertFalse(mockViewModelDelegate.isSuccesRouting)
        XCTAssertTrue(mockViewModelDelegate.isError)
    }

    func testLoginWrongUsernamePasswordFail() {
        signInViewModel.loginUser(username: "a", password: "t")
        XCTAssertFalse(mockViewModelDelegate.isSuccesRouting)
        XCTAssertTrue(mockViewModelDelegate.isError)
    }

    func testLoginCorrectUsernamePasswordPass() {
        signInViewModel.loginUser(username: "Admin", password: "TestPass123")
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
