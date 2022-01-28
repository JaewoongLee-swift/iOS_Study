//
//  MainViewController.swift
//  SearchDaumBlog
//
//  Created by 이재웅 on 2022/01/14.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    
//    MVVM 리팩토링
    let listView = BlogListView()
    let searchBar = SearchBar()
//
//    let alertActionTapped = PublishRelay<AlertAction>()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super .init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Rx코드를 작성할 바인드 코드
    // 갖가지 UIControl과 UI component에 대한 바인딩 작업을 할 예정
    func bind(_ viewModel: MainViewModel) {
        listView.bind(viewModel.blogListViewModel)
        searchBar.bind(viewModel.searchBarViewModel)
        
//        MVVM 리팩토링 : 네트워크 로직은 View가 알 필요 없음
        /*
        let blogResult = searchBar.shouldLoadResult
            .flatMapLatest { query in
                SearchBlogNetwork().searchBlog(query: query)
            }
            .share()    // stream을 계속 새로 만드는게 아니라 공유할것이기 때문에 share
        
// blogResult의 타입이 DKBlog와 에러로 나뉘어져 있으니 데이터와 에러로 stream을 분리함
        //optional을 제외한 순수한 Observable<DKBlog>로 나옴
        let blogValue = blogResult
            .compactMap { data -> DKBlog? in
                guard case .success(let value) = data else { return nil }
                
                return value
            }
        
        //error를 가지지만 string으로 받음(출력시킬 수도 있으니!)
        let blogError = blogResult
            .compactMap { data -> String? in
                guard case .failure(let error) = data else { return nil }
                
                return error.localizedDescription
            }
         */
        
//        MVVM 리팩토링 : 네트워크로 가져온 값을 하위 ViewModel로 전달해주면됨
        /*
        //네트워크를 통해 가져온 값을 cellData로 변환
        let cellData = blogValue
            .map { blog -> [BlogListCellData] in
                return blog.documents
                    .map { doc in
                        let thumbnailURL = URL(string: doc.thumbnail ?? "")
                        return BlogListCellData(
                            thumbnailURL: thumbnailURL,
                            name: doc.name,
                            title: doc.title,
                            datetime: doc.datetime
                        )
                    }
            }
        
        //FilterView를 선택했을 때 나오는 alertSheet를 선택했을 때 type
        let sortedType = alertActionTapped
            .filter {
                // title, datetime을 눌렀을 경우 각각의 sorting 타입에 따라 테이블을 정렬하기 위함
                switch $0 {
                case .title, .datetime:
                    return true
                    // 확인, 취소 등 나머지 버튼들은 무시
                default:
                    return false
                }
            }
            //시작값은 title (아무도 필터버튼을 누르지 않았을 경우, 테이블이 처음 정렬하는 순서는 title로)
            .startWith(.title)
        
        //MainViewController -> ListView
        Observable
            .combineLatest(
                sortedType,
                cellData
            ) { type, data -> [BlogListCellData] in
                switch type {
                case .title:
                    return data.sorted { $0.title ?? "" < $1.title ?? "" }
                case .datetime:
                    return data.sorted { $0.datetime ?? Date() > $1.datetime ?? Date() }
                default:
                    return data
                }
            }
            .bind(to: listView.cellData)
            .disposed(by: disposeBag)
         */
        
//        MVVM 리팩토링 : Sorting, Error 메세지도 모두 가져옴
        /*
        let alertSheetForSorting = listView.headerView.sortButtonTapped
            .map { _ -> Alert in
                return (title: nil, message: nil, actions: [.title, .datetime, .cancel], style: .actionSheet)
            }
        
        let alertForErrorMessage = blogError
            .map { message -> Alert in
                return (
                    title: "앗!",
                    message: "예상치 못한 오류가 발생했습니다. 잠시 후 다시 시도해주세요. \(message)",
                    actions: [.confirm],
                    style: .alert
                )
            }
         */
        
        // 기존 alert메세지와 함께 에러가 발생했을 때도 alert가 발생할 수 있도록 merge()를 이용해 묶어줌
//        Observable
//            .merge(
//                alertSheetForSorting,
//                alertForErrorMessage
//            )
        viewModel.shouldPresentAlert
//            .asSignal(onErrorSignalWith: .empty())
            .flatMapLatest { alert -> Signal<AlertAction> in
                let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: alert.style)
                return self.presentAlertController(alertController, actions: alert.actions)
            }
            .emit(to: viewModel.alertActionTapped)
            .disposed(by: disposeBag)
    }
    
    //View를 꾸미는 코드
    private func attribute() {
        title = "다음 블로그 검색"
        view.backgroundColor = .white
    }
    
    //layout 함수
    private func layout() {
        [searchBar, listView].forEach { view.addSubview($0) }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        listView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

//Alert
extension MainViewController {
    typealias Alert = (title: String?, message: String?, actions: [AlertAction], style: UIAlertController.Style)
    
    enum AlertAction: AlertActionConvertible {
        case title, datetime, cancel
        case confirm
        
        var title: String {
            switch self {
            case .title:
                return "Title"
            case .datetime:
                return "Datetime"
            case .cancel:
                return "취소"
            case .confirm:
                return "확인"
            }
        }
        
        var style: UIAlertAction.Style {
            switch self {
            case .title, .datetime:
                return .default
            case .cancel, .confirm:
                return .cancel
            }
        }
    }
    
    func presentAlertController<Action: AlertActionConvertible>(_ alertController: UIAlertController, actions: [Action]) -> Signal<Action> {
        if actions.isEmpty { return .empty()}
        return Observable
            .create {[weak self] observer in
                guard let self = self else { return Disposables.create() }
                for action in actions {
                    alertController.addAction(
                        UIAlertAction(
                            title: action.title,
                            style: action.style,
                            handler: { _ in
                                observer.onNext(action)
                                observer.onCompleted()
                            }
                        )
                    )
                }
                self.present(alertController, animated: true, completion: nil)
                
                return Disposables.create {
                    alertController.dismiss(animated: true, completion: nil)
                }
            }
            .asSignal(onErrorSignalWith: .empty())
    }
}
