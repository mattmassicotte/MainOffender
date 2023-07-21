import Foundation

/// An operation that manages the concurrent execution of one or more blocks without Sendable checking.
public class UnsafeBlockOperation: BlockOperation {
	public init(block: @escaping () -> Void) {
		super.init()
		addUnsafeExecutionBlock(block: block)
	}

	/// Adds the specified block to the receiver’s list of unsafe blocks to perform.
	public func addUnsafeExecutionBlock(block: @escaping () -> Void) {
		let unsafeBlock = unsafeBitCast(block, to: (@Sendable () -> Void).self)

		addExecutionBlock(unsafeBlock)
	}
}
