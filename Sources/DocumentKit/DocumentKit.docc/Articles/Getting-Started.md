# Getting Started

This article explains how to get started with DocumentKit.



## The basics

DocumentKit extends `DocumentGroup` with modifiers that let you add custom toolbar items, customize the document browser, etc.:

```swift
@main
struct MyApp: App {

    var body: some Scene {
        DocumentGroup(newDocument: DemoDocument()) { file in
            ContentView(document: file.$document)
        }
        .additionalNavigationBarButtonItems(
            leading: [...],
            trailing: [...]
        )
        .allowsDocumentCreation(true)
        .allowsPickingMultipleItems(true)
        .showFileExtensions(true)
        .onboardingSheet {
            MyOnboardingScreen()
        }
        .splashSheet {
            MySplashScreen()
        }
    }
}
```

DocumentKit also extends `DocumentGroup` with a modifier that lets you present onboarding screens and splash screens when the app starts for the first time, as described further down.



## How to inspect the document group

DocumentKit has a ``DocumentGroupInspector`` protocol that can be implemented by any type that should be able to inspect the current document group and its document browser, dismiss the current document, etc.:

```swift
struct MyView: View, DocumentGroupInspector {

    var body: some View {
        Button("Dismiss current document", action: dismissCurrentDocument)
    }
    
    var allowsDocumentCreation: Bool {
        documentBrowser?.allowsDocumentCreation ?? false
    }
}
```

The protocol provides you with the underlying UIKit views, which means that you have access to the full capabilities of the platform.



## How to customize the document browser

DocumentKit has `DocumentGroup` view modifiers that let you modify the document browser:

```swift
@main
struct MyApp: App {

    var body: some Scene {
        DocumentGroup(newDocument: DemoDocument()) { file in
            ContentView(document: file.$document)
        }
        .onboardingSheet {
            MyModalView()
        }
        .additionalNavigationBarButtonItems(
            leading: [...],
            trailing: [...]
        )
        .allowsDocumentCreation(true)
        .allowsPickingMultipleItems(true)
        .showFileExtensions(true)
        .tryCustomizeBrowser { 
            $0.allowsDocumentCreation = true  // Same as using the modifier above
        }
    }
}
```

You can use these view modifiers to add additional toolbar items, and use `tryCustomizeBrowser` to configure the browser.  



## How to present modal screens from a document group

DocumentKit has a ``DocumentGroupModal`` protocol that can be used to present any SwiftUI view from any `DocumentGroup`.

```swift
struct MyModalView: DocumentGroupModal {

    var body: some View {
        Text("Hello, modal!")
    }
}
```

Just implement the protocol as above, to get access to handy modal presentation functions that can be used in e.g. sheet modifiers:

```swift
MyModalView()
    .presentAsDocumentGroupSheet()
    // or .presentAsDocumentGroupFullScreenCover()
    // or .presentAsDocumentGroupModal(.overCurrentContext)
```

These capabilities are used to power DocumentKit's onboarding and splash screen capabilities, as described further down.



## How to present an initial onboarding screen

We can use the modal capabilities to open an initial onboarding when a `DocumentGroup`-based app is launched for the first time.

All you have to do is to add an `onboardingSheet` or `onboardingFullScreenCover` modifier to the `DocumentGroup`:

```swift
@main
struct MyApp: App {

    var body: some Scene {
        DocumentGroup(newDocument: MyDocument()) { file in
            ContentView(document: file.$document)
        }
        .onboardingSheet(id: "my-onboarding") {
            MyModalView()
        }
    }
}
```

This will present the onboarding screen *once*, after which it will never be shown again. If you want to present different onboarding experiences, you can provide a custom `id` value for each onboarding.



## How to handle onboarding presentation state

If you want to programmatically get and set the presentation state of a certain onboarding, you can use the `UserDefault` extensions that are provided by DocumentKit, like:

* `documentGroupOnboardingState(...)`
* `resetDocumentGroupOnboardingState(...)`
* `setDocumentGroupOnboardingState(...)`

This can let you control whether or not the next presentation attempt for a certain onboarding will actually present the screen.



## How to present a splash screen

We can also use the modal capabilities to open a splash screen when a `DocumentGroup`-based app is launched.

All you have to do is to add an `splashScreenSheet` or `splashScreenFullScreenCover` to the `DocumentGroup`:

```swift
@main
struct MyApp: App {

    var body: some Scene {
        DocumentGroup(newDocument: MyDocument()) { file in
            ContentView(document: file.$document)
        }.splashScreenSheet {
            MyModalView()
        }
    }
}
```

Unlike the onboarding modifier, this view modifier will present the splash screen at any time. You can use the view builder to return an `EmptyView` whenever you want no splash screen.  
