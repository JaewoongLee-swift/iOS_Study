//
//  main.swift
//  BackJoonStudy
//
//  Created by 이재웅 on 2021/09/18.
//
import Foundation
// String(format: , ) 함수를 사용하기 위해 Foundation Framwork를 import
let c = Int(readLine()!)!
for _ in 0..<c{
    let Case = readLine()!.split(separator: " ").map{Double($0)!}
    let n = Case[0]
    var sum = 0.0
    var count = 0.0
    // 소수점까지 계산하기 위해 readline() 입력값, 변수 sum, count 모두 double형으로 선언
    for i in 1..<Case.count {
        sum += Case[i]
    }
    let avg = sum / n
    for i in 1..<Case.count {
        if Case[i] > avg {
            count += 1
        }
    }
    // 평균보다 큰 점수를 count 변수로 체크
    let percent = String(format: "%.3f", count/n*100)
    print("\(percent)%")
}

