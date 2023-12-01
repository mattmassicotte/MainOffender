[![Build Status][build status badge]][build status]
[![Platforms][platforms badge]][platforms]
[![Documentation][documentation badge]][documentation]

# MainOffender
A tiny package with utilities to help with Swift Concurrency

You can also just copy-paste the stuff you need into your project if you aren't into taking on the dependency. I won't be offended (ha!).

Features:
- `MainActor.runUnsafely` for `MainActor.assumeIsolated` with lower OS version requirements.
- `DispatchQueue.mainActor` for a `DispatchQueue` proxy that is `@MainActor`-compatible
- `OperationQueue.mainActor` for an `OperationQueue` proxy that is `@MainActor` compatible
- `UnsafeBlockOperation` for `BlockOperation` without `Sendable` checking
- Additions to `OperationQueue` to submit blocks directly without `Sendable` checking
- `addUnsafeObserver(forName:object:queue:using:)` for `NotificationCenter`

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
[license]: https://opensource.org/licenses/BSD-3-Clause
[license badge]: https://img.shields.io/github/license/mattmassicotte/MainOffender
[platforms]: https://swiftpackageindex.com/mattmassicotte/MainOffender
[platforms badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmattmassicotte%2FMainOffender%2Fbadge%3Ftype%3Dplatforms
[documentation]: https://swiftpackageindex.com/mattmassicotte/MainOffender/main/documentation
[documentation badge]: https://img.shields.io/badge/Documentation-DocC-blue
