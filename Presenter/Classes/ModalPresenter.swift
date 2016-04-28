// ModalPresenter.swift
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

public protocol ModalPresenter: PresenterType {
    
    var animated: Bool { get }
    func parentController(viewController: UIViewController) -> UIViewController?
}

extension ModalPresenter {
    
    public var animated: Bool { return true }
    
    public func present(presentingViewController: UIViewController, @noescape tweak: ModalTransaction<ViewController> -> Void = { _ in }) {
        
        let controller = createViewController()
        tweak(ModalTransaction(viewController: controller))
        let presentController = parentController(controller) ?? controller
        
        presentingViewController.presentViewController(presentController, animated: animated, completion: nil)
        
    }
}

public struct AnyModalPresenter<V: ModalPresenter>: ModalPresenter {
    
    public typealias ViewController = V.ViewController
    
    let createViewControllerClosure: () -> ViewController
    let parentControllerClosure: UIViewController -> UIViewController?
    
    public init<T: ModalPresenter where ViewController == T.ViewController>(source: T) {
        
        createViewControllerClosure = source.createViewController
        parentControllerClosure = source.parentController
    }
    
    public func parentController(viewController: UIViewController) -> UIViewController? {
        return parentControllerClosure(viewController)
    }
    
    public func createViewController() -> ViewController {
        return createViewControllerClosure()
    }
}
