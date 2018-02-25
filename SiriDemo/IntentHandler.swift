//
//  IntentHandler.swift
//  SiriDemo
//
//  Created by jxy on 24/02/2018.
//  Copyright © 2018 labmbda. All rights reserved.
//

import Intents
import DemoKit;

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension ,  INSendMessageIntentHandling{
    
    
    
    var url:String = "";
    
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
    
    // MARK: - INSendMessageIntentHandling
    
    // Implement resolution methods to provide additional information about your intent (optional).
    func resolveRecipients(for intent: INSendMessageIntent, with completion: @escaping ([INSendMessageRecipientResolutionResult]) -> Void) {
        if(intent.recipients?.count==0){
            completion([INSendMessageRecipientResolutionResult.needsValue()]);return
        }
        guard let name=intent.recipients?[0].displayName else {completion([INSendMessageRecipientResolutionResult.needsValue()]);return};
        switch name {
        case "关空调":
            self.url="http://192.168.1.239/ac/off"
            break;
        case "开空调":
            self.url="http://192.168.1.239/ac/on"
            break
        case "蚂蚁森林":
            self.url="alipay://platformapi/startapp?appId=60000002"
        default:
            completion([INSendMessageRecipientResolutionResult.unsupported(forReason: .noAccount)]);
            return;
        }
        completion([INSendMessageRecipientResolutionResult.notRequired()]);
        
    }
    
    
    func resolveContent(for intent: INSendMessageIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let real_url = URL(string: self.url) else {
            return //be safe
        }
        var text=Utils.sharded.load(url: real_url);
        if(text=="failed"){
            text=url;
        }
        completion(INStringResolutionResult.success(with: text))
        
        
        
    }
    
    // Once resolution is completed, perform validation on the intent and provide confirmation (optional).
    
    func confirm(intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void) {
        // Verify user is authenticated and your app is ready to send a message.
        //        handler(intent:intent,completion:completion);
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSendMessageIntent.self))
        
        var response = INSendMessageIntentResponse(code: .ready, userActivity: userActivity)
        if(!(intent.content?.elementsEqual("success"))!){
            response = INSendMessageIntentResponse(code: .failureRequiringAppLaunch, userActivity: userActivity)
        }
        completion(response)
    }
    
    // Handle the completed intent (requ`ired).
    
    func handle(intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void) {
        // Implement your application logic to send a message here.
        
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSendMessageIntent.self))
        let response = INSendMessageIntentResponse(code: .success, userActivity: userActivity)
        completion(response)
    }
    
    
    
    
    
}

