import XCTest
import MainOffender

final class UnsendableClass {
	var value = 5
}

final class UnsafeBlockOperationTests: XCTestCase {
	func testUnsafeBlockOperation() async throws {
		let unsendable = UnsendableClass()
		let exp = expectation(description: "completed")

		let op = UnsafeBlockOperation {
			unsendable.value = 0
			exp.fulfill()
		}

		let queue = OperationQueue()

		queue.addOperation(op)

		await fulfillment(of: [exp], timeout: 1.0)

		XCTAssertEqual(unsendable.value, 0)
	}

	func testUnsafeBlock() async throws {
		let unsendable = UnsendableClass()

		let queue = OperationQueue()
		let exp = expectation(description: "completed")

		queue.addUnsafeOperation {
			unsendable.value = 0
			exp.fulfill()
		}

		await fulfillment(of: [exp], timeout: 1.0)

		XCTAssertEqual(unsendable.value, 0)
	}

	func testUnsafeBarrierBlock() async throws {
		let unsendable = UnsendableClass()

		let queue = OperationQueue()
		let exp = expectation(description: "completed")

		queue.addBarrierBlock {
			unsendable.value = 0
			exp.fulfill()
		}

		await fulfillment(of: [exp], timeout: 1.0)

		XCTAssertEqual(unsendable.value, 0)
	}
}
