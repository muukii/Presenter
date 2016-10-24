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
    
    func parentController(viewController: ViewController) -> UIViewController?
    func willPresent(presentedViewController: ViewController, presentingViewController: UIViewController)
    func didPresent(presentedViewController: ViewController, presentingViewController: UIViewController)
}

extension ModalPresenter {
        
    public func willPresent(presentedViewController: ViewController, presentingViewController: UIViewController) {
        
    }
    
    public func didPresent(presentedViewController: ViewController, presentingViewController: UIViewController) {
        
    }
    
    @discardableResult
    public func present(on presentingViewController: UIViewController, animated: Bool, willPresentTweak: (ModalTransaction<ViewController>) -> Void = { _ in }) -> ModalTransaction<ViewController> {
        
        let controller = createViewController()
        willPresent(presentedViewController: controller, presentingViewController: presentingViewController)
        
        let transaction = ModalTransaction(viewController: controller)
        willPresentTweak(transaction)
        
        controller.presentOperation = .modal
        
        let presentController = parentController(viewController: controller) ?? controller
        
        presentingViewController.present(presentController, animated: animated, completion: {
            
            self.didPresent(presentedViewController: controller, presentingViewController: presentingViewController)
        })
        
        return transaction
    }
}

public struct AnyModalPresenter<V: ModalPresenter>: ModalPresenter {
    
    public typealias ViewController = V.ViewController
    
    let createViewControllerClosure: () -> ViewController
    let parentControllerClosure: (ViewController) -> UIViewController?
    
    public init<T: ModalPresenter>(source: T) where ViewController == T.ViewController {
        
        createViewControllerClosure = source.createViewController
        parentControllerClosure = source.parentController
    }
    
    public func parentController(viewController: ViewController) -> UIViewController? {
        return parentControllerClosure(viewController)
    }
    
    public func createViewController() -> ViewController {
        return createViewControllerClosure()
    }
}
