import Foundation

extension NotificationCenter {
	/// Receieve notifications that are known to always be delivered on the `MainActor`.
	public func addMainActorObserver(
		forName name: NSNotification.Name?,
		object obj: Any?,
		using block: @escaping @MainActor (Notification) -> Void
	) -> NSObjectProtocol {
		let nonMainblock = unsafeBitCast(block, to: ((Notification) -> Void).self)

		return addObserver(forName: name, object: obj, queue: .main) { notification in
			nonisolated(unsafe) let mainNotification = notification
			
			MainActor.assumeIsolated {
				block(mainNotification)
			}
		}
	}
}
