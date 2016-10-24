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
        
        func parentController(viewController: ToViewController) -> UIViewController? {
            return nil
        }
        
        func createViewController() -> ToViewController {
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ToViewController") as! ToViewController
            return controller
        }
    }
}
