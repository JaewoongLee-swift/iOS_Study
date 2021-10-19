//
//  no.1712.swift
//  BackJoonStudy
//
//  Created by 이재웅 on 2021/10/14.
//

let input = readLine()!.split(separator: " ").map {Int($0)!}
// input[0] = 고정비용, input[1] = 생산비용, input[2] = 판매가격
if input[1] >= input[2] {
    // 생산비용이 판매가와 같거나 높을경우 손익분기점을 넘길 수 없음
    print(-1)
} else {
    // 고정비/(판매가-생산비용) = 원금회복을 위한 판매량(정수 또는 소수점)인데, Int형이기 때문에 소숫점 버림
    // 고정비/(판매가-생산비용)에 1을 더하면 손익분기점을 넘는 판매량이 됨
    print((input[0]/(input[2]-input[1]))+1)
}
