# Getting Started

This article explains how to get started with DocumentKit.



## How to inspect the document group

DocumentKit has a ``DocumentGroupInspector`` protocol that lets you inspect a document group.

Just let any type implement the protocol, then use it to access the current document browser:

```swift
struct MyView: View, DocumentGroupInspector {

    var body: some View {
        Text("Hello, modal!")
    }
    
    var allowsDocumentCreation: Bool {
        documentBrowser?.allowsDocumentCreation ?? false
    }
}
```

You can also use the protocol to dismiss the currently presented document:

```swift
struct MyButton: View, DocumentGroupInspector {

    var body: some View {
        Button("Dismiss", action: dismissCurrentDocument)
    }
}
```

> Important: Note that the `DocumentGroup` must have been presented for this to work. The internal functionality adds a security delay whenever needed, to ensure that the browser is available.



## How to customize the document browser

DocumentKit has `DocumentGroup` extensions that let you modify the underlying document browser.

For instance, you can add additional toolbar items, configure some properties and use `tryCustomizeBrowser` to perform any customization you want:

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
            $0.allowsDocumentCreation = false 
        }
    }
}
```

Since `tryCustomizeBrowser` is not as nice as using the other extensions, more extensions may be added in the future.  



## How to present a modal screen

DocumentKit has a ``DocumentGroupModal`` protocol that can present any SwiftUI view from any `DocumentGroup`. 

Just let any view implement the protocol:

```swift
struct MyModalView: DocumentGroupModal {

    var body: some View {
        Text("Hello, modal!")
    }
}
```

then use any of the available view extensions to present it as a sheet, full screen cover, etc.:

```swift
MyModalView()
    .presentAsDocumentGroupSheet()
    // .presentAsDocumentGroupFullScreenCover()
    // .presentAsDocumentGroupModal(.overCurrentContext)
```

This means that any SwiftUI view can be easily presented as a modal over any `DocumentGroup`.



## How to present an initial onboarding screen

We can also use the ``DocumentGroupModal`` protocol to open an initial onboarding screen when a `DocumentGroup`-based app starts.

All you have to do is to add an `onboardingSheet` or `onboardingFullScreenCover` to the `DocumentGroup`:

```swift
@main
struct MyApp: App {

    var body: some Scene {
        DocumentGroup(newDocument: MyDocument()) { file in
            ContentView(document: file.$document)
        }.onboardingSheet {
            MyModalView()
        }
    }
}
```

This will present the onboarding screen *once*, after which it will not be shown again.

If you want to present different onboarding experiences, you can provide a custom `id` for each onboarding. You can also provide a custom delay and your own `UserDefaults` store.

If you want to programmatically get and set the presentation state of a certain onboarding, you can use the `documentGroupOnboardingState(...)`, `resetDocumentGroupOnboardingState(...)` and `setDocumentGroupOnboardingState(...)` `UserDefaults` extensions.



## How to present a splash screen

We can also use the ``DocumentGroupModal`` protocol to open a splash screen when a `DocumentGroup`-based app starts.

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

This will present the provided view every time, unless you give it a unique ID, which makes it display once.
