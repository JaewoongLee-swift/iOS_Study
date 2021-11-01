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

/*
 4 2 2
 6 3 3
 8 5 3              5 3 << 가장 작은 차의 소수들로 더해진 수
 10 5 5
 12 7 5         6 6 7 5
 14 7 7
 16 11 5*           8 8 > 9 7 > 10 6 > 11 5
 18 11 7
 20 13 7
 22 11 11
 24 13 11
 26 13 13
 28 17 11*
 30 17 13
 32 19 13
 34 17 17
 */
