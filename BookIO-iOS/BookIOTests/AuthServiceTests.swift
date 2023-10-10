//
//  AuthServiceTests.swift
//  BookIOTests
//
//  Created by Robert Walker on 10/9/23.
//

import XCTest
@testable import BookIO

final class AuthServiceTests: XCTestCase {
    let mockHttp = MockJsonHttp()
    let mockKeychainHelper = MockKeychainHelper()
    let testCredentials = Credentials(username: "user", password: "pass")

    func testLogin() {
        mockHttp.postSuccess = true

        let authService = AuthService(jsonHttp: mockHttp, keychainHelper: mockKeychainHelper)

        let successExpectation = XCTestExpectation(description: "result should be success")

        Task {
            let result = await authService.loginWith(testCredentials)
            if result == .success {
                successExpectation.fulfill()
            }

            XCTAssert(mockKeychainHelper.savedCredentials?.username == "user")
            XCTAssert(mockKeychainHelper.savedCredentials?.password == "pass")
        }

        wait(for: [successExpectation], timeout: 1)
    }

    func testLoginFail() {
        mockHttp.postSuccess = false

        let authService = AuthService(jsonHttp: mockHttp, keychainHelper: mockKeychainHelper)

        let failureExpectation = XCTestExpectation(description: "result should be failure")

        Task {
            let result = await authService.loginWith(testCredentials)
            if result == .failure {
                failureExpectation.fulfill()
            }

            XCTAssert(mockKeychainHelper.savedCredentials == nil)
        }

        wait(for: [failureExpectation], timeout: 1)
    }

    func testCreateAccount() {
        mockHttp.postSuccess = true

        let authService = AuthService(jsonHttp: mockHttp, keychainHelper: mockKeychainHelper)

        let successExpectation = XCTestExpectation(description: "result should be success")

        Task {
            let result = await authService.createAccountWith(testCredentials)
            if result == .success {
                successExpectation.fulfill()
            }

            XCTAssert(mockKeychainHelper.savedCredentials?.username == "user")
            XCTAssert(mockKeychainHelper.savedCredentials?.password == "pass")
        }

        wait(for: [successExpectation], timeout: 1)
    }

    func testCreateAccountFail() {
        mockHttp.postSuccess = false

        let authService = AuthService(jsonHttp: mockHttp, keychainHelper: mockKeychainHelper)

        let failureExpectation = XCTestExpectation(description: "result should be failure")

        Task {
            let result = await authService.createAccountWith(testCredentials)
            if result == .failure {
                failureExpectation.fulfill()
            }

            XCTAssert(mockKeychainHelper.savedCredentials == nil)
        }

        wait(for: [failureExpectation], timeout: 1)
    }

    func testLogout() {
        mockKeychainHelper.savedCredentials = testCredentials

        let authService = AuthService(jsonHttp: mockHttp, keychainHelper: mockKeychainHelper)

        let logoutExpectation = XCTestExpectation(description: "credentials should be removed after logout")

        authService.logout()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if self.mockKeychainHelper.savedCredentials == nil {
                logoutExpectation.fulfill()
            }
        }

        wait(for: [logoutExpectation], timeout: 1)
    }
}
