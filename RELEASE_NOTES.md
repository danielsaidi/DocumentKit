# Release Notes

DocumentKit will use semver after 1.0. 

Until then, deprecated features may be removed in the next minor version.



## 0.4

This version adds support for visionOS. 



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
