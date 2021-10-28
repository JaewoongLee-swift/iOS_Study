//
//  no.11653.swift
//  BackJoonStudy
//
//  Created by 이재웅 on 2021/10/14.
//

var N = Int(readLine()!)!
if N != 1 {
    if N == 2 || N == 3 {
        print(N)
    }
    else {
        var i = 2
        while i <= N {
            if N == 1 {
                break
            } else if N % i == 0 {
                print(i)
                N = N / i
                i = 1
            }
            i += 1
        }
    }
}

