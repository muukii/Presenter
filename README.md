# Presenter

[![CI Status](http://img.shields.io/travis/muukii/Presenter.svg?style=flat)](https://travis-ci.org/muukii/Presenter)
[![Version](https://img.shields.io/cocoapods/v/Presenter.svg?style=flat)](http://cocoapods.org/pods/Presenter)
[![License](https://img.shields.io/cocoapods/l/Presenter.svg?style=flat)](http://cocoapods.org/pods/Presenter)
[![Platform](https://img.shields.io/cocoapods/p/Presenter.svg?style=flat)](http://cocoapods.org/pods/Presenter)

Screen transition with safe and clean code.

With Presenter, you can…
- Assure that the ViewController's requirements are met, such as a ViewModel to be injected.
- Constrain transition types (push or present modal or both)

**This library is recommended to be used together with [Instantiatable](https://github.com/muukii/Instantiatable).**

## Usage

### Clean Screen Transition

```swift
MyViewController.Presenter(userID: "muukii").push(self.navigationController)
MyViewController.Presenter(userID: "muukii").present(self)
```

#### Advanced

```swift
MyViewController.Presenter(userID: "muukii").push(self.navigationController) { (transaction: PushTransaction<MyViewController> in

    // Pop    
    transaction.pop()

    // Get
    transaction.viewController
}

MyViewController.Presenter(userID: "muukii").present(self) { (transaction: ModalTransaction<MyViewController>) in

    // Pop    
    transaction.dismiss()

    // Get
    transaction.viewController
}
```


### Create Presenter

Push

```swift
extension MyViewController {

    final class Presenter: PushPresenter {

        let userID: String

        init(userID: String) {
            self.userID = userID
        }

        func createViewController() -> MyViewController {
            let controller = MessagesViewController() // Init from Stroyboard or XIB
            controller.userID = userID
            return controller
        }  
        
        // Optional:
        
        public func willPush(viewController: MyViewController) {
        
        }
    
        public func didPush(viewController: MyViewController) {
        
        }
    }
}
```

Present

```swift
extension MyViewController {

    final class Presenter: ModalPresenter {

        let userID: String

        init(userID: String) {
            self.userID = userID
        }

        func parentController(viewController: UIViewController) -> UIViewController? {
            return UINavigationController(rootViewController: viewController)
        }

        func createViewController() -> MyViewController {
            let controller = MessagesViewController() // Init from Stroyboard or XIB
            controller.userID = userID
            return controller
        }   
        
        // Optional
        
        public func willPresent(viewController: MyViewController) {
        
        }
    
        public func didPresent(viewController: MyViewController) {
        
        }
    }
}
```

Present or Push

```swift
extension MyViewController {

    final class Presenter: PushPresenter, ModalPresenter {

        let userID: String

        init(userID: String) {
            self.userID = userID
        }

        func parentController(viewController: UIViewController) -> UIViewController? {
            // Call Present() only
            return UINavigationController(rootViewController: viewController)
        }

        func createViewController() -> MyViewController {
            let controller = MessagesViewController() // Init from Stroyboard or XIB
            controller.userID = userID
            return controller
        }    
        
        // Optional
        
        public func willPresent(viewController: MyViewController) {
        
        }
    
        public func didPresent(viewController: MyViewController) {
        
        }
        
        public func willPush(viewController: MyViewController) {
        
        }
    
        public func didPush(viewController: MyViewController) {
        
        }
    }
}
```

## Requirements

## Installation

Presenter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Presenter"
```

## Author

muukii, m@muukii.me

## License

Presenter is available under the MIT license. See the LICENSE file for more info.
