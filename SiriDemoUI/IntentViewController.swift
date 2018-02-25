//
//  IntentViewController.swift
//  SiriDemoUI
//
//  Created by jxy on 25/02/2018.
//  Copyright © 2018 labmbda. All rights reserved.
//

import IntentsUI
import DemoKit

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
    var lastIntent:INSendMessageIntent = INSendMessageIntent();
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - INUIHostedViewControlling
    
//    // Prepare your view controller for the interaction to handle.
//    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
//        // Do configuration here, including preparing views and calculating a desired size for presentation.
//        let content:String=(interaction.intent as! INSendMessageIntent).content!;
//        if  !(content.isEmpty) && !content.elementsEqual(self.lastContent) && !content.elementsEqual("success"){
////            self.extensionContext?.open(URL(string:content)!, completionHandler: nil)
//            self.lastContent=content;
//        }
//        completion(true,parameters,self.desiredSize);
////        completion(true, parameters, self.desiredSize);
//    }
    
    func configure(with interaction: INInteraction, context: INUIHostedViewContext, completion: @escaping (CGSize) -> Void) {
        let intent=interaction.intent as! INSendMessageIntent;
        let content:String=(intent).content!;
        if  !(content.isEmpty) && !intent.isEqual(self.lastIntent) && !content.elementsEqual("success"){
            self.extensionContext?.open(URL(string:content)!, completionHandler: nil)
            self.lastIntent=intent;
        }
        completion(self.desiredSize);
    }
    
    var desiredSize: CGSize {
        return self.extensionContext!.hostedViewMinimumAllowedSize
    }
    
    
    
}
