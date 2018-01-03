# UptakeUI

![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat) ![API docs](https://mobile-toolkit-docs.services.common.int.uptake.com/docs/uptake-ui-ios/badge.svg)

Contrivances built on Cocoa Touch.

## Description
`UptakeUI` contains all the functions, extension, helpers, &c. that are of common use across projects and require `UIKit`. If there's no `UIKit` dependency, it probably belongs in [`UptakeToolbox`](https://github.com/UptakeMobile/uptake-toolbox-ios) instead.

In theory, we'd want all of our UI components to live here as well. Xcode currently exhibits a few problems working with UI classes imported in a module, though. `@IBDesignable` and `@IBInspectable` cease to work, for example.

So for now, all components are pulled out into [`UptakeControls`](https://github.com/UptakeMobile/uptake-controls-ios) which is added to clients as a gut submodule. Ick.

And `UptakeUI` is kept around for shared UI-level functionality. Features shouldn't be added to `UptakeUI` unless they have demonstrated applicability across multiple projects. Remember:

> “Duplication is far cheaper than the wrong abstraction.”  
> –[The Wrong Abstraction](https://www.sandimetz.com/blog/2016/1/20/the-wrong-abstraction)
