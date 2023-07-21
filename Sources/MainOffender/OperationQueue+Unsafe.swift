import Foundation

extension OperationQueue {
	public func addUnsafeOperation(_ unsafeBlock: @escaping () -> Void) {
		let block = unsafeBitCast(unsafeBlock, to: (@Sendable () -> Void).self)

		addOperation(block)
	}

	public func addUnsafeBarrierBlock(_ unsafeBlock: @escaping () -> Void) {
		let block = unsafeBitCast(unsafeBlock, to: (@Sendable () -> Void).self)

		addBarrierBlock(block)
	}
}
