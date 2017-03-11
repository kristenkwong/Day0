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
    let emojiHistory = defaults.string(forKey: "emojiHistory")
    return emojiHistory ?? ""
  }
  
  func saveEmojiHistory(emoji: String) {
    var emojiHistory = defaults.string(forKey: "emojiHistory")
    if emojiHistory == nil {
      emojiHistory = emoji
    } else {
      emojiHistory = "\(emojiHistory)\(emoji)"
    }
    defaults.set(emojiHistory, forKey: "emojiHistory")
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
