#if os(macOS)
import AppKit

extension UndoManager {
	public func registerMainActorUndo<TargetType>(
		withTarget target: TargetType,
		handler: @escaping @MainActor (TargetType) -> Void
	)
	where TargetType : AnyObject {
		registerUndo(withTarget: target, handler: { handlerTarget in
			nonisolated(unsafe) let mainTarget = handlerTarget

			MainActor.assumeIsolated {
				handler(mainTarget)
			}
		})
	}
}
#endif
