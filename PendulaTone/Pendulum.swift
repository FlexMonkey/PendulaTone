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
    
    let pendulumLength: Float
    let index: Int
    let duration: NSTimeInterval
    
    init(pendulumLength: Float, index: Int)
    {
        self.pendulumLength = pendulumLength
        self.index = index
        
        duration = NSTimeInterval(sqrt(Float(pendulumLength / 55)))
        
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
    }
    
    let angle = CGFloat((25 * M_PI ) / 180)
    
    override func layoutSubviews()
    {
        pendulumShape.drawPendulum(index * 25) // Int(pendulumLength)
        
        transform = CGAffineTransformMakeRotation(-angle)
        
        uiAnimateComplete(true)
    }
    
    func uiAnimateComplete(value: Bool) -> Void
    {
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.CurveEaseInOut, animations: { self.transform = CGAffineTransformMakeRotation(self.angle) }, completion: uiAnimateComplete)
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