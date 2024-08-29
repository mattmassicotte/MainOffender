import Foundation

final class ThreadRunLoop: Sendable {
	private struct RunLoopContext: @unchecked Sendable {
		let runLoop: CFRunLoop
		let source: CFRunLoopSource
		let thread: Thread
	}

	private let context: RunLoopContext
	private let semaphore: DispatchSemaphore

	init(name: String? = nil) {
		nonisolated(unsafe) var context: RunLoopContext? = nil
		let semaphore = DispatchSemaphore(value: 0)

		Thread.detachNewThread {
			let thread = Thread.current

			if let name {
				thread.name = name
			}

			guard let loop = CFRunLoopGetCurrent() else {
				fatalError("Unable to create runloop in thread")
			}

			let source = Self.createEmptySource()

			CFRunLoopAddSource(loop, source, CFRunLoopMode.defaultMode)

			context = RunLoopContext(runLoop: loop, source: source, thread: thread)
			semaphore.signal()

			CFRunLoopRun()
		}

		semaphore.wait()
		semaphore.signal() // increment it again for future work

		self.semaphore = semaphore
		self.context = context!
	}

	static func createEmptySource() -> CFRunLoopSource {
		var sourceContext = CFRunLoopSourceContext(
			version: 0,
			info: nil,
			retain: nil,
			release: nil,
			copyDescription: nil,
			equal: nil,
			hash: nil,
			schedule: { _, _, _ in
			},
			cancel: { _, _, _ in
			},
			perform: { _ in
			}
		)

		return CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &sourceContext)!
	}

	deinit {
		CFRunLoopStop(context.runLoop)
	}

	func perform(_ work: @escaping @Sendable () -> Void) {
		// it does not appear necessary to actually call `CFRunLoopSourceSignal(context.source)`.
		// But, as documented in `CFRunLoopPerformBlock`, the runloop does need to be
		// woken up.

		semaphore.wait()

		CFRunLoopPerformBlock(context.runLoop, CFRunLoopMode.defaultMode.rawValue, work)
		CFRunLoopWakeUp(context.runLoop)

		semaphore.signal()
	}
}



/// A `SerialExecutor` that runs jobs on a private thread with an active CFRunLoop
public final class ThreadExecutor: SerialExecutor {
	private let thread: ThreadRunLoop

	public init(name: String? = nil) {
		self.thread = ThreadRunLoop(name: name)
	}

	public func asUnownedSerialExecutor() -> UnownedSerialExecutor {
		UnownedSerialExecutor(ordinary: self)
	}

	public func enqueue(_ job: UnownedJob) {
		let unownedExecutor = asUnownedSerialExecutor()

		thread.perform {
			job.runSynchronously(on: unownedExecutor)
		}
	}

//	@available(macOS 14.0, *)
//	public func enqueue(_ job: consuming ExecutorJob) {
//		let unownedJob = UnownedJob(job)
//		let unownedExecutor = asUnownedSerialExecutor()
//
//		thread.perform {
//			unownedJob.runSynchronously(on: unownedExecutor)
//		}
//	}
}
