//
//  ViewController.swift
//  PendulaTone
//
//  Created by Simon Gladman on 13/01/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var pendula = [Pendulum]()
    let notes = [261.6,	277.2,	293.7,	311.1,	329.6,	349.2,	370.0,	392.0,	415.3,	440.0,	466.2,	493.9]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGrayColor()

        for (idx: Int, noteFrequency: Double) in enumerate(notes)
        {
            let i = idx + 5
            let pendulumDuration = (15 / Float(i))
            let pendulumLength = (21 - i) * 25
            
            let pendulum = Pendulum(pendulumDuration: pendulumDuration , pendulumLength: pendulumLength, noteFrequency: noteFrequency)
            
            pendula.append(pendulum)
            view.addSubview(pendulum)
        }

        AKOrchestra.start()
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

