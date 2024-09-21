<h1 align="center">
    SwiftUI Study
</h1>

[![Swift Version][swift-image]](https://swift.org/) 
[![Platform][Platform-image]](https://developer.apple.com/kr/ios/)

[swift-image]:https://img.shields.io/badge/swift-5.5.2-orange.svg?style=flat
[Platform-image]: https://img.shields.io/badge/Platform-ios-lightgray.svg?style=flat

SwiftUI 클론코딩

# Requirments
- iOS 15.0+
- Xcode 13.0+

참고 강의 [Hacking With Swift The 100 Days of SwiftUI](https://www.hackingwithswift.com/100/swiftui)

# Course Keyword
## Swift (Day 1 ~ 15)
Language Study

---

## Project 1 (Day 16 ~ 19)
``` Swift
// Property Wrapper
@State, @FocusState
// View Struct
View, Text, Button, Form(Group, Section), TextField, Picker
NavigationLink, NavigationView(title, barTitleStyle, toolbar)
ForEach, Formatter
```
---

## Project 2 (Day 20 ~ 22)
``` Swift
// View Struct
Color, Gradient(Linear, Radial, Angular),
ZStack, VStack, HStack, Image
// Function
Alert, ignoresSafeArea
```
---

## Project 3 (Day 23 ~ 24)
``` Swift
// Property Wrapper
@ViewBuilder, ViewModifier
```
---

## Project 4 (Day 26 ~ 28)
``` Swift
// Objcect
Date(), DateComponents()
// Format
DateFormat
// CoreML
MLModelConfiguration(), CoreMLClass()
```
---

## Project 5 (Day 29 ~ 31)
``` Swift
// View
List vs ForEach
// Get File Conetns
Bundle.main.url()
// function
withAnimation{ }
// Object
UITextChecker()
```
---

## Project 6 (Day 32 ~ 34)
``` Swift
// withAnimation
withAnimation(
    .interpolatingSpring(stiffness: 5, damping: 1)) {
        self.animationAmount3D += 360
        }

// animation
.animation(
    .easeInOut(duration: 1)
        .repeatForever(autoreverses: false),
    value: self.animationAmount32
    )
```
---

## Project 7 (Day 36 ~ 38)
``` Swift
// Property Wrappers
@StateObject, @AppStorage, @Environment, @FetchRequest,
@Published, @ScaledMetric, @SceneStorage, @ObservedObject
```
Challenge X

---

## Project 8 (Day 36 ~ 38)
``` Swift
Codable Data(JSON)
Bundle Extension
```
Challenge X

---

