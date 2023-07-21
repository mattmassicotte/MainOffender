[![Build Status][build status badge]][build status]
[![License][license badge]][license]
[![Platforms][platforms badge]][platforms]
[![Documentation][documentation badge]][documentation]

# MainOffender
A tiny package with utilities to help with Swift Concurrency

You can also just copy-paste the stuff you need into your project if you aren't into taking on the dependnecy. I won't be offended (ha!).

Features:
- `MainActor.runUnsafely` for `MainActor.assumeIsolated` with lower OS version requirements.
- `UnsafeBlockOperation` for `BlockOperation` without `Sendable` checking
- Additions to `OperationQueue` to submit blocks directly without `Sendable` checking

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/ChimeHQ/MainOffender", branch: "main")
]
```

## Contributing and Collaboration

I prefer collaboration, and would love to find ways to work together if you have a similar project.

I prefer indentation with tabs for improved accessibility. But, I'd rather you use the system you want and make a PR than hesitate because of whitespace.

## Suggestions and Feedback

I'd love to hear from you! Get in touch via [mastodon](https://mastodon.social/@mattiem), an issue, or a pull request.

By participating in this project you agree to abide by the [Contributor Code of Conduct](CODE_OF_CONDUCT.md).

[build status]: https://github.com/mattmassicotte/MainOffender/actions
[build status badge]: https://github.com/mattmassicotte/MainOffender/workflows/CI/badge.svg
[license]: https://opensource.org/licenses/BSD-3-Clause
[license badge]: https://img.shields.io/github/license/mattmassicotte/MainOffender
[platforms]: https://swiftpackageindex.com/mattmassicotte/MainOffender
[platforms badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmattmassicotte%2FMainOffender%2Fbadge%3Ftype%3Dplatforms
[documentation]: https://swiftpackageindex.com/mattmassicotte/MainOffender/main/documentation
[documentation badge]: https://img.shields.io/badge/Documentation-DocC-blue
