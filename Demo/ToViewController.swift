//
//  ToViewController.swift
//  Presenter
//
//  Created by muukii on 2016/10/12.
//  Copyright © 2016 muukii. All rights reserved.
//

import UIKit

import Presenter

class ToViewController: UIViewController {
    
    @IBAction func tap(_ sender: AnyObject) {
        unwind(animated: true)
    }
    
    class Presenter: ModalPresenter {
        public var transitioningDelegate: UIViewControllerTransitioningDelegate? {
            return Delegate()
        }
        
        func parentController(viewController: ToViewController) -> UIViewController? {
            return nil
        }
        
        func createViewController() -> ToViewController {
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ToViewController") as! ToViewController
            return controller
        }
    }
}

class Delegate: NSObject, UIViewControllerTransitioningDelegate {
    
    deinit {
        print("deinit")
    }
    
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return nil
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
         return nil
    }
    
    open func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return nil
    }
}
