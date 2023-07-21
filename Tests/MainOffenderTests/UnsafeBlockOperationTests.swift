import XCTest
import MainOffender

final class UnsendableClass {
	var value = 5
}

final class UnsafeBlockOperationTests: XCTestCase {
	func testUnsafeBlock() throws {
		let unsendable = UnsendableClass()

		let op = UnsafeBlockOperation {
			unsendable.value = 0
		}

		let queue = OperationQueue()

		queue.addOperation(op)

		queue.waitUntilAllOperationsAreFinished()

		XCTAssertEqual(unsendable.value, 0)
	}
}
