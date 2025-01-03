import XCTest
import MainOffender

@MainActor
fileprivate func mainActorFunction() {

}

final class UndoManagerTests: XCTestCase {
	@MainActor
	func testMainActor() async throws {
		let unsendable = UnsendableClass()
		let manager = UndoManager()

		manager.registerMainActorUndo(withTarget: unsendable) { target in
			mainActorFunction()
		}

		manager.undo()
	}
}
