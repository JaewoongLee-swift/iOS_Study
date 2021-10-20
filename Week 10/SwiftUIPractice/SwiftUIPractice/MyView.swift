//
//  MyView.swift
//  SwiftUIPractice
//
//  Created by 이재웅 on 2021/10/20.
//

import SwiftUI

struct MyView: View {
    //View protocol의 필수사항 : body를 정의해야함
    //SwiftUI의 View는 업데이트 할 때마다 body 속성을 읽게됨. 업데이트 되는 View는 사용자의 입력, 시스템 이벤트에 대한 응답으로 View 수명동안 반복적으로 행함. View가 반환하는 값은 곧 SwiftUI가 화면에 그리는 요소
    
    let helloFont: Font
    var body: some View { // 정확한 유형을 명시적으로 선언하지 않고 알아서 알게됨.
        VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .font(helloFont)
                Text("만나서 반가워요")
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView(helloFont: .title)
    }
}
