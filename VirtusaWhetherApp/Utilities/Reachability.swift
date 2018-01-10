//
//  Reachability.swift
//  VirtusaWhetherApp
//
//  Created by Surendra Singh on 1/8/18.
//  Copyright © 2018 Surendra Singh. All rights reserved.
//

import Foundation
import SystemConfiguration

class Reachability{
   
    func isConnectedtoNetwork() -> Bool
    {
        var address = sockaddr_in();
        address.sin_len = UInt8(MemoryLayout.size(ofValue: address));
        address.sin_family = sa_family_t(AF_INET);
        
        guard let defaultRoute = withUnsafePointer(to: &address, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags : SCNetworkReachabilityFlags = [];
        if !SCNetworkReachabilityGetFlags(defaultRoute, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable);
        let needConnection = flags.contains(.connectionRequired);
        
        return(isReachable && !needConnection);
    }
    
    func isHostRechable(url:String)->Bool{
        var isRechable:Bool = false
        let url = NSURL(string: url)
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "HEAD"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        var response: URLResponse?        
        do{
            let _ = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: &response) as NSData?
        }catch let error as NSError {
            print(error)
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                isRechable = true
            }
        }
        
        return isRechable
    }
}
