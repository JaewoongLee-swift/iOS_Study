//
//  main.swift
//  BackJoonStudy
//
//  Created by 이재웅 on 2021/09/18.
//
let n = Double(readLine()!)!
let scores = readLine()!.split(separator: " ").map{Double($0)!}
var newScore: Double = 0

for score in scores {
    newScore += score/(scores.max()!)*100
    // 새롭게 계산한 점수를 변수 newScore에 더함
}

print(newScore/n)
// 새롭계 계산한 점수들의 합을 과목의 개수 n으로 나눠 평균을 출력
