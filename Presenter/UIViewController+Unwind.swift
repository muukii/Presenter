//
//  UIViewController+Unwind.swift
//  Presenter
//
//  Created by muukii on 10/6/16.
//  Copyright © 2016 muukii. All rights reserved.
//

import Foundation
import UIKit

public protocol PresenterCompatible: class {
    
}

extension UIViewController: PresenterCompatible {
    
}

extension PresenterCompatible where Self : UIViewController {
    
    public var pushTransaction: PushTransaction<Self>? {
        get {
             return objc_getAssociatedObject(self, &PresenterCompatibleStoredProperties.pushTransaction) as? PushTransaction<Self>
        }
        set {
            objc_setAssociatedObject(
                self,
                &PresenterCompatibleStoredProperties.pushTransaction,
                newValue,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var modalTransaction: ModalTransaction<Self>? {
        get {
            return objc_getAssociatedObject(self, &PresenterCompatibleStoredProperties.modalTransaction) as? ModalTransaction<Self>
        }
        set {
            objc_setAssociatedObject(
                self,
                &PresenterCompatibleStoredProperties.modalTransaction,
                newValue,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }    
}

private enum PresenterCompatibleStoredProperties {
    
    static var pushTransaction: Void?
    static var modalTransaction: Void?
}

extension UIViewController {
    
    public func unwind(animated: Bool, completion: @escaping () -> Void = {}) {
        if let pushTransaction = pushTransaction {
            pushTransaction.pop(animated: animated)
        }
        if let modalTransaction = modalTransaction {
            modalTransaction.dismiss(animated: animated, completion: completion)
        }
    }
}
