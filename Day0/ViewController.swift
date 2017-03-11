//
//  ViewController.swift
//  Day0
//
//  Created by SW DEV on 3/10/17.
//  Copyright © 2017 0mbps. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire
import Charts

class ViewController: UIViewController {
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib
    test_api()
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func test_api()
  {
    let content_type = "application/octet-stream"
    let key = "2a3cb186c5404b4b9eb2b1f796ba2f6b "
    let test_image = UIImage(named: "obama_smiling")
    let image_data = UIImageJPEGRepresentation(test_image!, CGFloat(1.0))
    
    
    var request = URLRequest(url: URL(string: String("https://westus.api.cognitive.microsoft.com/emotion/v1.0/recognize"))!)
    
    request.httpMethod = "POST"
    request.setValue(content_type, forHTTPHeaderField: "Content-Type")
    request.setValue(key, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
    request.httpBody = image_data
    
    URLSession.shared.dataTask(with: request){(data, response, error) in
      print("In completion handler")
      guard error == nil && data != nil else
      {
        if( error != nil){print(error.debugDescription)}
        if( data == nil){print("empty data")}
        return
      }
      
      print(response.debugDescription)
      let json = JSON(data: data!)
      if let scores = json[0]["score"].string
      {
        /* Identify the score for each emotion */
        print(scores)
      }
      else
      {
        print(json[0]["score"])
      }
    }.resume()
  }
}

