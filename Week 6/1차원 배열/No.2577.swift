//
//  main.swift
//  BackJoonStudy
//
//  Created by 이재웅 on 2021/09/16.
//

let a = Int(readLine()!)!
let b = Int(readLine()!)!
let c = Int(readLine()!)!

let num = Array(String(a*b*c))
// a*b*c 값을 String으로 변환하고 각각의 숫자값을 가지는 배열로 변환
for i in 0...9 {
    // for문의 지역변수 i를 통해 0부터 9까지 반복함
    var count = 0
    // 지역변수 count를 통해 i가 num 배열에 해당하는 숫자가 몇개 있는지 카운트함
    for index in num.indices {
        if String(num[index]) == "\(i)" {
            count += 1
        }
    }
    print(count)
    // 각 숫자 i마다 몇개있는지 카운트되고 count를 출력
    // 그리고 for문을 통해 그 다음숫자를 카운트하고 출력하는것을 반복
}

