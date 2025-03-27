# Release Notes

DocumentKit will use semver after 1.0. 

Until then, deprecated features may be removed in the next minor version.



## 0.5

This version removes all deprecated code and makes the SDK use Swift 6.

### ‼️ Important Information

iOS 18 changed how `DocumentGroup` looks and behaves, by completely changing the underlying types. You can now do a lot more things than before, which makes this SDK less useful. 

While this version fixes a few things, and for instance makes the modal screens work, the `UIDocumentBrowserViewController` customizations no longer work, since the `DocumentGroup` uses a new underlying type.

Since you can now do more with the native `DocumentGroup`, this version will remain as is until iOS 19 is released, then removed...unless anyone comes up with another way to use it in iOS 18.



## 0.4

This version adds support for visionOS and Swift strict concurrency.

This version also cleans up the ways a modal can be presented, by adding a new enum that can be used instead of having separate functions.

### ✨ Features

* `DocumentGroup.splashScreen` now supports conditional presentations.
* `DocumentGroupModalType` is now used to avoid having several presentation functions where only the modal type differs. 

### 💡 Adjustments

* `DocumentGroup.onboardingModal` replaces the many earlier variations.
* `DocumentGroup.splashScreen` replaces the many earlier variations.
* `DocumentGroupModal` now conforms to `Sendable` to work within modals. 



## 0.3

This version bumps Swift to 5.9. 



## 0.2

This version adds the possibility to present splash screens. 



## 0.1

This is the first beta version, which adds functionality to present modals and onboardings, inspect the document browser and customize the document browser. 

### ✨ Features

* `DocumentGroupInspector` is a new protocol that can be implemented by any type that should be able to inspect the current `DocumentGroup`.
* `DocumentGroupPresenter` is a new protocol that can be implemented by any type that should be able to present and dismiss views from the current `DocumentGroup`.
* `DocumentGroupModal` is a `View` protocol that can be implemented by any view that can then be opened as a modal from a `DocumentGroup`. 
* `DocumentGroup` has new onboarding, property and toolbar extensions.
* `UserDefaults` has new onboarding extensions.
