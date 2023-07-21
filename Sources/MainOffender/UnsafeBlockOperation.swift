import Foundation

/// An operation that manages the concurrent execution of one or more blocks without Sendable checking.
public class UnsafeBlockOperation: BlockOperation {
	public init(block unsafeBlock: @escaping () -> Void) {
		super.init()
		addUnsafeExecutionBlock(block: unsafeBlock)
	}

	/// Adds the specified block to the receiver’s list of unsafe blocks to perform.
	public func addUnsafeExecutionBlock(block unsafeBlock: @escaping () -> Void) {
		let block = unsafeBitCast(unsafeBlock, to: (@Sendable () -> Void).self)

		addExecutionBlock(block)
	}
}
