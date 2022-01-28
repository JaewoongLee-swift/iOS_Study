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
    
// MVVM 리팩토링 : stream은 모두 제거
// View는 stream을 소유할 필요가 없고 알 필요도 없음
    //SearchBar 버튼 탭 이벤트
//    let searchButtonTapped = PublishRelay<Void>()
    // PublishRelay는 PublishSubject를 wrapping하고 있지만 에러는 받지않고 onNext만 내보냄
    // 버튼은 어떠한 값이 전달되진 않고 이벤트만 발생하기 때문에 Void
    
    //SearchBar 외부로 내보낼 이벤트
//    var shouldLoadResult = Observable<String>.of("")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SearchBarViewModel) {
        //Searchbar search button tapped (키보드 검색버튼)
        //button tapped
        
        self.rx.text
            .bind(to: viewModel.queryText)
            .disposed(by: disposeBag)
        
        Observable
            .merge(
                // 아이폰 UI키보드의 '검색'버튼이 눌렸을때의 이벤트
                self.rx.searchButtonClicked.asObservable(),
                // 새로 선언한 searchButton
                searchButton.rx.tap.asObservable()
            )
            .bind(to: viewModel.searchButtonTapped)
            .disposed(by: disposeBag)
        
        viewModel.searchButtonTapped
        // signal로 만들어서 구독한 이후의 값을 방출
            .asSignal()
        // Rx extension으로 커스텀한 endEditing 이벤트 생성
            .emit(to: self.rx.endEditing)
            .disposed(by: disposeBag)
     
// MVVM 리팩토링 : View가 관여하지 않아도 될 코드
// View 바깥에서 view의 로직을 가져갈 코드. View가 직접적으로 알 필요 없음.
        //searchButton이 눌려졌을때 입력된 텍스트를 외부에 연결을 시켜줘야함. 따라서 shouldLoadResult가 어떠한 텍스트를 받을지 연결해줘야함.
//        self.shouldLoadResult = searchButtonTapped
//            .withLatestFrom(self.rx.text) { $1 ?? "" }
//            .filter { !$0.isEmpty }
//            .distinctUntilChanged()
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
