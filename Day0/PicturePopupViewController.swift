//
//  PicturePopupViewController.swift
//  Day0
//
//  Created by Milton Leung on 2017-03-11.
//  Copyright © 2017 0mbps. All rights reserved.
//

import UIKit

protocol PicturePopupViewControllerDelegate {
  func dismissTapped()
}

class PicturePopupViewController: UIViewController {
  @IBOutlet weak var mainView: UIView! {
    didSet {
      mainView.layer.cornerRadius = 5
      mainView.layer.shadowColor = UIColor.clear.cgColor
      mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
      mainView.layer.shadowOpacity = 0.25
      mainView.layer.shadowRadius = 5.0
    }
  }
  
  var delegate: PicturePopupViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = UIColor.clear
    view.isOpaque = false

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func dismissTapped(_ sender: UIButton) {
    delegate?.dismissTapped()
    self.dismiss(animated: true, completion: nil)
  }
  
}
