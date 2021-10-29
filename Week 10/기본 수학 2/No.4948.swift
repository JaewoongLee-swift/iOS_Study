//
//  no.4948.swift
//  BackJoonStudy
//
//  Created by 이재웅 on 2021/10/29.
//

while true {
    let N = Int(readLine()!)!
    if N == 0 {
        break
    } else {
        var nums = [Int](repeating: 0, count: (N*2)+1)
        for i in 2...N*2 {
            nums[i] = i
        }
        for j in 2...N*2 {
            if nums[j] != 0 {
                for k in stride(from: j+j, to: (N*2)+1, by: j) {
                        nums[k] = 0
                }
            }
        }
        var i = 0
        for num in N+1...N*2 {
            if nums[num] != 0 {
                i += 1
            }
        }
        print(i)
    }
}

