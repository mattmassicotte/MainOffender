import XCTest
import MainOffender

final class MainActorTests: XCTestCase {
	@MainActor
	func testRunOnMainUnsafely() throws {
		let value = MainActor.runUnsafely {
			// this will crash if not on the main thread
			return 42
		}

		XCTAssertEqual(value, 42)
	}

	func testRunOnMainUnsafelyFromBackground() throws {
		let exp = expectation(description: "value")

		DispatchQueue.global().async {
			DispatchQueue.main.async {
				_ = MainActor.runUnsafely {
					// this will crash if not on the main thread
					return 42
				}

				exp.fulfill()
			}
		}

		wait(for: [exp])
	}
}
