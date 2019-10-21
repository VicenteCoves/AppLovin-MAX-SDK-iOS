//
//  ALRewardedAdViewController.swift
//  DemoApp-Swift
//
//  Created by Andrew Tian on 9/20/19.
//  Copyright © 2019 AppLovin. All rights reserved.
//

import UIKit
import AppLovinSDK

class ALRewardedAdViewController: ALBaseAdViewController, MARewardedAdDelegate
{
    private let rewardedAd = MARewardedAd.shared(withAdUnitIdentifier: "YOUR_AD_UNIT_ID")
    
    // MARK: View Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        rewardedAd.delegate = self
        
        // Load the first ad
        rewardedAd.load()
    }
    
    // MARK: IB Actions
    
    @IBAction func showAd()
    {
        rewardedAd.show()
    }
    
    // MARK: MAAdDelegate Protocol
    
    func didLoad(_ ad: MAAd)
    {
        // Rewarded ad is ready to be shown. '[self.rewardedAd isReady]' will now return 'YES'
        logCallback()
    }
    
    func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withErrorCode errorCode: Int)
    {
        logCallback()
        
        // Rewarded ad failed to load. We recommend re-trying in 3 seconds.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(3 * Double(NSEC_PER_SEC)), execute: {
            self.rewardedAd.load()
        })
    }
    
    func didDisplay(_ ad: MAAd) { logCallback() }
    
    func didClick(_ ad: MAAd) { logCallback() }
    
    func didHide(_ ad: MAAd)
    {
        logCallback()
        
        // Rewarded ad is hidden. Pre-load the next ad
        rewardedAd.load()
    }
    
    func didFail(toDisplay ad: MAAd, withErrorCode errorCode: Int)
    {
        logCallback()
        
        // Rewarded ad failed to display. We recommend loading the next ad
        rewardedAd.load()
    }
    
    // MARK: MARewardedAdDelegate Protocol
    
    func didStartRewardedVideo(for ad: MAAd) { logCallback() }
    
    func didCompleteRewardedVideo(for ad: MAAd) { logCallback() }
    
    func didRewardUser(for ad: MAAd, with reward: MAReward)
    {
        // Rewarded ad was displayed and user should receive the reward
        logCallback()
    }
}