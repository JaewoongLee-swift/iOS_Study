//
//  main.swift
//  BackJoonStudy
//
//  Created by 이재웅 on 2021/09/16.
//

let N = Int(readLine()!)!
let data = readLine()!.split(separator: " ").map{Int(String($0))!}
print(data.min()!, data.max()!)
// max(), min() 메소드는 해당 sequence의 최대, 최소값을 리턴한다.
// 해당 Sequence에 element가 없을 경우 nil값을 리턴한다.
// 따라서 옵셔널값을 리턴하기 때문에 옵셔널 바인딩을 해준다.


