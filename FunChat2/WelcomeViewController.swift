//
//  WelcomeViewController.swift
//  funChat
//
//  Created by David Zielski on 5/17/16.
//  Copyright © 2016 mobiledez. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    let backendless = Backendless.sharedInstance()
    var currentUser: BackendlessUser?
    
    override func viewWillAppear(animated: Bool) {
        backendless.userService.setStayLoggedIn(true)

        currentUser = backendless.userService.currentUser
        
        if currentUser != nil  // if current user already logged in, skip login
        {
            // make sure on main queue - was giving a warning when running
            dispatch_async(dispatch_get_main_queue())
            {
            
                // here segue to recents vc
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChatVC") as! UITabBarController
                vc.selectedIndex = 0  //default to first one
            
                self.presentViewController(vc, animated: true, completion: nil)
            }
         }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
