//
//  Paws4MeTests.swift
//  Paws4MeTests
//
//  Created by Kirsty-Lee Walker on 2022/02/23.
//

import XCTest
@testable import Paws4Me

struct SavedUserObject {
    let email: String?
    var password: String?
}

class LoginTest: XCTestCase {

    private var signInViewModel: SignInViewModel!
    private var mockViewModelDelegate: MockViewModelDelegate!
    private var mockSignInRepository: MockSignInRepository!

    override func setUp() {
        mockViewModelDelegate = MockViewModelDelegate()
        mockSignInRepository = MockSignInRepository()
        self.signInViewModel = SignInViewModel(delegate: mockViewModelDelegate, signInRepository: mockSignInRepository)
    }

    func testFailingLoginEmptyFail() {
        signInViewModel.loginUser(email: "", password: "")
        XCTAssertFalse(mockViewModelDelegate.isSuccesRouting)
        XCTAssertTrue(mockViewModelDelegate.isError)
    }

    func testFailingWrongEmailFail() {
        signInViewModel.loginUser(email: "g@gmail.com", password: "123456")
        XCTAssertFalse(mockViewModelDelegate.isSuccesRouting)
        XCTAssertTrue(mockViewModelDelegate.isError)
    }

    func testFailingWrongPasswordFail() {
        signInViewModel.loginUser(email: "k@gmail.com", password: "t")
        XCTAssertFalse(mockViewModelDelegate.isSuccesRouting)
        XCTAssertTrue(mockViewModelDelegate.isError)
    }

    func testLoginWrongEmailPasswordFail() {
        signInViewModel.loginUser(email: "g@gmail.com", password: "t")
        XCTAssertFalse(mockViewModelDelegate.isSuccesRouting)
        XCTAssertTrue(mockViewModelDelegate.isError)
    }

    func testLoginCorrectEmailPasswordPass() {
        signInViewModel.loginUser(email: "k@gmail.com", password: "123456")
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

class MockSignInRepository: SignInRepository {
    override func signInUser(email: String, password: String, completionHandler: @escaping SignInResult) {
        if email == "k@gmail.com" && password == "123456" {
            completionHandler(.success(true))
        } else {
            completionHandler(.failure(.serverError))
        }
    }
}
