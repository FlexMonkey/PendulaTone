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
    let instruments = ["None", "Aaa", "Bbb", "Ccc", "Ddd", "Eee"]
    var pendula = [Pendulum]()
    
    var previousPanTranslationInView: CGPoint?
    
    let label = UILabel(frame: CGRectZero)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGrayColor()
        
        view.addSubview(label)
    
        for i in 3 ... 20
        {
            let pendulumDuration = (15 / Float(i))
            let pendulumLength = (21 - i) * 25
            
            let pendulum = Pendulum(pendulumDuration: pendulumDuration , pendulumLength: pendulumLength)
            
            pendula.append(pendulum)
            view.addSubview(pendulum)
            
            if i == 10
            {
                pendulum.instrument = "Aaa"
            }
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
                selectedPendulumIndex--;
            }
            else if previousPanTranslationInView!.y - translationInView.y > 10.0 && selectedPendulumIndex < pendula.count - 1
            {
                selectedPendulumIndex++;
            }
            
            let instrumentIndex = find(instruments, pendula[selectedPendulumIndex].instrument)
            
            if translationInView.x - previousPanTranslationInView!.x > 10.0 && instrumentIndex < instruments.count - 1
            {
                pendula[selectedPendulumIndex].instrument = instruments[instrumentIndex! + 1]
            }
            else if previousPanTranslationInView!.x - translationInView.x > 10.0 && instrumentIndex > 0
            {
                pendula[selectedPendulumIndex].instrument = instruments[instrumentIndex! - 1]
            }
            
            previousPanTranslationInView = recognizer.translationInView(view)
        }
        else
        {
            previousPanTranslationInView = nil
        }

        
        label.text = "\(selectedPendulumIndex) : \(pendula[selectedPendulumIndex].instrument)"
    }
    
    var selectedPendulumIndex: Int = 0
    {
        didSet
        {
            pendula[oldValue].isSelected = false
            pendula[selectedPendulumIndex].isSelected = true
            
            label.text = "\(selectedPendulumIndex) : \(pendula[selectedPendulumIndex].instrument)"
        }
    }
    
    
    
    override func viewDidLayoutSubviews()
    {
        for (idx: Int, pendulum: Pendulum) in enumerate(pendula)
        {
            pendulum.frame = CGRect(x: view.frame.width / 2, y: 20, width: 0, height: 0)
        }
        
        label.frame = CGRect(x: 0, y: view.frame.height - 30, width: view.frame.width, height: 30)
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

