//
//  no.1978.swift
//  BackJoonStudy
//
//  Created by 이재웅 on 2021/10/14.
//

// 주어진 수 number
// 1. 짝수일 경우, 소수 x
// 2. 1보다 크고 number보다 작은 정수로 나눴을 때 나머지가 0인 경우, 소수 x
//

let N = readLine()!
let numbers = readLine()!.split(separator: " ").map{Int($0)!}
var count = 0

for number in numbers {
    if number == 2 || number == 3{
        count += 1
    }
    else if number != 1, number%2 == 1 {
        var i = 3
        while i < number {
            if number % i == 0 {
                break
            }
            else if i == (number-1) {
                count += 1
            }
            i += 1
        }
    }
}
print(count)
