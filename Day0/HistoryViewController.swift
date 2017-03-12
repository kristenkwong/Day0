//
//  HistoryViewController.swift
//  Day0
//
//  Created by Milton Leung on 2017-03-11.
//  Copyright © 2017 0mbps. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
  
  @IBOutlet weak var historyTextView: UITextView!
  override func viewDidLoad() {
    super.viewDidLoad()
    historyTextView.text = HistoryData.shared.getEmojiHistory()
//    HistoryData.shared.saveEmojiHistory(emoji: "😱😡😂😂😡😂😂😡😡🤢😡😱😡😂😂😱😡😂😂")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
