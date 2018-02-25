//
//  webServer.swift
//  siri_demo
//
//  Created by jxy on 25/02/2018.
//  Copyright © 2018 labmbda. All rights reserved.
//

import Foundation
import GCDWebServer
import DemoKit

func initWebServer() {
    
    let webServer = GCDWebServer()
    
    webServer.addDefaultHandler(forMethod: "GET", request: GCDWebServerRequest.self, processBlock: {request in
        
        let baseURLCount:Int=(request.url.baseURL?.absoluteString.count)!;
        let abString=request.url.absoluteString;
        var aim=request.url.absoluteString.suffix(abString.count-baseURLCount);
        let url=URL(string:String(aim))!;
        if ((url.scheme) != nil) && !(url.scheme?.isEmpty)!{
            Utils.sharded.load(url: url);
            aim="runned! "+aim;
        }
        return GCDWebServerDataResponse(html:"<html><body><p>"+aim+"</p></body></html>")
    })
    do {
        try webServer.start(options: [GCDWebServerOption_Port: 12345,
                                      GCDWebServerOption_BindToLocalhost: true,
                                      GCDWebServerOption_AutomaticallySuspendInBackground: false])
    } catch let error as NSError  {
        print("Error: \(error.domain)");
    }
    

    
    
    print("Visit \(webServer.serverURL) in your web browser")
}
