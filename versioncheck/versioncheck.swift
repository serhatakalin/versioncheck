//
//  versioncheck.swift
//  versioncheck
//
//  Created by Serhat Akalin on 9.05.2019.
//  Copyright © 2019 Serhat Akalin. All rights reserved.
//

import UIKit

private struct StoreInfo {
    static let appVersion = Bundle.main.appVersion
    static let buildVersion = Bundle.main.buildVersionNumber
    static let appId = Bundle.main.appId
    static let baseUrl = "http://itunes.apple.com/lookup?bundleId="
    static let storeUrl = "itms-apps://"
}
class VersionCheck {
    
    class func storeCheckForUpdate(completion:@escaping(Bool)->()){
        
        guard let currentVersion = StoreInfo.appVersion,
            let storeIdentifier =  StoreInfo.appId,
            let url = URL(string: "\(StoreInfo.baseUrl)\(storeIdentifier)")
            else{
                print("something wrong")
                completion(false)
                return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, resopnse, error) in
            if error != nil{
                completion(false)
                print("something went wrong")
            }else{
                do{
                    guard let responseJson = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any],
                        let result = (responseJson["results"] as? [Any])?.first as? [String: Any],
                        let version = result["version"] as? String
                        else{
                            completion(false)
                            return
                    }
                    print("Current Ver:\(currentVersion)")
                    print("Prev version:\(version)")
                    if currentVersion != version{
                        completion(true)
                    }else{
                        completion(false)
                    }
                }
                catch{
                    completion(false)
                    print("Something went wrong")
                }
            }
        }
        task.resume()
    }
    
   class func openAppStore() {
        if let url = URL(string: StoreInfo.storeUrl),
            UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:]) { (opened) in
                if(opened){
                    print("App Store Opened")
                }
            }
        } else {
            print("Can't Open URL")
        }
    }

}

extension Bundle {
    
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var appVersion:String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var appId: String? {
        return infoDictionary?["CFBundleIdentifier"] as? String
    }
}
