# Release Notes

DocumentKit will use semver after 1.0. 

Until then, deprecated features may be removed in the next minor version.



## 0.1

### ✨ Features

* `DocumentGroupInspector` is a new protocol that can be implemented by any type that should be able to inspect the current `DocumentGroup`.
* `DocumentGroupPresenter` is a new protocol that can be implemented by any type that should be able to present and dismiss views from the current `DocumentGroup`.
* `DocumentGroupModal` is a `View` protocol that can be implemented by any view that can then be opened as a modal from a `DocumentGroup`. 
* `DocumentGroup` has new onboarding extensions.
* `UserDefaults` has new onboarding extensions.
