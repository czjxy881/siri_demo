//
//  OpenUtils.swift
//  siri_demo
//
//  Created by jxy on 25/02/2018.
//  Copyright © 2018 labmbda. All rights reserved.
//

import Foundation
import UIKit
class OpenUtils {
    static let sharedInstance=OpenUtils();
    func openURL(url:URL) -> String {
        UIApplication.shared.open(url, options: [:], completionHandler: nil);
        return "success";
    }
}
