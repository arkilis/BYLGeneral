//
//  BYLAppReview.swift
//
//  Created by Ben Liu on 3/5/21.
//

// Usage
// Step1: 在Appdelegate的didFinishLaunchingWithOptions中:
/*
if(BYLAppReview.shared.runCounts == 0) {
  BYLAppReview.shared.setup()
}
BYLAppReview.shared.runCounts += 1
*/
// Step 2: 在SceneDelegate的connectionOptions:

/*
window.makeKeyAndVisible()
...
BYLAppReview.shared.show(windowScene: windowScene)
}
*/

import Foundation
import StoreKit

public class BYLAppReview {
  
  static let shared = BYLAppReview()
  
  private let runCountsKey = "runCounts"
  private let showInTimesKey = "showInTimes"
  private let defaultTimes = [2, 4, 8]
  
  var runCounts: Int {
    get {
      return UserDefaults.standard.integer(forKey: runCountsKey)
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: runCountsKey)
    }
  }
  
  // three chances to show in-app review
  private var showInTimes: [Int] {
    get {
      return (UserDefaults.standard.array(forKey: showInTimesKey) ?? defaultTimes) as! [Int]
    }
    
    set {
      UserDefaults.standard.setValue(newValue, forKey: showInTimesKey)
    }
  }
  
  
  func setup(showInTimes: [Int]? = nil) {
    self.showInTimes = showInTimes ?? defaultTimes
    self.runCounts = 0
  }
  
  func show(windowScene: UIWindowScene) {
    #if DEBUG
    print("BYLAppReview: runCounts = \(runCounts)" )
    #endif
    if (self.showInTimes.contains(self.runCounts)) {
      #if DEBUG
      print("BYLAppReview: In-App review shows")
      #endif
      if #available(iOS 14.0, *) {
        SKStoreReviewController.requestReview(in: windowScene)
      } else {
        // Fallback on earlier versions
      }
    }
  }
  
}
