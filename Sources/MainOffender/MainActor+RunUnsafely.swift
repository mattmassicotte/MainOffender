import Foundation

extension MainActor {
	/// Execute the given body closure on the main actor without enforcing MainActor isolation.
	///
	/// It will crash if run on any non-main thread.
	@available(*, deprecated, message: "Please move to assumeIsolated")
	@_unavailableFromAsync
	public static func runUnsafely<T>(_ body: @MainActor () throws -> T) rethrows -> T where T : Sendable{
		try MainActor.assumeIsolated(body)
	}
}
