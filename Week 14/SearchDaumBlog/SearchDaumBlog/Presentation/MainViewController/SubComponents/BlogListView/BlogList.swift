//
//  BlogList.swift
//  SearchDaumBlog
//
//  Created by 이재웅 on 2022/01/17.
//

import UIKit
import RxSwift
import RxCocoa


class BlogListView: UITableView {
    let disposeBag = DisposeBag()
    
    let headerView = FilterView(
        frame: CGRect(
            origin: .zero,
            // width설정 : 어떤 디바이스의 너비에도 맞게 설정함
            size: CGSize(width: UIScreen.main.bounds.width, height: 60.0)
        )
    )
    
//    MVVM 리팩토링
    //MainViewController -> BlogListView
//    let cellData = PublishSubject<[BlogListCellData]>()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: BlogListViewModel) {
        headerView.bind(viewModel.filterViewModel)
        
        viewModel.cellData                                // delegate의 cellForRows함수를 Rx로 표현한 것
//            .asDriver(onErrorJustReturn: []) 이미 driver로 전환함
            .drive(self.rx.items) { tableView, row, data in
                let index = IndexPath(row: row, section: 0)
                let cell =  tableView.dequeueReusableCell(withIdentifier: "BlogListCell", for: index) as? BlogListCell
                cell?.setData(data)
                
                return cell ??  UITableViewCell()
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.backgroundColor = .white
        self.register(BlogListCell.self, forCellReuseIdentifier: "BlogListCell")
        self.separatorStyle = .singleLine
        self.rowHeight = 100.0
        self.tableHeaderView = headerView
    }
}
