import XCTest
import MainOffender

final class AsyncAdditionTests: XCTestCase {
	@MainActor
	func testRunLoopTurn() async {
		var value = 0

		await MainActor.run {
			RunLoop.current.perform {
				MainActor.assumeIsolated {
					value = 1
				}
			}
		}

		await RunLoop.turn(isolation: MainActor.shared)

		XCTAssertEqual(value, 1)
	}
}
