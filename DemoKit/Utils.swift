//
//  Utils.swift
//  siri_demo
//
//  Created by jxy on 25/02/2018.
//  Copyright © 2018 labmbda. All rights reserved.
//

import Foundation
import UIKit

public class Utils {
    public static let sharded:Utils=Utils();
    public var openURL: ((URL)->())?=nil;
    public func load(url: URL)->String {
        var result:String="success";
        if(url.scheme?.starts(with: "http"))!{
            let sessionConfig = URLSessionConfiguration.default;
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            let request = URLRequest(url: url);
            
            let task = session.dataTask(with: request) {
                (data, response, error) in
                // check for any errors
                guard error == nil else {
                    print("error calling GET on " + url.absoluteString);
                    print(error!)
                    result="error";
                    return;
                }
                result="success";
                return ;
                
            }
            task.resume();
        }else{
            if(self.openURL==nil){
                return "failed";
            }
            self.openURL?(url);
        }
        return result;
    }

}

