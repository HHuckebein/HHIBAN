# IBAN
What is IBAN for?
-------------------
IBAN Type creates an IBAN out of string (if it is IBAN conform).
In case of success provides information as counrty (as **ISO3166-1Alpha2**) the check sum or just the value as formatted string.
If you just need to know wether a string contains a valid IBAN you can use the static method myString**.isIBAN**.

[![Swift](https://github.com/HHuckebein/IBAN/actions/workflows/swift.yml/badge.svg)](https://github.com/HHuckebein/IBAN/actions/workflows/swift.yml)
![CocoaPods](https://img.shields.io/cocoapods/v/HHIBAN.svg)
[![codecov](https://codecov.io/gh/HHuckebein/IBAN/branch/master/graph/badge.svg)](https://codecov.io/gh/HHuckebein/IBAN)

## How to use IBAN

```swift
try IBAN(with: "CH10002300A1023502601")

"CH10002300A1023502601".isIBAN

```

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, add HHIBAN as a dependency by adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/HHuckebein/IBAN", .upToNextMajor(from: "1.0.1"))
]
```

### Installation with CocoaPods

You can install IBAN by including the following line in your Podfile.

```Ruby
pod 'HHIBAN', '~> 1.0.0'
```

## Author

RABE_IT Services, development@berndrabe.de

## License

IBAN is available under the MIT license. See the LICENSE file for more info.
