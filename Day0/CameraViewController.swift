//
//  CameraViewController.swift
//  Day0
//
//  Created by Zheyang Li on 2017-03-11.
//  Copyright © 2017 0mbps. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

enum PhotoState: Int
{
  case Start, Delayed, FirstPhotoTaken,  SecondPhotoTaken
}

var firstEmotion: (emotion: String, value: Double)?
var secondEmotion: (emotion: String, value: Double)?

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate
{
  
  let CaptureSession = AVCaptureSession()
  let CapturePhotoOutput = AVCapturePhotoOutput()
//  var IsPopup = false
  var CurrentPhotoState = PhotoState.Start
  
  @IBAction func TakePhotoButton(_ sender: UIButton)
  {
    let CapturePhotoSetting = AVCapturePhotoSettings(format: [AVVideoCodecKey: "jpeg"])
    CapturePhotoOutput.capturePhoto(with: CapturePhotoSetting, delegate: self)
  }
  
  override func viewWillAppear(_ animated: Bool)
  {
    if(CurrentPhotoState == PhotoState.Start)
    {
      segueToReadyPopup()
    }
    
    if(CurrentPhotoState == PhotoState.SecondPhotoTaken)
    {
      CurrentPhotoState = PhotoState.Delayed
      // Go to a differnet view controller
    }
  }
  
  override func viewWillDisappear(_ animated: Bool)
  {
    if(CurrentPhotoState == PhotoState.Delayed ||
       CurrentPhotoState == PhotoState.SecondPhotoTaken)
    {
      CurrentPhotoState = PhotoState.Start
    }
  }
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    let device = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera,
                                               mediaType: AVMediaTypeVideo,
                                               position: .front)
    do {
      try CaptureSession.addInput(AVCaptureDeviceInput(device: device))
    }
    catch (let error)
    {
      print(error)
    }
    
   // CapturePhotoOutput.capturePhoto(with: CapturePhotoSetting, delegate: self)
    
    CaptureSession.sessionPreset = AVCaptureSessionPresetPhoto
    CaptureSession.startRunning()
    
    if(CaptureSession.canAddOutput(CapturePhotoOutput))
    {
      CaptureSession.addOutput(CapturePhotoOutput)
    }
    
    if let PreviewLayer = AVCaptureVideoPreviewLayer(session: CaptureSession)
    {
      PreviewLayer.bounds = view.bounds
      PreviewLayer.position = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
      PreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
      let CameraPreview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.size.width, height: view.bounds.size.height))
      CameraPreview.layer.addSublayer(PreviewLayer)
      view.insertSubview(CameraPreview, at: 0)
    }
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  /* Delegate methods */
  func capture(_ captureOutput: AVCapturePhotoOutput,
               didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?,
               previewPhotoSampleBuffer: CMSampleBuffer?,
               resolvedSettings: AVCaptureResolvedPhotoSettings,
               bracketSettings: AVCaptureBracketedStillImageSettings?,
               error: Error?)
  {
    
    if( error != nil)
    {
      print(error)
      return
    }
    
    let ImageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
    
    EmotionApi.shared.getScore(image: UIImage(data: ImageData!)!,completion: { result in
      switch result {
      case .success(let emotion):
        DispatchQueue.main.async {
          self.segueToResultPopup(emotion: emotion)

        }
        print(emotion)
        print(emotion.happyIndex)
        break
      case .failure(let error):
        break
      }
    })
  }
  func segueToReadyPopup() {
    let storyboard = UIStoryboard(name: "PicturePopup", bundle: nil)
    let captureReady = storyboard.instantiateViewController(withIdentifier: "readyPopup") as!PicturePopupViewController
    captureReady.delegate = self
    present(captureReady, animated: true, completion: nil)
  }
  
  func segueToResultPopup(emotion: Emotion) {
    let storyboard = UIStoryboard(name: "PicturePopup", bundle: nil)
    let pictureResult = storyboard.instantiateViewController(withIdentifier: "resultPopup") as!PicturePopupResultViewController
  
    pictureResult.emotion = emotion
    
    pictureResult.delegate = self
    pictureResult.state = CurrentPhotoState
    
    if(CurrentPhotoState == PhotoState.Delayed)
    {
      pictureResult.string = "Now try to think of the saddest thing that happened today. Then take a photo when you're ready!"
      firstEmotion = emotion.happyIndex
    }
    
    else if(CurrentPhotoState == PhotoState.FirstPhotoTaken)
    {
      pictureResult.string = "Done!"
      secondEmotion = emotion.happyIndex
      if firstEmotion!.value > secondEmotion!.value {
        HistoryData.shared.saveEmojiHistory(emoji: firstEmotion!.emotion)
      } else {
        HistoryData.shared.saveEmojiHistory(emoji: secondEmotion!.emotion)
      }
    }
    
    present(pictureResult, animated: true, completion: nil)
  }
}
extension CameraViewController: PicturePopupViewControllerDelegate {
  func dismissTapped(state: PhotoState) {
    CurrentPhotoState = state
  }
}
