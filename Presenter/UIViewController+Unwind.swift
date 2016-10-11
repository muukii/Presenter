//
//  UIViewController+Unwind.swift
//  Presenter
//
//  Created by muukii on 10/6/16.
//  Copyright © 2016 muukii. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public var presentOperation: PresentOperation? {
        get {
            return objc_getAssociatedObject(self, &PresenterStoredProperties.presentOperation) as? PresentOperation
        }
        set {
            print(newValue)
            objc_setAssociatedObject(
                self,
                &PresenterStoredProperties.presentOperation,
                newValue,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

public enum PresentOperation {
    case modal
    case push
}

private enum PresenterStoredProperties {

    static var presentOperation: Void?
}

extension UIViewController {
    
    public func unwind(animated: Bool, completion: @escaping () -> Void = {}) {
        switch presentOperation {
        case .modal?:
            dismiss(animated: animated, completion: completion)
        case .push?:
            _ = navigationController?.popViewController(animated: true)
        default:
            break
        }
    }
}
