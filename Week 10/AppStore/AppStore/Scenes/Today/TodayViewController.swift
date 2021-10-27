//
//  TodayViewController.swift
//  AppStore
//
//  Created by 이재웅 on 2021/10/22.
//

import UIKit
import SnapKit

// TodayViewController를 상속할 class는 없기 때문에 final로 선언
final class TodayViewController: UIViewController {
    // Today.plist의 값을 가질 변수선언
    private var todayList: [Today] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: "todayCell")
        // Header와 Footer는 forSupplementaryViewOfKind가 있는 register를 사용해야함
        collectionView.register(TodayCollectionHeaderView.self,
                                // string값을 직접 써도 되고 다음과 같이 UICollectionView.elementKindSectionHeader로 작성해도 됨
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "TodayCollectionHeaderView")
    
            return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // 이번 데이터는 네트워크 통신이 아니고 로컬로 이용하기 때문에 UI가 모두 불러진 후 데이터를 가져옴
        fetchData()
    }
    
}

extension TodayViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width - 32.0
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width - 32.0, height: 100.0)
    }
    
    // Header와 CollectionView 사이의 inset을 위한 메소드(insetForSectionAt 검색)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let value: CGFloat = 16.0
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let today = todayList[indexPath.item]
        let vc = AppDetailViewController(today: today)
        // viewController는 present 메소드를 가지고 있기 때문에 self. 를 생략 가능
        present(vc, animated: true) // completion은 present가 완료됬을 때 어떤 액션을 넣을지. 옵셔널이고 넣을건 따로 없으니 제거
    }
}

extension TodayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
        return todayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todayCell", for: indexPath) as? TodayCollectionViewCell
        
        let today = todayList[indexPath.item]
        cell?.setup(today: today)
        
        return cell ?? UICollectionViewCell()
    }
    
    // Header와 Footer를 리턴해주는 메소드(viewForSupplementaryElementOfKind 검색)
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Header와 Footer 모두 동일한 메소드를 요청하기 때문에 구분해주는 것이 필요함
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "TodayCollectionHeaderView",
                for: indexPath
              ) as? TodayCollectionHeaderView
        else { return UICollectionReusableView() }
        
        header.setupViews()
        
        return header
    }
}

private extension TodayViewController {
    // plist에서 값을 가져올 메소드
    func fetchData() {
        // plist도 Bundle이라는 디렉토리 안에서 url이 되기때문에 URL데이터를 가져오는 것과 동일하게 선언
        guard let url = Bundle.main.url(forResource: "Today", withExtension: "plist") else { return }
        do {
            let data = try Data(contentsOf: url)
            // PropertyListDecoder를 활용해 디코딩
            let result = try PropertyListDecoder().decode([Today].self, from: data)
            todayList = result      // plist로부터 데이터 가져오기 완료
        } catch {
            
        }
        
    }
}
