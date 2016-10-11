//
//  ViewController.swift
//  Demo
//
//  Created by muukii on 2016/10/12.
//  Copyright © 2016 muukii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tap(_ sender: AnyObject) {
        ToViewController.Presenter().present(on: self, animated: true)
    }

}
