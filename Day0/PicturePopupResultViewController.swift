//
//  PicturePopupResultViewController.swift
//  Day0
//
//  Created by Milton Leung on 2017-03-11.
//  Copyright © 2017 0mbps. All rights reserved.
//

import UIKit

class PicturePopupResultViewController: UIViewController {
  @IBOutlet weak var mainView: UIView! {
    didSet {
      mainView.layer.cornerRadius = 5
      
      mainView.layer.shadowColor = UIColor.black.cgColor
      mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
      mainView.layer.shadowOpacity = 0.25
      mainView.layer.shadowRadius = 5.0
    }
  }
  
  var emotion: Emotion!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "graphView" {
      let destination = segue.destination as! RadarChartViewController
      destination.emotion = emotion
    }
  }
  
  @IBAction func dismissTapped(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
