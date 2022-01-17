//
//  CalenderViewController.swift
//  Calender
//
//  Created by 이재웅 on 2021/11/05.
//

import UIKit
import SnapKit

class CalenderViewController: UIViewController {
    lazy var calender = Calender()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .systemBackground
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CalenderCollectionCell.self, forCellWithReuseIdentifier: "CalenderCollectionCell")
        collectionView.register(CalenderCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CalenderCollectionHeaderView")
        
        return collectionView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CalenderTableViewCell.self, forCellReuseIdentifier: "CalenderTableViewCell")
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        calender.setupCalendar()
    }
}

//------------------------------------------------------------------------------------------
// CollectionView Delegate
//------------------------------------------------------------------------------------------

extension CalenderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let myBoundSize: CGFloat = UIScreen.main.bounds.size.width
        let cellSize: CGFloat = myBoundSize / 9
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 40.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let value: CGFloat = 8.0
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
}

extension CalenderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return calender.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalenderCollectionCell", for: indexPath) as? CalenderCollectionCell
        
        cell?.setupSubViews()
        cell?.dataLabel.text = calender.days[indexPath.row]
        
        if indexPath.row % 7 == 0 {
            cell?.dataLabel.textColor = .red
        } else if indexPath.row % 7 == 6 {
            cell?.dataLabel.textColor = .blue
        } else {
            cell?.dataLabel.textColor = .black
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "CalenderCollectionHeaderView",
                for: indexPath
              ) as? CalenderCollectionHeaderView
        else { return UICollectionReusableView() }
        
        header.previousButton.addTarget(self, action: #selector(didTapPrevButton), for: .touchUpInside)
        header.nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        header.setupViews(Calendar: calender)
        
        return header
    }
    
}

//------------------------------------------------------------------------------------------
// TableView Delegate
//------------------------------------------------------------------------------------------

extension CalenderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableview is selected: number \(indexPath.row)")
    }
}

extension CalenderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CalenderTableViewCell", for: indexPath) as? CalenderTableViewCell else { return UITableViewCell() }
        
        cell.setSubViews()
        
        return cell
    }
}

//------------------------------------------------------------------------------------------
// etc
//------------------------------------------------------------------------------------------

extension CalenderViewController {
    @objc func didTapPrevButton() {
        if let month = self.calender.components.month {
            self.calender.components.month = month - 1
        }
        self.calender.calculation()
        self.collectionView.reloadData()
    }
    
    @objc func didTapNextButton() {
        if let month = self.calender.components.month {
            self.calender.components.month = month + 1
        }
        self.calender.calculation()
        self.collectionView.reloadData()
    }
    
    func setupView() {
        let height: CGFloat = ( UIScreen.main.bounds.size.width / 9 + 16) * 7 + 40.0
        
        [collectionView, tableView].forEach { view.addSubview($0) }
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(height)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(collectionView.snp.bottom)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
