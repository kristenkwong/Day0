//
//  SupportViewController.swift
//  Day0
//
//  Created by Kristen Kwong on 2017-03-11.
//  Copyright © 2017 0mbps. All rights reserved.
//

import UIKit

class SupportViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func mdabc(_ sender: Any) {
        
        let url = URL(string: "http://www.mdabc.net")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else{
            UIApplication.shared.openURL(url)
        }
        
    }
    
    @IBAction func callMDABC(_ sender: Any) {
        
        if let phoneCallURL = URL(string: "tel://\(6048730103)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
        
    }
    @IBAction func headspaceLink(_ sender: Any) {
        
        let url = URL(string: "http://www.headspace.com")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else{
            UIApplication.shared.openURL(url)
        }
        
    }
    
    @IBAction func anxietyBC(_ sender: Any) {
        
        let url = URL(string: "http://www.anxietybc.com")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else{
            UIApplication.shared.openURL(url)
        }
        
    }
    
    @IBAction func callHotline(_ sender: Any) {
        
        if let phoneCallURL = URL(string: "tel://\(18007842433)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
        
    }
    
    @IBAction func callVgh(_ sender: Any) {
        
        if let phoneCallURL = URL(string: "tel://\(6048754995)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
        
    }
    
    @IBAction func callMdabc(_ sender: Any) {
        
        if let phoneCallURL = URL(string: "tel://\(6048730103)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
        
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
