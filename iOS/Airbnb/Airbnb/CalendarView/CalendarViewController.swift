//
//  CalendarViewController.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/02.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    private var startDay: IndexPath?
    private var endDay: IndexPath?
    
    private let weekDayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let calendarManager = CalendarManager()
    private let calendarCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterContainerView.layer.cornerRadius = 10
        view.backgroundColor = view.backgroundColor!.withAlphaComponent(0.5)
        
        setObserver()
        setTitle()
        setWeekDayStackView()
        setCalendarCollectionView()
    }
    
    private func setObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(closeButtonClicked),
                                               name: .CloseButtonClicked,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(dateSelected),
                                               name: .DateSelected,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(resetButtonClicked),
                                               name: .ResetButtonClicked,
                                               object: nil)
    }
    
    private func setCalendarCollectionView() {
        calendarCollectionView.register(UINib(nibName: "CalendarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "dayCell")
        calendarCollectionView.register(CalendarHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
        
        calendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterContainerView.addSubviewInFilterView(view: calendarCollectionView)
        calendarCollectionView.topAnchor.constraint(equalTo: weekDayStackView.bottomAnchor).isActive = true
        calendarCollectionView.leadingAnchor.constraint(equalTo: weekDayStackView.leadingAnchor).isActive = true
        calendarCollectionView.trailingAnchor.constraint(equalTo: weekDayStackView.trailingAnchor).isActive = true
        calendarCollectionView.bottomAnchor.constraint(equalTo: filterContainerView.filterView.bottomAnchor).isActive = true
        calendarCollectionView.backgroundColor = .systemBackground
    }
    
    private func setTitle() {
        filterContainerView.setTitle(text: "체크인 - 체크아웃")
    }
    
    private func setWeekDayStackView() {
        filterContainerView.addSubviewInFilterView(view: weekDayStackView)
        weekDayStackView.topAnchor.constraint(equalTo: filterContainerView.filterView.topAnchor).isActive = true
        weekDayStackView.leadingAnchor.constraint(equalTo: filterContainerView.filterView.leadingAnchor).isActive = true
        weekDayStackView.trailingAnchor.constraint(equalTo: filterContainerView.filterView.trailingAnchor).isActive = true
        weekDayStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        for weekDay in CalendarManager.daysArr {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 15)
            label.text = weekDay
            label.textColor = .lightGray
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            weekDayStackView.addArrangedSubview(label)
        }
    }
    
    @IBOutlet weak var filterContainerView: FilterContainerView!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func dateSelected() {
        let startMonth = calendarManager.monthInfo(of: startDay!.section)
        let endMonth = calendarManager.monthInfo(of: endDay!.section)
        if startMonth.year == endMonth.year {
            filterContainerView.setTitle(text: "\(startMonth.month)월 \(startDay!.item - (startMonth.startOfMonth - 2))일 - \(endMonth.month)월 \(endDay!.item - (endMonth.startOfMonth - 2))일")
        } else {
            filterContainerView.setTitle(text: "\(startMonth.year)년 \(startMonth.month)월 \(startDay!.item - (startMonth.startOfMonth - 2))일 - \(endMonth.year)년 \(endMonth.month)월 \(endDay!.item - (endMonth.startOfMonth - 2))일")
        }
        calendarCollectionView.reloadData()
    }
    
    @objc func resetButtonClicked() {
        startDay = nil
        endDay = nil
        filterContainerView.setTitle(text: "체크인 - 체크아웃")
        calendarCollectionView.reloadData()
    }
}

extension CalendarViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return calendarManager.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let month = calendarManager.monthInfo(of: section)
        return month.totalDays + month.startOfMonth - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as? CalendarCollectionViewCell else {return UICollectionViewCell()}
        let month = calendarManager.monthInfo(of: indexPath.section)
        if indexPath.item >= month.startOfMonth - 1 {
            let today = indexPath.item - (month.startOfMonth - 2)
            if indexPath.section == 0 && calendarManager.today() > today{
                cell.isUserInteractionEnabled = false
                cell.dayLabel.textColor = .lightGray
            }
            cell.dayLabel.text = "\(today)"
        } else {
            cell.isHidden = true
        }
        
        guard let start = startDay else {return cell}
        
        if start == indexPath {
            cell.selected()
            cell.rightView.backgroundColor = UIColor(named: "CustomGray")
        }
        
        guard let end = endDay else {return cell}
        
        if end == indexPath {
            cell.selected()
            cell.leftView.backgroundColor = UIColor(named: "CustomGray")
        }
        
        if indexPath < end && indexPath > start {
            cell.rightView.backgroundColor = UIColor(named: "CustomGray")
            cell.leftView.backgroundColor = UIColor(named: "CustomGray")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width / 7)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as? CalendarHeaderView else {
                return UICollectionReusableView()
            }
            let month = calendarManager.monthInfo(of: indexPath.section)
            headerView.monthLabel.text = "\(month.year)년 \(month.month)월"
            return headerView
        }
        
        return UICollectionReusableView()
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 7, height: collectionView.frame.width / 7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if calendarManager.count - 1 == indexPath.section {
            let startSection = calendarManager.count
            calendarManager.addYearInfo()
            collectionView.insertSections(IndexSet(startSection..<calendarManager.count))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell else {return}
        if startDay == nil {
            startDay = indexPath
            cell.selected()
        } else if endDay == nil {
            guard let start = startDay, start != indexPath else {return}
            endDay = indexPath
            if startDay! > endDay! {
                endDay = startDay
                startDay = indexPath
            }
            cell.selected()
            NotificationCenter.default.post(name: .DateSelected,
                                            object: nil)
        } else {
            NotificationCenter.default.post(name: .ResetButtonClicked,
                                            object: nil)
            startDay = indexPath
            cell.selected()
        }
    }
}

extension Notification.Name {
    static let DateSelected = Notification.Name("DateSelected")
}
