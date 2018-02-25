//
//  FirstViewController.swift
//  siri_demo
//
//  Created by jxy on 21/02/2018.
//  Copyright © 2018 labmbda. All rights reserved.
//

import UIKit
import DemoKit

class FirstViewController: UIViewController {

    @IBOutlet weak var ac_on: UIButton!
    @IBOutlet weak var ac_off: UIButton!
    @IBOutlet weak var mayi: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
        


    
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        var url:String="http://www.baidu.com";
        if sender === ac_on {
            url="http://192.168.1.239/ac/on";
        } else if sender === ac_off {
            url="http://192.168.1.239/ac/off";
        } else if sender === mayi {
            url="alipay://platformapi/startapp?appId=60000002";
        }
        
        Utils.sharded.load(url: URL(string:url)!);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

