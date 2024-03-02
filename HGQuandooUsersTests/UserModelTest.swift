//
//  UserModelTest.swift
//
//
//  Created by Hugo Coutinho on 2024-02-29.
//

import XCTest
import Combine
import Users

@MainActor
class UserModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func test_shouldMatchName() async {
        // 1. GIVEN
        let expectedFirstName = "Leanne Graham"
        let expectedSecondName = "Ervin Howell"
        let sut: UserModel = makeSUT()
        let expectation = self.expectation(description: "UserModel")
        
        // 2. WHEN
        sut.$state
            .sink(receiveCompletion: {_ in }, receiveValue: { state in
                switch state {
                case .loaded:
                    expectation.fulfill()
                default:
                    print("loading")
                }
            })
            .store(in: &cancellables)
        
        await fulfillment(of: [expectation], timeout: 10)
        
        // 3. THEN
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.users.count, 10)
        XCTAssertEqual(sut.users.first?.name, expectedFirstName)
        XCTAssertEqual(sut.users[1].name, expectedSecondName)
    }
}

// MARK: - MAKE SUT -
extension UserModelTests {
    private func makeSUT() -> UserModel {
        let baseRequestSpy = BaseRequestSuccessHandlerSpy(service: .users)
        let service = UserService(baseRequest: baseRequestSpy)
        return UserModel(service: service)
    }
    
    private func makeSUTErrorHandler() -> UserModel {
        let baseRequestSpy = BaseRequestErrorHandlerSpy()
        let service = UserService(baseRequest: baseRequestSpy)
        return UserModel(service: service)
    }
}

