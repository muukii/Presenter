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
    
    var animated: Bool { get }
    func willPush(_ viewController: ViewController)
    func didPush(_ viewController: ViewController)
}

extension PushPresenter {
    
    public var animated: Bool { return true }
    
    public func willPush(_ viewController: ViewController) {
        
    }
    
    public func didPush(_ viewController: ViewController) {
        
    }
    
    public func push(_ navigationController: UINavigationController?, tweak: (PushTransaction<ViewController>) -> Void = { _ in }) -> Self {
        
        let controller = createViewController()
        willPush(controller)
        tweak(PushTransaction(viewController: controller))
        guard !(controller is UINavigationController) else {
            fatalError("Can't push UINavigationController")
        }
        
        navigationController?.pushViewController(controller, animated: animated)        
        didPush(controller)
        
        return self
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
