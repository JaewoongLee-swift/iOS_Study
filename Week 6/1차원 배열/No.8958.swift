//
//  main.swift
//  BackJoonStudy
//
//  Created by 이재웅 on 2021/09/18.
//

let n = Int(readLine()!)!
var score = 0
// OX퀴즈 결과 합산점수
var count = 0
// 연속으로 정답시, 연속횟수 카운트 변수
for _ in 0..<n {
    let quiz = Array(String(readLine()!))
    for i in 0..<quiz.count {
        // OX문제 element 수만큼 OX의 수를 판별함
        if quiz[i] == "O" {
            // element가 O 일경우
            count += 1
            // 연속횟수 카운트가 1 올라가고, 다음 OX판별 for문에서 다시 맞을경우 또 1이 올라간다
            score += count
            // 각 element마다 count만큼 점수를 더해줌
        } else {
            count = 0
            // X가 나올경우 연속횟수 카운트 초기화
        }
    }
    print(score)
    count = 0
    score = 0
    // 다음문제를 위한 count, score 변수 초기화
}
