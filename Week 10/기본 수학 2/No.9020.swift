//
//  no.9020.swift
//  BackJoonStudy
//
//  Created by 이재웅 on 2021/10/31.
//

func isPrimeNumber(number: Int) -> Bool {
    var i = 2
    if number == 2 {
        return true
    } else {
        if number % i == 0 {
            return false
        } else {
            var NisPrimeNumber = false
            while i < number {
                if number % i == 0 {
                    break
                }
                else if i == (number-1) {
                    NisPrimeNumber = true
                    break
                }
                i += 1
            }
            return NisPrimeNumber
        }
    }
}

let T = Int(readLine()!)!

for _ in 0..<T {
    let n = Int(readLine()!)!
    var N = n / 2
    var minusN = N

    if N == 2 {
        print("\(N) \(N)")
    }
    else {
        while !isPrimeNumber(number: N) || !isPrimeNumber(number: minusN){
            N += 1
            minusN -= 1
        }
        print("\(minusN) \(N)")
    }
}

/*
 1. n/2 = N 값이 나옴
 2. N이 소수인지 아닌지 판별 (isPrimeNumber메소드 이용)
 3-1. 소수일 경우, N 출력 후 종료
 3-2. 소수가 아닐 경우. N+1, minusN-1
 4. N, minusN이 소수인지 아닌지 판별 (isPrimeNumber메소드 이용)
 5-1. 소수일 경우, N, minusN 출력 후 종료
 5-2. 소수가 아닐 경우. N+1, minusN-1 후 4번으로 복귀
 */
