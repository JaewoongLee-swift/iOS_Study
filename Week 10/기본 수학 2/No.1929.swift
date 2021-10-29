//
//  no.1929.swift
//  BackJoonStudy
//
//  Created by 이재웅 on 2021/10/29.
//

let MN = readLine()!.split(separator: " ").map{Int($0)!}
let M = MN[0]
let N = MN[1]

var nums = [Int](repeating: 0, count: N+1)

for i in 2...N {
    nums[i] = i
}
for j in 2...N {
    if nums[j] != 0 {
//        for k in stride(from: j+j, to: N+1, by: j) {
//                nums[k] = 0
//        }
        for k in 2...N {
            if j*k > N {
                break
            } else {
                nums[j*k] = 0
            }
        }
    }
}
for i in M...N {
    if nums[i] != 0 {
        print(nums[i])
    }
}

// 참고
// 출처 : https://sapjilkingios.tistory.com/43
// 에라토스테네스의 채 : https://www.youtube.com/watch?v=5ypkoEgFdH8&t=498s
// stride 메소드 : https://zeddios.tistory.com/73
// continue :  https://atelier-chez-moi.tistory.com/19
