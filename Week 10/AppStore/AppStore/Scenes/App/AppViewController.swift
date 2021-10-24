//
//  AppViewController.swift
//  AppStore
//
//  Created by 이재웅 on 2021/10/22.
//

import SnapKit
import UIKit

final class AppViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        //subView 본인의 높이로 자동으로 뷰의 크기가 설정됨
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0
        
        let featureSectionView = FeatuerSectionView(frame: .zero)
        let rankingFeaturesSectionView = RankingFeatureSectionView(frame: .zero)
        let exchangeCodeButtonView = ExchangeCodeButtonView(frame: .zero)
        
        // 스크롤을 올렸을 때 가장 하단에 있는 항목이 여유있게 보일 수 있는 디자인을 애플에서 권장함. 따라서 최하단에 여백뷰를 넣음
        let spacingView = UIView()
        spacingView.snp.makeConstraints {
            $0.height.equalTo(50.0)
        }
        
        [
            featureSectionView,
            rankingFeaturesSectionView,
            exchangeCodeButtonView,
            spacingView
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupLayout()
    }
    
}

// extension으로 수정한 것은 강사님 취향
private extension AppViewController {
    // 무조건 largeTitle을 불러올 수 있도록 함
    func setupNavigationController() {
        navigationItem.title = "앱"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            // width를 Superview와 동일하게 설정하면 상하 스크롤 가능(height일 경우, 좌우 스크롤 가능)
            $0.width.equalToSuperview()
        }
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            // width는 지정하되, height은 본인의 subView에 맞게 크기가 조정될 것이기 때문에 고정시키면 안됨
            $0.edges.equalToSuperview()
        }
    }
}
