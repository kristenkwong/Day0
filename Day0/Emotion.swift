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
  var happyIndex: (emotion: String, value: Double) {
    let scores  = [happiness, surprise, anger, fear, contempt, disgust, sadness]
    let scoreString = ["happiness", "surprise", "anger", "fear", "contempt", "disgust", "sadeness"]
    let maxScore = scores.max()
    let maxIndex = Int(scores.index(of: maxScore!)!)
    return (emotion: scoreString[maxIndex], value: maxScore!)
  }
}
