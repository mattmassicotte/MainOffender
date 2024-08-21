import Foundation

extension RunLoop {
	/// Guarantee that the current runloop turns at least once
#if compiler(>=6.0)
	public static func turn(isolation: isolated (any Actor)? = #isolation) async {
		await withCheckedContinuation(isolation: isolation) { continutation in
			RunLoop.current.perform {
				continutation.resume()
			}
		}
	}
#else
	/// Guarantee that the current runloop turns at least once
	public static func turn(isolation: isolated any Actor) async {
		await withCheckedContinuation { continutation in
			RunLoop.current.perform {
				continutation.resume()
			}
		}
	}
#endif
}
