<div align="center">

[![Build Status][build status badge]][build status]
[![Platforms][platforms badge]][platforms]
[![Documentation][documentation badge]][documentation]

</div>

# MainOffender
A tiny package with utilities to help with Swift Concurrency

You can also just copy-paste the stuff you need into your project if you aren't into taking on the dependency. I won't be offended (ha!).

Features:
- `DispatchQueue.mainActor` for a `DispatchQueue` proxy that is `@MainActor`-compatible
- `OperationQueue.mainActor` for an `OperationQueue` proxy that is `@MainActor`-compatible
- `addMainActorObserver(forName:object:queue:using:)` for `NotificationCenter`
- `ThreadExecutor` that can be used to back an actor with a dedicated thread + runloop
- `RunLoop.turn` to better control the runloop in an async context

## Usage

Dispatch:

```swift
// MainActor proxy
let mainQueue = DispatchQueue.mainActor

mainQueue.async {
    // statically MainActor
}

let group = DispatchGroup()

// an overload to integrate with DispatchGroup
group.notify(queue: mainQueue) {
    // statically MainActor
}
```

OperationQueue:

```swift
// MainActor proxy
let mainQueue = OperationQueue.mainActor

mainQueue.addOperation {
    // statically MainActor
}
```

NotificationCenter:

```swift
// this will assert if notification is delievered off the MainActor at runtime
NotificationCenter.default.addMainActorObserver(forName: noteName, object: nil) { notification in
    // statically MainActor with full access to Notification object
}
```

UndoManager:

```
undoManager.registerMainActorUndo(withTarget: someView) { target in
    // statically MainActor here
}
```

`RunLoop` additions:

```swift
// Guarantee that the current RunLoop turns at least once
await RunLoop.turn()
```

You can use `ThreadExecutor` to implement an actor that runs all of its methods on a dedicated thread with a functional runloop. This is conceptually similar to how the `MainActor` works.

Useful if you want to interate with RunLoop-based APIs. You can also use this to reduce the deadlock risk of synchronously blocking actor execution. Just be aware that both creating and switching to `ThreadExecutor` actors can be much more expensive than traditional actors.

```swift
actor ThreadActor {
    private let executor = ThreadExecutor(name: "my thread")

    nonisolated var unownedExecutor: UnownedSerialExecutor {
        executor.asUnownedSerialExecutor()
    }

    func runsOnThread() {
        // This will always execute on the same thread
    }
}
```

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/mattmassicotte/MainOffender", from: "0.1.0")
]
```

## Contributing and Collaboration

I'd love to hear from you! Get in touch via [mastodon](https://mastodon.social/@mattiem), an issue, or a pull request.

I prefer collaboration, and would love to find ways to work together if you have a similar project.

I prefer indentation with tabs for improved accessibility. But, I'd rather you use the system you want and make a PR than hesitate because of whitespace.

By participating in this project you agree to abide by the [Contributor Code of Conduct](CODE_OF_CONDUCT.md).

[build status]: https://github.com/mattmassicotte/MainOffender/actions
[build status badge]: https://github.com/mattmassicotte/MainOffender/workflows/CI/badge.svg
[platforms]: https://swiftpackageindex.com/mattmassicotte/MainOffender
[platforms badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmattmassicotte%2FMainOffender%2Fbadge%3Ftype%3Dplatforms
[documentation]: https://swiftpackageindex.com/mattmassicotte/MainOffender/main/documentation
[documentation badge]: https://img.shields.io/badge/Documentation-DocC-blue
