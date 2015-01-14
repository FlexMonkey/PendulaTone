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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        for i in 3 ... 20
        {
            let pendulumLength = 30 / Float(i)
            
            let pendulum = Pendulum(pendulumLength: pendulumLength , index: 21 - i)
            
            pendula.append(pendulum)
            view.addSubview(pendulum)
        }
    }

    override func viewDidLayoutSubviews()
    {
        for (idx: Int, pendulum: Pendulum) in enumerate(pendula)
        {
            pendulum.frame = CGRect(x: view.frame.width / 2, y: 20, width: 0, height: 0)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

