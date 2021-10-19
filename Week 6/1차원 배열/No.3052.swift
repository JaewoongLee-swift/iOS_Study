//
//  main.swift
//  BackJoonStudy
//
//  Created by 이재웅 on 2021/09/16.
//

var output: [Int] = []
// 42로 나눈 후 각각 다른 나머지들을 저장할 배열
for _ in 0...9 {
    let input = Int(readLine()!)!
    let num = input % 42
    if !output.contains(num) {  // 나머지가 output배열에 존재하지 않는 수일 경우 배열에 추가함
        output.append(num)
    }
}
print(output.count)
// 배열의 요소들의 갯수는 각기 다른 나머지들의 개수

