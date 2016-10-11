// PushPresenter.swift
//
// Copyright (c) 2015 muukii
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

public protocol PushPresenter: PresenterType {
    
    func willPush(_ viewController: ViewController)
    func didPush(_ viewController: ViewController)
}

extension PushPresenter {
    
    public func willPush(_ viewController: ViewController) {
        
    }
    
    public func didPush(_ viewController: ViewController) {
        
    }
        
    @discardableResult
    public func push(on navigationController: UINavigationController?, animated: Bool,  _ willPushTweak: (PushTransaction<ViewController>) -> Void = { _ in }) -> PushTransaction<ViewController> {
        
        let controller = createViewController()
        willPush(controller)
        
        let transaction = PushTransaction(viewController: controller)
        
        controller.presentOperation = .push
        
        willPushTweak(transaction)
        guard !(controller is UINavigationController) else {
            fatalError("Can't push UINavigationController")
        }
        
        navigationController?.pushViewController(controller, animated: animated)
        
        didPush(controller)
        
        return transaction
    }
}

public struct AnyPushPresenter<V: PushPresenter>: PushPresenter {
    
    public typealias ViewController = V.ViewController
    
    let createViewControllerClosure: () -> ViewController
    
    public init<T: ModalPresenter>(source: T) where ViewController == T.ViewController {
        
        createViewControllerClosure = source.createViewController
    }
    
    public func createViewController() -> ViewController {
        return createViewControllerClosure()
    }
}
