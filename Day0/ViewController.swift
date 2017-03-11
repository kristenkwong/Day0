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
    EmotionApi.shared.getScore(image: #imageLiteral(resourceName: "crying-sad-man"),completion: { result in
      switch result {
      case .success(let emotion):
        print(emotion)
        print(emotion.happyIndex)
        break
      case .failure(let error):
        break
      }
    })
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  
}

