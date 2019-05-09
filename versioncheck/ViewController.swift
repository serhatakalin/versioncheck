//
//  ViewController.swift
//  versioncheck
//
//  Created by Serhat Akalin on 9.05.2019.
//  Copyright © 2019 Serhat Akalin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var isUpdate : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VersionCheck.storeCheckForUpdate {(isUpdate) in
            if isUpdate {
                let alert = UIAlertController(title: "Warning", message: "new version available!", preferredStyle: UIAlertController.Style.alert)
                
                // Create the actions
                let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    
                    print("appstore is opening")
                    VersionCheck.openAppStore()
                }
                let cancelAction = UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                    print("dismiss")
                }
                
                // Add the actions
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)

            }
        }
    }


}

