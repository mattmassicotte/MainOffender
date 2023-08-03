import Foundation

/// An `OperationQueue` proxy that accepts `@MainActor`-compatible closures.
///
/// All operations are actually run on `OperationQueue.main`.
public final class MainOperationQueue {
	public func addOperation(_ block: @MainActor @escaping @Sendable () -> Void) {
		OperationQueue.main.addOperation {
			MainActor.runUnsafely(block)
		}
	}

	public func addUnsafeOperation(_ unsafeBlock: @escaping () -> Void) {
		OperationQueue.main.addUnsafeOperation {
			MainActor.runUnsafely(unsafeBlock)
		}
	}

	public func addBarrierBlock(_ barrier: @MainActor @escaping @Sendable () -> Void) {
		OperationQueue.main.addBarrierBlock {
			MainActor.runUnsafely(barrier)
		}
	}

	public func addUnsafeBarrierBlock(_ unsafeBlock: @escaping () -> Void) {
		OperationQueue.main.addUnsafeBarrierBlock {
			MainActor.runUnsafely(unsafeBlock)
		}
	}
	
	public func addOperation(_ op: Operation) {
		OperationQueue.main.addOperation(op)
	}

	public func waitUntilAllOperationsAreFinished() {
		OperationQueue.main.waitUntilAllOperationsAreFinished()
	}
}

extension OperationQueue {
	/// An OperationQueue proxy that is compatible with MainActor isolation
	public static let mainActor = MainOperationQueue()
}
