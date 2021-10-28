//
//  no.2581.swift
//  BackJoonStudy
//
//  Created by 이재웅 on 2021/10/14.
//

// 주어진 수 number
// 1. 짝수일 경우, 소수 x
// 2. 1보다 크고 number보다 작은 정수로 나눴을 때 나머지가 0인 경우, 소수 x
//
let M = Int(readLine()!)!
let N = Int(readLine()!)!
var numbers: [Int] = []
var sum = 0

for number in M...N {
    if number == 2 || number == 3{
        numbers.append(number)
    }
    else if number != 1, number%2 == 1 {
        var i = 3
        while i < number {
            if number % i == 0 {
                break
            }
            else if i == (number-1) {
                numbers.append(number)
            }
            i += 1
        }
    }
}

if numbers.count == 0 {
    print(-1)
} else {
    for i in numbers {
        sum += i
    }
    print(sum)
    print(numbers.min()!)
}

