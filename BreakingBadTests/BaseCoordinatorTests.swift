//
//  BaseCoordinatorTests.swift
//  BreakingBadTests
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import XCTest
@testable import Breaking_Bad

private class TestBaseCoordinator: BaseCoordinator {
    
    var startCoordinatorCallCount: Int = 0
    var startCallCount: Int = 0
    var removeChildCallCount: Int = 0
    
    override func start(coordinator: Coordinator) {
        super.start(coordinator: coordinator)
        startCoordinatorCallCount += 1
    }
    
    override func start() {
        startCallCount += 1
    }
    
    override func removeChildCoordinators() {
        super.removeChildCoordinators()
        removeChildCallCount += 1
    }
    
}

class BaseCoordinatorTests: XCTestCase {
    
    var coordinator: BaseCoordinator!
    
    override func setUp() {
        super.setUp()
        coordinator = BaseCoordinator()
    }
    
    func test_start_callChildStart() {
        let anotherCoordinator = TestBaseCoordinator()
        coordinator.start(coordinator: anotherCoordinator)
        XCTAssertEqual(anotherCoordinator.startCallCount,1)
    }
    
    func test_start_setsParentCoordinator() {
        let anotherCoordinator = TestBaseCoordinator()
        coordinator.start(coordinator: anotherCoordinator)
        XCTAssertNotNil(anotherCoordinator.parentCoordinator)
        XCTAssert(anotherCoordinator.parentCoordinator === coordinator)
    }
    
    func test_start_addsChildCoordinator() {
        let anotherCoordinator = TestBaseCoordinator()
        coordinator.start(coordinator: anotherCoordinator)
        XCTAssertEqual(coordinator.childCoordinators.count,1)
        XCTAssert(coordinator.childCoordinators[0] === anotherCoordinator)
    }
    
    func test_removeChildCoordinators_callsRemoveOnChildren() {
        let anotherCoordinator = TestBaseCoordinator()
        coordinator.start(coordinator: anotherCoordinator)
        coordinator.removeChildCoordinators()
        XCTAssertEqual(anotherCoordinator.removeChildCallCount,1)
    }
    
    func test_removeChildCoordinators_emptysChildCoordinators() {
        let anotherCoordinator = TestBaseCoordinator()
        coordinator.start(coordinator: anotherCoordinator)
        XCTAssertEqual(coordinator.childCoordinators.count,1)
        coordinator.removeChildCoordinators()
        XCTAssertEqual(coordinator.childCoordinators.count,0)
    }
    
    func test_didFinish_removesCoordinator() {
        let anotherCoordinator = TestBaseCoordinator()
        let oneMoreCoordinator = TestBaseCoordinator()
        coordinator.start(coordinator: anotherCoordinator)
        coordinator.start(coordinator: oneMoreCoordinator)
        XCTAssertEqual(coordinator.childCoordinators.count,2)
        coordinator.didFinish(coordinator: anotherCoordinator)
        XCTAssertEqual(coordinator.childCoordinators.count,1)
        XCTAssert(coordinator.childCoordinators[0] === oneMoreCoordinator)
    }

}
