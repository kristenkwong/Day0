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
  
  @IBOutlet weak var text: UILabel!
  var emotion: Emotion!
  var state: PhotoState!
  var delegate: PicturePopupViewControllerDelegate?
  var string: String!
  override func viewDidLoad() {
    super.viewDidLoad()
    text.text = string
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "graphView" {
      let destination = segue.destination as! RadarChartViewController
      destination.emotion = emotion
    }
  }
  
  @IBAction func dismissTapped(_ sender: UIButton) {
    
    var NewState: PhotoState!
    
    switch(state!)
    {
    case (PhotoState.Delayed):
      NewState = PhotoState.FirstPhotoTaken
      break;
    case (PhotoState.FirstPhotoTaken):
      NewState = PhotoState.SecondPhoto
      break;
    case(PhotoState.SecondPhoto):
      NewState = PhotoState.SecondPhotoTaken
      break;
    default:
      NewState = PhotoState.Delayed
      break;
    }
    delegate?.dismissTapped(state: NewState)
    self.dismiss(animated: true, completion: nil)
  }
  
}
