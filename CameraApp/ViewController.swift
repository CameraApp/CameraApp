//  ViewController.swift
//  WWXHCamera
//
//  Created by HKUCS on 2017/11/15.
//  Copyright © 2017年 HKUCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController,WWXHCameraViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cameraViewController(_: WWXHCameraViewController, didFinishPickingImage image: UIImage) {
        // 这里获取到图片 然后可以做些操作...
    }
    
}

