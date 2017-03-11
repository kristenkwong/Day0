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


class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate
{
  let CaptureSession = AVCaptureSession()
  let CapturePhotoOutput = AVCapturePhotoOutput()

  
  @IBAction func TakePhotoButton(_ sender: UIButton)
  {
    let CapturePhotoSetting = AVCapturePhotoSettings(format: [AVVideoCodecKey: "jpeg"])
    CapturePhotoOutput.capturePhoto(with: CapturePhotoSetting, delegate: self)
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
        print(emotion)
        print(emotion.happyIndex)
        break
      case .failure(let error):
        break
      }
    })
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
