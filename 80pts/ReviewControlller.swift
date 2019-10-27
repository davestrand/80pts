//
//  ReviewControlller.swift
//  80pts
//
//  Created by Dave Levy on 10/27/19.
//  Copyright © 2019 mcc. All rights reserved.
//

import StoreKit

enum AppStoreReviewManager {
    
    
//
//// 1.
//static let minimumReviewWorthyActionCount = 3
//
//static func requestReviewIfAppropriate() {
//  let defaults = UserDefaults.standard
//  let bundle = Bundle.main
//
//  // 2.
//  var actionCount = defaults.integer(forKey: .reviewWorthyActionCount)
//
//  // 3.
//  actionCount += 1
//
//  // 4.
//  defaults.set(actionCount, forKey: .reviewWorthyActionCount)
//
//  // 5.
//  guard actionCount >= minimumReviewWorthyActionCount else {
//    return
//  }
//
//  // 6.
//  let bundleVersionKey = kCFBundleVersionKey as String
//  let currentVersion = bundle.object(forInfoDictionaryKey: bundleVersionKey) as? String
//  let lastVersion = defaults.string(forKey: .lastReviewRequestAppVersion)
//
//  // 7.
//  guard lastVersion == nil || lastVersion != currentVersion else {
//    return
//  }
//
//  // 8.
//  SKStoreReviewController.requestReview()
//
//  // 9.
//  defaults.set(0, forKey: .reviewWorthyActionCount)
//  defaults.set(currentVersion, forKey: .lastReviewRequestAppVersion)
}
