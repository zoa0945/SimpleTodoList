//
//  BannerAdView.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 5/12/25.
//

import SwiftUI
import GoogleMobileAds

struct BannerAdView: UIViewRepresentable {
    func updateUIView(_ uiView: BannerView, context: Context) {
    }
    
    var adUnitID: String
    
    func makeUIView(context: Context) -> BannerView {
        let banner = BannerView(adSize: AdSizeBanner)
        banner.adUnitID = adUnitID
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(Request())
        return banner
    }
    
}
