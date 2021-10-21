//
//  AssetSectionView.swift
//  MyAssets
//
//  Created by 이재웅 on 2021/10/21.
//

import SwiftUI

struct AssetSectionView: View {
    //ObservableObject 타입의 클래스를 @ObservedObject라는 PropertyWrapper를 통해서 연결을 해준것
    @ObservedObject var assetSection: Asset
    
    var body: some View {
        VStack(spacing: 20) {
            AssetSectionHeaderView(title: assetSection.type.title)
            ForEach(assetSection.data) { asset in
                HStack {
                    Text(asset.title)
                        .font(.title)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(asset.amount)
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                Divider()
            }
        }
        .padding()
    }
}

struct AssetSectionView_Previews: PreviewProvider {
    static var previews: some View {
        let asset = Asset(
            id: 0,
            type: .bankAccount,
            data: [
                AssetData(id: 0, title: "신한은행", amount: "5,300,000원"),
                AssetData(id: 1, title: "국민은행", amount: "2,700,000원"),
                AssetData(id: 2, title: "카카오뱅크", amount: "98,830,000원")
            ]
        )
        AssetSectionView(assetSection: asset)
    }
}
