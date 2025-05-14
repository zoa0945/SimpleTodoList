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
        if let rootViewController = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow })?.rootViewController {
            banner.rootViewController = rootViewController
        }
        banner.load(Request())
        return banner
    }
    
}
