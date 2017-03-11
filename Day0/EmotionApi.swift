//
//  EmotionApi.swift
//  Day0
//
//  Created by Milton Leung on 2017-03-10.
//  Copyright © 2017 0mbps. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum Result<Emotion> {
  case success(Emotion)
  case failure(error: String)
}

public class EmotionApi {
  static public let shared = EmotionApi()
}

extension EmotionApi {
  func getScore(image: UIImage, completion: @escaping (Result<Emotion>) -> ())
  {
    let content_type = "application/octet-stream"
    let key = "2a3cb186c5404b4b9eb2b1f796ba2f6b "
    let image_data = UIImageJPEGRepresentation(image, CGFloat(1.0))
    
    
    var request = URLRequest(url: URL(string: String("https://westus.api.cognitive.microsoft.com/emotion/v1.0/recognize"))!)
    
    request.httpMethod = "POST"
    request.setValue(content_type, forHTTPHeaderField: "Content-Type")
    request.setValue(key, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
    request.httpBody = image_data
    
    URLSession.shared.dataTask(with: request){(data, response, error) in
      guard error == nil && data != nil else
      {
        if (error != nil) {
          completion(.failure(error: error.debugDescription))
        }
        if (data == nil) {
          completion(.failure(error: "no data"))
        }
        return
      }
      
      let json = JSON(data: data!)
      let emotion = Emotion(json: json[0])
      completion(.success(emotion))
      }.resume()
  }
}
