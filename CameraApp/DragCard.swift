//
//  TinderCard.swift
//  testingTinderSwipe
//
//  Created by Nicky on 11/16/17.
//  Copyright © 2017 Nicky. All rights reserved.
//

var count=0
let ACTION_MARGIN : CGFloat = 120
let SCALE_STRENGTH : CGFloat = 4
let SCALE_MAX : CGFloat = 0.93
let ROTATION_MAX : CGFloat = 1
let ROTATION_STRENGTH : CGFloat = 320

import UIKit

protocol TinderCardDelegate: NSObjectProtocol {
    func cardSwipedLeft(_ card: UIView)
    func cardSwipedRight(_ card: UIView)
    func updateCardView(_ card: UIView, withDistance distance: CGFloat)
}

class TinderCard: UIView {
    
    var xFromCenter: CGFloat = 0.0
    var yFromCenter: CGFloat = 0.0
    var originalPoint = CGPoint.zero
    var imageView = UIImageView()
    weak var delegate: TinderCardDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
       
        imageView = UIImageView(frame: CGRect(x: 0, y:0, width: 355, height: 392))
        imageView.contentMode = .scaleAspectFit
        print(imageView.frame)
        switch count{
        case 0:
            imageView.image = UIImage(named: "P2_img.jpg")
        case 1:
            imageView.image = UIImage(named: "P1_img.jpg")
        case 2:
            imageView.image = UIImage(named: "P3_img.jpg")
        case 3:
            imageView.image = UIImage(named: "P4_img.jpg")
        default:
            imageView.image = UIImage(named: "P5_img.jpg")
        break
        }
        addSubview(imageView)
        layer.cornerRadius = 10
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0.5, height: 3)
        layer.shadowColor=UIColor.gray.cgColor
        backgroundColor=UIColor(red: 236/255, green: 180/255, blue: 64/255, alpha: 1)
        count=count+1
      let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.beingDragged))
        addGestureRecognizer(panGestureRecognizer)
        
    }
    
    @objc func beingDragged(_ gestureRecognizer: UIPanGestureRecognizer) {
        xFromCenter = gestureRecognizer.translation(in: self).x
        yFromCenter = gestureRecognizer.translation(in: self).y
        switch gestureRecognizer.state {
        //%%% just started swiping
        case .began:
            originalPoint = self.center;
            break;
            
        //%%% in the middle of a swipe
        case .changed:
            let rotationStrength = min(xFromCenter / ROTATION_STRENGTH, ROTATION_MAX)
            let rotationAngel = .pi/8 * rotationStrength
            let scale = max(1 - fabs(rotationStrength) / SCALE_STRENGTH, SCALE_MAX)
            center = CGPoint(x: originalPoint.x + xFromCenter, y: originalPoint.y + yFromCenter)
            let transforms = CGAffineTransform(rotationAngle: rotationAngel)
            let scaleTransform: CGAffineTransform = transforms.scaledBy(x: scale, y: scale)
            self.transform = scaleTransform
            updateOverlay(xFromCenter)
            break;
            
        case .ended:
            afterSwipeAction()
            break;
            
        case .possible:break
        case .cancelled:break
        case .failed:break
        }
        
    }
    func updateOverlay(_ distance: CGFloat) {
        
        imageView.image = distance > 0 ? UIImage(named: "yesButton") : UIImage(named: "noButton")
        imageView.alpha = min(fabs(distance) / 100, 0.5)
        delegate?.updateCardView(self, withDistance: distance)
    }
    
    func afterSwipeAction() {
        
        if xFromCenter > CGFloat(ACTION_MARGIN) {
            rightAction()
        }
        else if xFromCenter < CGFloat(-ACTION_MARGIN) {
            leftAction()
        }
        else {
            //%%% resets the card
            UIView.animate(withDuration: 0.3, animations: {
                self.center = self.originalPoint
                self.transform = CGAffineTransform(rotationAngle: 0)
                self.imageView.alpha = 0
            })
        }
        
    }
    
    func rightAction() {
        let finishPoint = CGPoint(x: 500, y: 2 * yFromCenter + originalPoint.y)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.center = finishPoint
        }, completion: {(_) in
            self.removeFromSuperview()
        })
        delegate?.cardSwipedRight(self)
        print("WATCHOUT RIGHT")
    }
    
    func leftAction() {
        let finishPoint = CGPoint(x: -500, y: 2 * yFromCenter + originalPoint.y)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.center = finishPoint
        }, completion: {(_) in
            self.removeFromSuperview()
        })
        delegate?.cardSwipedLeft(self)
        print("WATCHOUT LEFT")
    }
}

