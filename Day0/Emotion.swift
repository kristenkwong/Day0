//
//  Emotion.swift
//  Day0
//
//  Created by Milton Leung on 2017-03-10.
//  Copyright © 2017 0mbps. All rights reserved.
//

import Foundation
import SwiftyJSON

enum Emotions: Int {
  case anger, fear, surprise, contempt, disgust, happiness, neutral, sadness
  
  var emoji: String {
    switch self {
    case .anger:
      return "😡"
    case .fear:
      return "😱"
    case .surprise:
      return "😳"
    case .contempt:
      return "😒"
    case .disgust:
      return "🤢"
    case .happiness:
      return "😂"
    case .neutral:
      return "🦁"
    case .sadness:
      return "😫"
    }
  }
}



public struct Emotion {
  public let anger: Double
  public let fear: Double
  public let surprise: Double
  public let contempt: Double
  public let disgust: Double
  public let happiness: Double
  public let neutral: Double
  public let sadness: Double
  
  init(json: JSON) {
    anger = json["scores"]["anger"].doubleValue
    fear = json["scores"]["fear"].doubleValue
    surprise = json["scores"]["surprise"].doubleValue
    contempt = json["scores"]["contempt"].doubleValue
    disgust = json["scores"]["disgust"].doubleValue
    happiness = json["scores"]["happiness"].doubleValue
    neutral = json["scores"]["neutral"].doubleValue
    sadness = json["scores"]["sadness"].doubleValue
  }
}

extension Emotion {
  var happyIndex: Double {
    let positive = [happiness, surprise]
    let negative = [anger, fear, contempt, disgust, sadness]
    return positive.max()! - negative.max()!
  }
}
