//
//  navigationViewController.swift
//  NIGHTPLANNER_V2
//
//  Created by Enterface Team on 2017-07-19.
//  Copyright © 2017 Enterface . All rights reserved.
//

import UIKit

class navigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func hidebar() {
        self.navigationBar.isHidden = true
    }
    
    func showbar() {
        self.navigationBar.isHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        let backItem = UIBarButtonItem()
        
        backItem.title = ""
        self.navigationBar.tintColor = Utility().hexStringToUIColor(hex: "#6CA743")
        
        for x in self.viewControllers {
            x.navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
