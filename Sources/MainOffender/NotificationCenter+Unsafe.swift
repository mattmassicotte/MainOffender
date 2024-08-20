import Foundation

extension NotificationCenter {
	public func addUnsafeObserver(forName name: NSNotification.Name?, object obj: Any?, queue: OperationQueue?, using unsafeBlock: @escaping (Notification) -> Void) -> NSObjectProtocol {
		let block = unsafeBitCast(unsafeBlock, to: (@Sendable (Notification) -> Void).self)

		return addObserver(forName: name, object: obj, queue: queue, using: block)
	}

	public func addMainActorObserver(
		forName name: NSNotification.Name?,
		object obj: Any?,
		using block: @escaping @MainActor (Notification) -> Void
	) -> NSObjectProtocol {
		let nonMainblock = unsafeBitCast(block, to: ((Notification) -> Void).self)

		return addUnsafeObserver(forName: name, object: obj, queue: .main) { notification in
			MainActor.preconditionIsolated()

			nonMainblock(notification)
		}
	}
}
