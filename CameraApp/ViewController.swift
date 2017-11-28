//  ViewController.swift
//  CameraApp
//
//  Created by HKUCS on 2017/11/15.
//  Copyright © 2017年 HKUCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController,WWXHCameraViewControllerDelegate {
    
    
    @IBOutlet weak var EnterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor(red: 46, green: 41, blue: 61, alpha: 1)
        EnterButton.setImage(UIImage(named:"icon4.png"),for:[])
        let draggableBackground = TinderViewBackGround(frame: view.frame)
        view.addSubview(draggableBackground)
        view.addSubview(EnterButton)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cameraViewController(_: WWXHCameraViewController, didFinishPickingImage image: UIImage) {
        
    }
    
}

