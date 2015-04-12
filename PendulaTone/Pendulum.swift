//
//  Pendulum.swift
//  PendulaTone
//
//  Created by Simon Gladman on 13/01/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//
//  Grey color inidicates no instrument, blue indicates instrument
//  Solid ball indicates selected pendulum

import Foundation
import UIKit


class Pendulum: UIControl
{
    let pendulumShape = PendulumShape()
    
    let pendulumLength: Int
    let pendulumDuration: NSTimeInterval
    let mandolin: Mandolin
    let noteFrequency: Double
    
    let angle = CGFloat((25 * M_PI ) / 180)
    var direction = CGFloat(-1);
    
    init(pendulumDuration: Float, pendulumLength: Int, noteFrequency: Double)
    {
        self.pendulumLength = pendulumLength
        self.pendulumDuration = NSTimeInterval(pendulumDuration)
        self.noteFrequency = noteFrequency
        
        mandolin = Mandolin(noteFrequency: noteFrequency)
        
        super.init(frame: CGRectZero)
        
        userInteractionEnabled = false
        
        setPendulumColors()
   
        AKOrchestra.addInstrument(mandolin)
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isCurrentSelection: Bool = true
    {
        didSet
        {
            setPendulumColors()
        }
    }
    
    func setPendulumColors()
    {
       pendulumShape.fillColor = isCurrentSelection ? UIColor.blueColor().CGColor : UIColor.lightGrayColor().CGColor
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
        mandolin.playForDuration(3.0)
    }
    
 
}

class Mandolin: AKInstrument
{
    init(noteFrequency: Double)
    {
        super.init()
        
        let frequency = AKInstrumentProperty(value: Float(noteFrequency),  minimum: 0, maximum: 1000)
        let amplitude = AKInstrumentProperty(value: 0.04, minimum: 0,   maximum: 0.25)
        
        let mandolin = AKMandolin()
        
        mandolin.frequency = frequency
        mandolin.amplitude = amplitude
        mandolin.bodySize = 0.7.ak
        
        setAudioOutput(mandolin)
    }
}

class PendulumShape: CAShapeLayer
{
    var pendulumPath = UIBezierPath()
    
    func drawPendulum(pendulumLength: Int)
    {
        lineWidth = 1
        masksToBounds = false
        
        drawsAsynchronously = false
        
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