# IBAN
What is IBAN for?
-------------------
IBAN Type creates an IBAN out of string (if it is IBAN conform).
In case of success provides information as counrty (as **ISO3166-1Alpha2**) the check sum or just the value as formatted string.
If you just need to know wether a string contains a valid IBAN you can use the static method myString**.isIBAN**.

[![Build Status](https://img.shields.io/github/workflow/status/HHuckebein/HHIBAN/Swift)](https://github.com/HHuckebein/IBAN/actions/workflows/swift.yml)
![CocoaPods](https://img.shields.io/cocoapods/v/HHIBAN.svg)
[![codecov](https://codecov.io/gh/HHuckebein/IBAN/branch/master/graph/badge.svg)](https://codecov.io/gh/HHuckebein/IBAN)

## How to use IBAN

```swift
try IBAN(with: "CH10002300A1023502601")

"CH10002300A1023502601".isIBAN

```

## Installation

### Installation with Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate IBAN into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "HHuckebein/IBAN"
```

Run `carthage` to build the framework and drag the built `IBAN.framework` into your Xcode project.

### Installation with CocoaPods

You can install IBAN by including the following line in your Podfile.

```Ruby
pod 'HHIBAN', '~> 1.0.0'
```

## Author

RABE_IT Services, development@berndrabe.de

## License

IBAN is available under the MIT license. See the LICENSE file for more info.
