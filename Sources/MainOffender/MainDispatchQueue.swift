import Foundation

public final class MainDispatchQueue {
	public func async(
		group: DispatchGroup? = nil,
		qos: DispatchQoS = .unspecified,
		flags: DispatchWorkItemFlags = [],
		execute work: @MainActor @escaping @Sendable @convention(block) () -> Void
	) {
		DispatchQueue.main.async(group: group, qos: qos, flags: flags) {
			MainActor.runUnsafely(work)
		}
	}

	public func asyncUnsafe(
		group: DispatchGroup? = nil,
		qos: DispatchQoS = .unspecified,
		flags: DispatchWorkItemFlags = [],
		execute unsafeWork: @MainActor @escaping @convention(block) () -> Void
	) {
		let work = unsafeBitCast(unsafeWork, to: (@Sendable @convention(block) () -> Void).self)

		DispatchQueue.main.async(group: group, qos: qos, flags: flags) {
			MainActor.runUnsafely(work)
		}
	}

	public func asyncAfter(
		deadline: DispatchTime,
		qos: DispatchQoS = .unspecified,
		flags: DispatchWorkItemFlags = [],
		execute work: @MainActor @escaping @Sendable @convention(block) () -> Void
	) {
		DispatchQueue.main.asyncAfter(deadline: deadline, qos: qos, flags: flags) {
			MainActor.runUnsafely(work)
		}
	}

	public func asyncAfterUnsafe(
		deadline: DispatchTime,
		qos: DispatchQoS = .unspecified,
		flags: DispatchWorkItemFlags = [],
		execute unsafeWork: @MainActor @escaping @convention(block) () -> Void
	) {
		let work = unsafeBitCast(unsafeWork, to: (@Sendable @convention(block) () -> Void).self)

		DispatchQueue.main.asyncAfter(deadline: deadline, qos: qos, flags: flags) {
			MainActor.runUnsafely(work)
		}
	}
}

extension DispatchQueue {
	public static let mainActor = MainDispatchQueue()
}

extension DispatchGroup {
	public func notify(
		qos: DispatchQoS = .unspecified,
		flags: DispatchWorkItemFlags = [],
		queue: MainDispatchQueue,
		execute work: @MainActor @escaping @Sendable @convention(block) () -> Void
	) {
		self.notify(qos: qos, flags: flags, queue: .main) {
			MainActor.runUnsafely(work)
		}
	}
}
