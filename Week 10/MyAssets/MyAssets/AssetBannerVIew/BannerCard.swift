//
//  BannerCard.swift
//  MyAssets
//
//  Created by 이재웅 on 2021/10/21.
//

import SwiftUI

struct BannerCard: View {
    var banner: AssetBanner
    
    var body: some View {
        Color(banner.backgroundColor)
            .overlay(
                VStack {
                    Text(banner.title)
                        .font(.title)
                    Text(banner.desciption)
                        .font(.subheadline)
                }
            )
    }
}

struct BannerCard_Previews: PreviewProvider {
    static var previews: some View {
        let banner0 = AssetBanner(title: "공지사항", desciption: "추가된 공지사항을 확인하세요", backgroundColor: .red)
        BannerCard(banner: banner0)
    }
}
