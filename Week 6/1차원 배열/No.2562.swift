//
//  main.swift
//  BackJoonStudy
//
//  Created by 이재웅 on 2021/09/16.
//

var data: [Int] = []
for _ in 0..<9 {
    let num = Int(readLine()!)!
    data.append(num)
}
print("\(data.max()!)\n\(data.firstIndex(of: data.max()!)!+1)")
// firstIndex(of:) 메소드는 collection내에서 매개변수(parameter) element를 나타내는 첫번째 index를 리턴한다.
// parameter element가 collection 내에 없을 경우, nil을 리턴하기 때문에 옵셔널값을 리턴한다.

