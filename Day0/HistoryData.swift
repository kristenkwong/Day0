//
//  HistoryData.swift
//  Day0
//
//  Created by Milton Leung on 2017-03-11.
//  Copyright © 2017 0mbps. All rights reserved.
//

import Foundation

public class HistoryData {
  static public let shared = HistoryData()
  let defaults = UserDefaults.standard
}

extension HistoryData {
  func getEmojiHistory() -> String {
//    defaults.set("😱😡😂😂😫🦁😡😂🦁😂😫😫😫😡🦁🦁😡😫🤢😡😱😫😡😂😂😱😡😫😫😂😫😂🦁🦁", forKey: "emojiHistory")
    let emojiHistory = defaults.string(forKey: "emojiHistory")
    return emojiHistory ?? ""
  }
  
  func saveEmojiHistory(emoji: String) {
    var emojiString = ""
    switch emoji {
    case "anger":
      emojiString =  "😡"
    case "fear":
      emojiString =  "😱"
    case "surprise":
      emojiString =  "😳"
    case "contempt":
      emojiString =  "😒"
    case "disgust":
      emojiString =  "🤢"
    case "happiness":
      emojiString =  "😂"
    case "neutral":
      emojiString =  "🦁"
    case "sadness":
      emojiString =  "😫"
    default:
      emojiString =  "😫"
    }
    var emojiHistory = defaults.string(forKey: "emojiHistory")
    if emojiHistory == nil {
      emojiHistory = emojiString
    } else {
      emojiHistory = "\(emojiHistory!)\(emojiString)"
    }
    defaults.set(emojiHistory, forKey: "emojiHistory")
    defaults.synchronize()
  }
  
  func getHappyIndexes() -> [Double] {
    let happyIndexes = defaults.array(forKey: "happyIndexes") as? [Double]
    return happyIndexes ?? []
  }
  
  func saveHappyIndex(index: Double) {
    var happyIndexes = defaults.array(forKey: "happyIndexes") as? [Double]
    if happyIndexes == nil {
      happyIndexes = [index]
    } else {
      happyIndexes?.append(index)
    }
    defaults.set(happyIndexes, forKey: "happyIndexes")
  }
}
