//
//  API_Manager.swift
//  KeyurApp
//
//  Created by Keyur on 11/02/23.
//

import Foundation
import SystemConfiguration

public class APIManager {
    
    static let sharedInstance = APIManager()
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func networkErrorMsg()
    {
        showAlert("Network Error", "You are not connected to the internet")
    }
    
    //MARK:- I AM COOL
    func callGetRequest(strUrl: String, _ completion: @escaping (_ data: Data?) -> Void){
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }
        
        print("URL = \(strUrl)")
        
        guard let url = URL(string: strUrl) else {return}

        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
            completion(data)
        }

        task.resume()
        semaphore.wait()
    }
}
