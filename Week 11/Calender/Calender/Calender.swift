//
//  Calender.swift
//  Calender
//
//  Created by 이재웅 on 2021/11/08.
//

import Foundation
import UIKit

class CalendarAlgorithm {
    var yearMonthLabel: UILabel
    var dayLabel: UILabel
    
    let now = Date()
    var cal = Calendar.current
    let dateFormatter = DateFormatter()
    var components = DateComponents()
    var weeks = ["일", "월", "화", "수", "목", "금", "토"]
    var days: [String] = []
    var daysCountInMonth = 0 // 해당 월이 며칠까지 있는지
    var weekdayAdding = 0 // 시작일
    
    private func setupCalendar() {
        dateFormatter.dateFormat = "yyyy년M월" // 월 표시 포맷 설정
        components.year = cal.component(.year, from: now)
        components.month = cal.component(.month, from: now)
        components.day = 1
//        self.calculation()
    }
    
    // 월 별 일 수 계산
    private func calculation() {
        let firstDayOfMonth = cal.date(from: components)
        
        // 해당 수로 반환됨. 1 = 월요일, 7 = 토요일
        let firstWeekday = cal.component(.weekday, from: firstDayOfMonth!)
        daysCountInMonth = cal.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
        weekdayAdding = 2 - firstWeekday
        
        self.yearMonthLabel.text = dateFormatter.string(from: firstDayOfMonth!)
        
        self.days.removeAll()
        for day in weekdayAdding...daysCountInMonth {
            if day < 1 { // 1보다 작을 경우는 지난달 일수이기 때문에 빈값
                self.days.append("")
            } else {
                self.days.append(String(day))
            }
        }
    }
}

