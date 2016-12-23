![Bubble Ranking Indicator Logo](https://cloud.githubusercontent.com/assets/879038/21443097/6a79c36e-c870-11e6-9771-88a7b59d31eb.png)

![Swift3](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat")
[![Platform](https://img.shields.io/cocoapods/p/BubbleRankingIndicator.svg?style=flat)](http://cocoapods.org/pods/BubbleRankingIndicator)
[![Version](https://img.shields.io/cocoapods/v/BubbleRankingIndicator.svg?style=flat)](http://cocoapods.org/pods/BubbleRankingIndicator)
[![License](https://img.shields.io/cocoapods/l/BubbleRankingIndicator.svg?style=flat)](http://cocoapods.org/pods/BubbleRankingIndicator)

Description
--------------

`BubbleRankingIndicator` is a customizable circular ranking indicator written in Swift that can be used to display ranking information.

![Example](https://cloud.githubusercontent.com/assets/879038/21441684/61779150-c867-11e6-8823-52f8d8ebc7ef.png)

In this screenshot the user has achieved rank 2 out of 4, and the images used are the faces cards of a standard deck of cards.

# Contents
1. [Features](#features)
3. [Installation](#installation)
4. [Supported OS & SDK versions](#supported-versions)
5. [Usage](#usage)
6. [License](#license)
7. [Contact](#contact)

##<a name="features"> Features </a>

- [x] Supports AutoLayout.
- [x] Supports any number of ranks as long as they fit within the bounds of the view.
- [x] Supports customizing background images of all ranks.
- [x] Supports being created either in code or a Storyboard.

<a name="installation"> Installation </a>
--------------

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate `BubbleRankingIndicator` into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'BubbleRankingIndicator'
```

Then, run the following command:

```bash
$ pod install
```

In case Xcode complains (<i>"Cannot load underlying module for BubbleRankingIndicator"</i>) go to Product and choose Clean (or simply press <kbd>⇧</kbd><kbd>⌘</kbd><kbd>K</kbd>).

### Manually

If you prefer not to use CocoaPods, you can integrate `BubbleRankingIndicator` into your project manually.

<a name="supported-versions"> Supported OS & SDK Versions </a>
-----------------------------

* Supported build target - iOS 8.2+ (Xcode 7.3+)

<a name="usage"> Usage </a>
--------------

1) First you should set up the `BubbleRankingIndicator`:

```swift
var bubbleRankingIndicatorView = BubbleRankingIndicatorView()

var state = bubbleRankingIndicatorView.state
var ranks = [Rank]()
// Create and initialize all of the Ranks. These can be changed later.
state.ranks = ranks
state.unachievedRankBackgroundColor = .lightGray
state.rankNameFont = .systemFont(ofSize: 30)

bubbleRankingIndicatorView.state = state
```

2) In order to set the active rank, modify the `state` object:

```swift

var state = bubbleRankingIndicatorView.state
state.activeRankLevel = 2
bubbleRankingIndicatorView.state = state
```

<a name="license"> License </a>
--------------

`BubbleRankingIndicator` is developed by [Josh Sklar](https://www.linkedin.com/in/jrmsklar) at [StockX](https://stockx.com) and is released under the MIT license. See the `LICENSE` file for details.

<a name="contact"> Contact </a>
--------------

You can follow or drop me a line on [my Twitter account](https://twitter.com/jrmsklar). If you find any issues on the project, you can open a ticket. Pull requests are also welcome.
