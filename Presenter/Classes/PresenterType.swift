//
//  PresenterType.swift
//  Product
//
//  Created by muukii on 4/4/16.
//  Copyright © 2016 eure. All rights reserved.
//

import UIKit

public struct PushTransaction<T: UIViewController> {
    
    public weak var viewController: T?
    
    public func pop() {
        self.viewController?.navigationController?.popViewControllerAnimated(true)
    }
    
    public init(viewController: T) {
        self.viewController = viewController
    }
}

public struct ModalTransaction<T: UIViewController> {
    
    public weak var viewController: T?
    
    public func dismiss() {
        self.viewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    public init(viewController: T) {
        self.viewController = viewController
    }
}

public protocol PresenterType {
    
    associatedtype ViewController: UIViewController
    func createViewController() -> ViewController
}

public protocol ModalPresenter: PresenterType {
    
    var animated: Bool { get }
    func parentController(viewController: UIViewController) -> UIViewController?
}

public protocol PushPresenter: PresenterType {
    
    var animated: Bool { get }
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

extension PushPresenter {
    
    public var animated: Bool { return true }
    
    public func push(navigationController: UINavigationController?, @noescape tweak: PushTransaction<ViewController> -> Void = { _ in }) {
        
        let controller = createViewController()
        tweak(PushTransaction(viewController: controller))
        guard !(controller is UINavigationController) else {
            fatalError("Can't push UINavigationController")
        }
        
        navigationController?.pushViewController(controller, animated: animated)
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

public struct AnyPushPresenter<V: PushPresenter>: PushPresenter {
    
    public typealias ViewController = V.ViewController
    
    let createViewControllerClosure: () -> ViewController
    
    public init<T: ModalPresenter where ViewController == T.ViewController>(source: T) {
        
        createViewControllerClosure = source.createViewController
    }
    
    public func createViewController() -> ViewController {
        return createViewControllerClosure()
    }
}
