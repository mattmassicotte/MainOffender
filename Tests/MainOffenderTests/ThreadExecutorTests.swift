import XCTest
import MainOffender

actor ThreadActor {
	private let executor = ThreadExecutor(name: "my thread")

	nonisolated var unownedExecutor: UnownedSerialExecutor {
		executor.asUnownedSerialExecutor()
	}

	var threadhHashValue: Int {
		Thread.current.hashValue
	}
}

final class ThreadExecutorTests: XCTestCase {
	func testConsistentThread() async {
		let actor = ThreadActor()
		let initial = await actor.threadhHashValue

		XCTAssertNotEqual(initial, Thread.current.hashValue)

		for _ in 0..<1000 {
			let value = await actor.threadhHashValue

			XCTAssertEqual(value, initial)
		}
	}
}
