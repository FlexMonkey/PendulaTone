//
//  Pendulum.swift
//  PendulaTone
//
//  Created by Simon Gladman on 13/01/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import Foundation
import UIKit


class Pendulum: UIControl
{
    let pendulumShape = PendulumShape()
    
    let pendulumLength: Int
    let pendulumDuration: NSTimeInterval
    
    let angle = CGFloat((25 * M_PI ) / 180)
    var direction = CGFloat(-1);
    
    init(pendulumDuration: Float, pendulumLength: Int)
    {
        self.pendulumLength = pendulumLength
        self.pendulumDuration = NSTimeInterval(pendulumDuration)
        
        super.init(frame: CGRectZero)
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview()
    {
        layer.backgroundColor = UIColor.grayColor().CGColor
        
        layer.addSublayer(pendulumShape)
        
        pendulumShape.drawPendulum(pendulumLength)
        
        swing(true)
    }
    
    func swing(value: Bool)
    {
        transform = CGAffineTransformMakeRotation(direction * angle)
        
        direction = -direction
        
        UIView.animateWithDuration(pendulumDuration, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { self.transform = CGAffineTransformMakeRotation(self.direction * self.angle) }, completion: swing)
    }
    
 
}

class PendulumShape: CAShapeLayer
{
    var pendulumPath = UIBezierPath()
    
    func drawPendulum(pendulumLength: Int)
    {
        strokeColor = UIColor.blueColor().CGColor
        lineWidth = 1
        fillColor = UIColor.blueColor().CGColor
        masksToBounds = false
        
        drawsAsynchronously = true
        
        pendulumPath.removeAllPoints()
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: pendulumLength)
        let rectPath = UIBezierPath(rect: rect)
        pendulumPath.appendPath(rectPath)
        
        let ballRect = CGRect(x: -10, y: pendulumLength, width: 20, height: 20)
        let ballPath = UIBezierPath(ovalInRect: ballRect)
        pendulumPath.appendPath(ballPath)
        
        path = pendulumPath.CGPath
    }
    
}