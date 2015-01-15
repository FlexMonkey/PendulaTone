//
//  ViewController.swift
//  PendulaTone
//
//  Created by Simon Gladman on 13/01/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit

class ViewController: UIViewController // , UIPickerViewDelegate, UIGestureRecognizerDelegate // UIPickerViewDataSource
{
    let instruments = ["Aaa", "Bbb", "Ccc", "Ddd", "Eee"]
    var pendula = [Pendulum]()
    
    var previousPanTranslationInView: CGPoint?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGrayColor()
    
        for i in 3 ... 20
        {
            let pendulumDuration = (15 / Float(i))
            let pendulumLength = (21 - i) * 25
            
            let pendulum = Pendulum(pendulumDuration: pendulumDuration , pendulumLength: pendulumLength)
            
            pendula.append(pendulum)
            view.addSubview(pendulum)
        }
        
        let pan = UIPanGestureRecognizer(target: self, action: "panHandler:")
        
        view.addGestureRecognizer(pan)
        
        selectedPendulumIndex = 0
    }
    
    func panHandler(recognizer: UIPanGestureRecognizer)
    {
        if recognizer.state == UIGestureRecognizerState.Began
        {
            previousPanTranslationInView = recognizer.translationInView(view)
        }
        else if recognizer.state == UIGestureRecognizerState.Changed
        {
            let translationInView =  recognizer.translationInView(view)
            
            if translationInView.y - previousPanTranslationInView!.y > 10.0 && selectedPendulumIndex > 0
            {
                selectedPendulumIndex--; println("--")
            }
            else if previousPanTranslationInView!.y - translationInView.y > 10.0 && selectedPendulumIndex < pendula.count - 1
            {
                selectedPendulumIndex++; println("++")
            }
            
            previousPanTranslationInView = recognizer.translationInView(view)
        }
        else
        {
            previousPanTranslationInView = nil
        }

    }
    
    var selectedPendulumIndex: Int = 0
    {
        didSet
        {
            pendula[oldValue].isSelected = false
            pendula[selectedPendulumIndex].isSelected = true
        }
    }
    
    
    
    override func viewDidLayoutSubviews()
    {
        for (idx: Int, pendulum: Pendulum) in enumerate(pendula)
        {
            pendulum.frame = CGRect(x: view.frame.width / 2, y: 20, width: 0, height: 0)
        }
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

