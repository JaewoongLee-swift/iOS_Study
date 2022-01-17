//
//  SearchBar.swift
//  SearchDaumBlog
//
//  Created by 이재웅 on 2022/01/17.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchBar: UISearchBar {
    let disposeBag = DisposeBag()
    
    let searchButton = UIButton()
    
    //SearchBar 버튼 탭 이벤트
    let searchButtonTapped = PublishRelay<Void>()       // PublishSubject를 wrapping하고 있지만 에러는 받지않고 onNext만 내보냄
    // 버튼은 어떠한 값이 전달되진 않고 이벤트만 발생하기 때문에 Void
    
    //SearchBar 외부로 내보낼 이벤트
    var shouldLoadResult = Observable<String>.of("")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        //Searchbar search button tapped (키보드 검색버튼)
        //button tapped
        
        Observable
            .merge(
                self.rx.searchButtonClicked.asObservable(),
                searchButton.rx.tap.asObservable()
            )
            .bind(to: searchButtonTapped)
            .disposed(by: disposeBag)
        
        searchButtonTapped
            .asSignal()
            .emit(to: self.rx.endEditing)
            .disposed(by: disposeBag)
        
        //searchButton이 눌려졌을때 입력된 텍스트를 외부에 연결을 시켜줘야함. 따라서 shouldLoadResult가 어떠한 텍스트를 받을지 연결해줘야함.
        self.shouldLoadResult = searchButtonTapped
            .withLatestFrom(self.rx.text) { $1 ?? "" }
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
    }
    
    private func attribute() {
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    private func layout() {
        addSubview(searchButton)
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12.0)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12.0)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12.0)
        }
    }
}

extension Reactive where Base: SearchBar {
    var endEditing: Binder<Void> {
        // base라는 것은 SearchBar를 의미
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    }
}
